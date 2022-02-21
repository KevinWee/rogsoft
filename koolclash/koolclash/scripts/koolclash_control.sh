#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
eval $(dbus export koolclash_)
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'
lan_ip=$(nvram get lan_ipaddr)
wan_ip=$(nvram get wan0_ipaddr)

killProcess() {
    if [ -n "$(pidof koolclash_watchdog.sh)" ]; then
        echo_date "关闭 Clash 看门狗..."
        kill -9 $(pidof koolclash_watchdog.sh) >/dev/null 2>&1
    fi
    if [ -n "$(pidof clash)" ]; then
        echo_date "关闭 Clash 进程..."
        killall clash
    fi
}

startClashProcess() {
    tunExist=`lsmod|grep tun|wc -l`
    if [ $tunExist -eq 0 ]; then
        echo_date "创建 TUN 设备..."
        mkdir /dev/net
        mknod /dev/net/tun c 10 200
        modprobe tun
    fi
    echo_date "启动 Clash 进程..."
    if [ -f /var/run/koolclash.pid ];then
        touch /var/run/koolclash.pid
    fi
    start-stop-daemon -S -q -b -m -p /var/run/koolclash.pid -x $KSROOT/bin/clash -- -d $KSROOT/koolclash/config/
}

startClashWatchdog() {
    koolclash_enable=$(dbus get koolclash_enable);
    if [ "${koolclash_enable}"x = "1"x ]; then
        echo_date "启动 Clash 看门狗进程守护..."
        start-stop-daemon -S -q -b -x $KSROOT/scripts/koolclash_watchdog.sh
    fi
}

flushNAT() {
    echo_date "删除 KoolClash 添加的 utun 路由及策略"
    ip rule del fwmark 0x162 table 0x162
    ip route del default dev utun table 0x162
    echo_date "删除 KoolClash 添加的 iptables 规则"

    iptables -t nat -D PREROUTING -p tcp -j koolclash_dns >/dev/null 2>&1
    iptables -t nat -D PREROUTING -p udp -j koolclash_dns >/dev/null 2>&1
    iptables -t mangle -D PREROUTING -j koolclash >/dev/null 2>&1

    nat_indexs=$(iptables -nvL PREROUTING -t nat | sed 1,2d | sed -n '/clash/=' | sort -r)
    for nat_index in $nat_indexs; do
        iptables -t nat -D PREROUTING $nat_index >/dev/null 2>&1
    done

    mangle_indexs=$(iptables -nvL PREROUTING -t mangle | sed 1,2d | sed -n '/clash/=' | sort -r)
    for mangle_index in $mangle_indexs; do
        iptables -t mangle -D PREROUTING $mangle_index >/dev/null 2>&1
    done

    # flush iptables rules
    iptables -t nat -F koolclash_dns >/dev/null 2>&1 && iptables -t nat -X koolclash_dns >/dev/null 2>&1
    iptables -t mangle -F koolclash >/dev/null 2>&1 && iptables -t mangle -X koolclash >/dev/null 2>&1

    #flush_ipset
    echo_date "删除 KoolClash 添加的 ipsets 名单"
    ipset -F koolclash_white >/dev/null 2>&1 && ipset -X koolclash_white >/dev/null 2>&1
    ipset -F koolclash_macblack >/dev/null 2>&1 && ipset -X koolclash_macblack >/dev/null 2>&1

    # set firewall to close 6170 port when 0.0.0.0
    if [ "${koolclash_api_host}"x = "0.0.0.0"x ];then
        iptables -D INPUT -p tcp --dport 6170 -j ACCEPT
    fi
}

applyNAT() {
    # white ip/cidr
    echo_date '应用局域网 IP 白名单'
    ipset -! create koolclash_white nethash && ipset flush koolclash_white
    ip_lan="10.0.0.0/8 100.64.0.0/10 127.0.0.0/8 169.254.0.0/16 172.16.0.0/12 192.168.0.0/16 224.0.0.0/4 240.0.0.0/4 $wan_ip/32"
    for ip in $ip_lan; do
        ipset -! add koolclash_white $ip >/dev/null 2>&1
    done

    if [ ! -z $koolclash_firewall_whiteip_base64 ]; then
        ip_white=$(echo $koolclash_firewall_whiteip_base64 | base64_decode | sed '/\#/d')
        echo_date '应用外网目标 IP/CIDR 白名单'
        for ip in $ip_white; do
            ipset -! add koolclash_white $ip >/dev/null 2>&1
        done
    fi

    # black mac
    echo_date '应用 MAC 地址黑名单'
    ipset -! create koolclash_macblack machash && ipset flush koolclash_macblack
    if [ ! -z $koolclash_firewall_blackmac_base64 ]; then
        mac_black=$(echo $koolclash_firewall_blackmac_base64 | base64_decode | sed '/\#/d')
        for mac in $mac_black; do
            ipset -! add koolclash_macblack $mac >/dev/null 2>&1
            echo_date '应用 MAC 地址黑名单：'$mac
        done
    fi

    # Purpose: Increase nf_conntrack_expect_max to maximum value
    echo_date "开始调整 nf_conntrack_expect_max 参数!"
    echo 352 > /proc/sys/net/netfilter/nf_conntrack_expect_max
    service restart_conntrack >/dev/null 2>&1

    echo_date "开始加载 utun 路由及策略!"
    ip route replace default dev utun table 0x162
    ip rule add fwmark 0x162 table 0x162
    ip route flush cache

    echo_date "开始加载 nat 和 mangle 规则!"
    echo_date "iptables 在 nat 表创建 koolclash_dns 链并添加到 PREROUTING 中"
    iptables -t nat -N koolclash_dns
    iptables -t nat -A PREROUTING -p tcp --dport 53 -d $lan_ip/32 -j koolclash_dns
    iptables -t nat -A PREROUTING -p udp --dport 53 -d $lan_ip/32 -j koolclash_dns
    iptables -t nat -A koolclash_dns -p udp -m set --match-set koolclash_macblack src -j DNAT --to-destination $lan_ip:23453
    iptables -t nat -A koolclash_dns -p tcp -m set --match-set koolclash_macblack src -j DNAT --to-destination $lan_ip:23453

    echo_date "iptables 在 mangle 表创建 koolclash 链并添加到 PREROUTING 中"
    iptables -t mangle -N koolclash
    iptables -t mangle -A PREROUTING -j koolclash
    # IP Whitelist, 包括路由器本机 IP
    iptables -t mangle -A koolclash -m set --match-set koolclash_white dst -j RETURN
    # MAC Blacklist
    iptables -t mangle -A koolclash -m set ! --match-set koolclash_macblack src -j RETURN
    # mark all tcp&udp traffic to utun
    iptables -t mangle -A koolclash -p udp -j RETURN
    iptables -t mangle -A koolclash -p tcp -j MARK --set-mark 0x162
    iptables -t nat -A PREROUTING -p tcp -m mark --mark 0x162 -j REDIRECT --to-ports 23456

    # set firewall to open 6170 port when 0.0.0.0
    if [ "${koolclash_api_host}"x = "0.0.0.0"x ];then
        iptables -I INPUT -p tcp --dport 6170 -j ACCEPT
    fi
}

startKoolclash() {
    ONSTART=$(ps | grep $PPID | grep -v grep | grep "S99koolclash")
    # used by web for start/restart; or by system for startup by S99koolclash.sh in rc.d
    echo_date --------------------- KoolClash: Clash on Koolshare Merlin ----------------------
    [ -n "$ONSTART" ] && echo_date 路由器开机触发 KoolClash 启动！ || echo_date web 提交操作触发 KoolClash 启动！
    echo_date ---------------------------------------------------------------------------------
    # stop first
    flushNAT
    killProcess
    echo_date ---------------------------------------------------------------------------------
    startClashProcess

    sleep 5
    echo_date "检查 Clash 进程是否启动成功..."
    if [ ! -n "$(pidof clash)" ]; then
        # 停止 KoolClash
        echo_date '【Clash 进程启动失败！Clash 配置文件可能存在错误，也有可能是其它原因！】'
        echo_date ------------------------------- KoolClash 启动中断 -------------------------------
        sleep 2
        killProcess
        dbus set koolclash_enable=0
        echo_date ------------------------------- KoolClash 停止完毕 -------------------------------
        exit 1
    else
        echo_date "Clash 进程成功启动！"
    fi
    applyNAT
    dbus set koolclash_enable=1
    startClashWatchdog
    echo_date ------------------------------- KoolClash 启动完毕 -------------------------------
    echo_date 'KoolClash 启动后可能无法立即上网，请先等待 1-2 分钟！'
}

stopKoolclash() {
    echo_date --------------------- KoolClash: Clash on Koolshare Merlin ----------------------
    flushNAT
    killProcess
    dbus set koolclash_enable=0
    echo_date ------------------------------- KoolClash 停止完毕 -------------------------------
}

setAutostart(){
    if [ "${koolclash_enable}"x = "1"x ];then
        [ ! -L "/koolshare/init.d/N99koolclash.sh" ] && ln -sf /koolshare/scripts/koolclash_control.sh /koolshare/init.d/N99koolclash.sh
        [ ! -L "/koolshare/init.d/S99koolclash.sh" ] && ln -sf /koolshare/scripts/koolclash_control.sh /koolshare/init.d/S99koolclash.sh
        echo_date 'KoolClash 设置开机自动启动！'
    else
        rm -rf /koolshare/init.d/N99koolclash.sh >/dev/null 2>&1
        rm -rf /koolshare/init.d/S99koolclash.sh >/dev/null 2>&1
        echo_date 'KoolClash 取消开机自动启动！'
    fi
}

# 强制覆盖 Proxy 的设置
updateProxyConfig() {
    # HTTP 代理端口
    yq w -i $KSROOT/koolclash/config/config.yaml port 7890
    # SOCKS5 代理端口
    yq w -i $KSROOT/koolclash/config/config.yaml socks-port 7891
    # redir-port 配置
    yq w -i $KSROOT/koolclash/config/config.yaml redir-port 23456
    # allow-lan 配置
    yq w -i $KSROOT/koolclash/config/config.yaml allow-lan true
}

# 写入自定义DNS配置、强制覆盖DNS启用、端口，以及 TUN 的设置
updateDnsConfig(){
    if [ ! -f "$KSROOT/koolclash/config/config.yaml" ]; then
        echo_date "没有找到 Clash 配置文件（config.yaml）！请「上传配置文件」或「提交托管 URL」进行配置文件下载！"
    elif [ ! -n "$koolclash_configure_dns" ]; then
        echo_date "没有找到自定义 DNS 配置！请前往「自定义 DNS 配置」提交 DNS 配置！"
    else
        echo_date "找到自定义 DNS 配置！即将写入 Clash 配置文件中..."
        echo_date "删除 Clash 配置文件中原有的 DNS 配置"
        yq d -i $KSROOT/koolclash/config/config.yaml dns

        echo_date "将提交的自定义 DNS 设置写入 Clash 配置文件..."
        # 将 DNS 配置写入 config.yaml 文件
        echo $koolclash_configure_dns | base64 -d >> $KSROOT/koolclash/config/config.yaml
        # 确保启用 DNS
        yq w -i $KSROOT/koolclash/config/config.yaml dns.enable "true"
        # 修改端口
        yq w -i $KSROOT/koolclash/config/config.yaml dns.listen "0.0.0.0:23453"
        if [ $(yq r $KSROOT/koolclash/config/config.yaml dns.enhanced-mode) == 'fake-ip' ]; then
            # Fake IP Range
            yq w -i $KSROOT/koolclash/config/config.yaml dns.fake-ip-range "198.18.0.1/16"
        fi
        echo_date "自定义 DNS 设置写入成功！"
    fi
}

# 强制覆盖 TUN 的设置
updateTunConfig() {
    # 确保启用 TUN
    yq w -i $KSROOT/koolclash/config/config.yaml tun.enable "true"
    # 修改stack
    yq w -i $KSROOT/koolclash/config/config.yaml tun.stack "system"
    echo_date "TUN 设置写入成功！"
}

updateSubscribes(){
    if [ "$koolclash_suburl" == "" ]; then
        dbus remove koolclash_suburl
        echo_date "未找到 Clash 配置文件订阅 URL"
    else
        curl=$(which curl)
        wget=$(which wget)
        if [ "x$wget" != "x" ] && [ -x $wget ]; then
            command="$wget --no-check-certificate $koolclash_suburl -O $KSROOT/koolclash/config/origin.yaml"
        elif [ "x$curl" != "x" ] && [ test -x $curl ]; then
            command="$curl -k $koolclash_suburl -o $KSROOT/koolclash/config/origin.yaml"
        else
            echo_date "没有找到 wget 或 curl，无法更新 Clash 配置文件！"
            return 1;
        fi

        cp $KSROOT/koolclash/config/origin.yaml $KSROOT/koolclash/config/origin-backup.yaml
        rm -rf $KSROOT/koolclash/config/origin.yaml

        $command
        sed -i '/^\-\-\-$/ d' $KSROOT/koolclash/config/origin.yaml
        sed -i '/^\.\.\.$/ d' $KSROOT/koolclash/config/origin.yaml

        if [ "$(yq r $KSROOT/koolclash/config/origin.yaml port | sed 's|[0-9]||g')" == "" ]; then
            # 下载成功了
            rm -rf $KSROOT/koolclash/config/origin-backup.yaml

            # 判断是否存在 DNS 字段、DNS 是否启用、DNS 是否使用 redir-host / fake-ip 模式
            if [ $(yq r $KSROOT/koolclash/config/origin.yaml dns.enable) == 'true' ] && [[ $(yq r $KSROOT/koolclash/config/origin.yaml dns.enhanced-mode) == 'fake-ip' || $(yq r $KSROOT/koolclash/config/origin.yaml dns.enhanced-mode) == 'redir-host' ]]; then
                echo_date "提取 Clash 配置文件中的 DNS 配置"
                dbus set koolclash_configure_dns=$(yq r $KSROOT/koolclash/config/origin.yaml dns|base64)
            else
                echo_date "在 Clash 配置文件中没有找到 DNS 配置！"
            fi
            cp $KSROOT/koolclash/config/origin.yaml $KSROOT/koolclash/config/config.yaml
            echo_date "Clash 配置文件下载完成！"
        else
            # 下载失败了
            rm -rf $KSROOT/koolclash/config/origin.yaml
            cp $KSROOT/koolclash/config/origin-backup.yml $KSROOT/koolclash/config/origin.yaml
            rm -rf $KSROOT/koolclash/config/origin-backup.yml
            echo_date "Clash 配置文件下载失败！"
        fi
    fi
}

uploadClashConfig(){
    # 检测是否能够读取面板上传的 Clash
    if [ -f /tmp/upload/clash.config.yaml ]; then
        echo_date "开始上传配置！"
        mkdir -p $KSROOT/koolclash/config/
        # 将上传的文件复制到 Config 目录中
        cp /tmp/upload/clash.config.yaml $KSROOT/koolclash/config/origin.yaml
        # 删除 tmp 目录中上传的配置文件
        rm -rf /tmp/upload/clash.config.yaml

        sed -i '/^\-\-\-$/ d' $KSROOT/koolclash/config/origin.yaml
        sed -i '/^\.\.\.$/ d' $KSROOT/koolclash/config/origin.yaml
        # 判断是否存在 DNS 字段、DNS 是否启用、DNS 是否使用 redir-host / fake-ip 模式
        if [ $(yq r $KSROOT/koolclash/config/origin.yaml dns.enable) == 'true' ] && [[ $(yq r $KSROOT/koolclash/config/origin.yaml dns.enhanced-mode) == 'fake-ip' || $(yq r $KSROOT/koolclash/config/origin.yaml dns.enhanced-mode) == 'redir-host' ]]; then
            echo_date "提取 Clash 配置文件中的 DNS 配置"
            dbus set koolclash_configure_dns=$(yq r $KSROOT/koolclash/config/origin.yaml dns|base64)
        else
            echo_date "在 Clash 配置文件中没有找到 DNS 配置！"
        fi
        cp $KSROOT/koolclash/config/origin.yaml $KSROOT/koolclash/config/config.yaml
        echo_date "Clash 配置文件上传完成！"
    else
        echo_date "没有找到上传的配置文件！"
    fi
}

updateExternalControls(){
    if [ ! -f "$KSROOT/koolclash/config/config.yaml" ]; then
        echo_date "没有找到 Clash 配置文件（config.yaml）！请「上传配置文件」或「提交托管 URL」进行配置文件下载！"
    else
        echo_date "修改 Clash 配置文件，设置 external-ui 及 external-controller 属性，启用 Clash Dashboard！"
        dbus set koolclash_api_host=${koolclash_api_host:=${lan_ip}};
        dbus set koolclash_api_secret=${koolclash_api_secret:=123456};
        ext_control_ip=$(dbus get koolclash_api_host);
        secret=$(dbus get koolclash_api_secret);

        yq w -i $KSROOT/koolclash/config/config.yaml external-ui "/koolshare/webs/koolclash/"
        yq w -i $KSROOT/koolclash/config/config.yaml external-controller "$ext_control_ip:6170"
        yq w -i $KSROOT/koolclash/config/config.yaml secret $secret

        echo_date "Clash Dashboard 相关设置写入成功！"
    fi
}

updateGeoipDatabase() {
    mkdir -p $KSROOT/koolclash/ipdb
    
    curl=$(which curl)
    wget=$(which wget)
    
    ipdb_url="https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-Country&license_key=${geoipLicenseKey}&suffix=tar.gz";
    
    if [ "x$wget" != "x" ] && [ -x $wget ]; then
        command="$wget --no-check-certificate $ipdb_url -O $KSROOT/koolclash/ipdb.tar.gz"
    elif [ "x$curl" != "x" ] && [ test -x $curl ]; then
        command="$curl -k $ipdb_url -o $KSROOT/koolclash/ipdb.tar.gz"
    else
        echo_date "没有找到 wget 或 curl，无法更新 IP 数据库！"
        exit 1
    fi

    echo_date "开始下载最新 IP 数据库..."
    $command

    if [ ! -f "$KSROOT/koolclash/ipdb.tar.gz" ]; then
        echo_date "下载 IP 数据库失败！"
        exit 1
    fi

    echo_date "下载完成，开始解压"
    tar zxvf $KSROOT/koolclash/ipdb.tar.gz -C $KSROOT/koolclash/ipdb

    chmod 644 $KSROOT/koolclash/ipdb/GeoLite2-Country_*/*
    version=$(ls $KSROOT/koolclash/ipdb | grep 'GeoLite2-Country' | sed "s|GeoLite2-Country_||g")

    cp -rf $KSROOT/koolclash/ipdb/GeoLite2-Country_*/GeoLite2-Country.mmdb $KSROOT/koolclash/config/Country.mmdb

    echo_date "更新 IP 数据库至 $version 版本"
    dbus set koolclash_ipdb_version=$version
    dbus set koolclash_ipdb_licensekey=$geoipLicenseKey

    echo_date "清理临时文件..."
    rm -rf $KSROOT/koolclash/ipdb.tar.gz
    rm -rf $KSROOT/koolclash/ipdb

    echo_date "IP 数据库更新完成，将在下次启动 Clash 时生效！"
}

hasConfigYamlReady(){
    if [ ! -f "$KSROOT/koolclash/config/config.yaml" ]; then
        echo_date "Clash 配置文件（config.yaml）尚未准备好！"
        dbus set koolclash_config_yaml_ready=0;
    else
        echo_date "Clash 配置文件（config.yaml）已经准备好！"
        dbus set koolclash_config_yaml_ready=1;
    fi
}

updateAllNeededConfig(){
    updateSubscribes
    updateProxyConfig
    updateDnsConfig
    updateTunConfig
    updateExternalControls
    hasConfigYamlReady
}

getClashStatus(){
    pid_clash=$(pidof clash)
    if [ -n "$pid_clash" ]; then
        echo "<span>Clash 主进程运行正常！(PID: $pid_clash)</span>"
    else
        echo "<span style='color: red'>Clash 主进程未在运行！</span>"
    fi
}

getClashWatchDogStatus(){
    #pid_watchdog=$(ps | grep koolclash_watchdog.sh | grep -v grep | awk '{print $1}')
    pid_watchdog=$(pidof koolclash_watchdog.sh)
    if [ -n "$pid_watchdog" ]; then
        echo "<span>Clash 看门狗运行正常！(PID: $pid_watchdog)</span>"
    else
        echo "<span style='color: orange'>Clash 看门狗未在运行！</span>"
    fi
}

getChinaStatus(){
    PIDC="`ps|grep httping|grep baidu|grep -v grep|awk '{print $1}'`"
    [ -n "$PIDC" ] && kill -9 $PIDC
	local ret=`httping www.baidu.com -s -Z -c1 -f -t 3 2>/dev/null|sed -n '2p'|sed 's/seq=0//g'|sed 's/([0-9]\+\sbytes),\s//g'`
	local S1=`echo $ret|grep -Eo "200 OK"`
	if [ -n "$S1" ]; then
		local S2=`echo $ret|sed 's/time=//g'|awk '{printf "%.0f ms\n",$(NF -3)}'`
		echo '国内链接 ✓&nbsp;&nbsp;'$S2
	else
		echo '国内链接 <font color='#FF0000'>X</font>'
	fi
}

getForeignStatus(){
    PIDF="`ps|grep httping|grep google|grep -v grep|awk '{print $1}'`"
    [ -n "$PIDF" ] && kill -9 $PIDF
	local ret=`httping www.google.com.tw -x $lan_ip:7890 -s -Z -c1 -f -t 3 2>/dev/null|sed -n '2p'|sed 's/seq=0//g'|sed 's/([0-9]\+\sbytes),\s//g'`
	local S1=`echo $ret|grep -Eo "200 OK"`
	if [ -n "$S1" ]; then
		local S2=`echo $ret|sed 's/time=//g'|awk '{printf "%.0f ms\n",$(NF -3)}'`
		echo '国外链接 ✓&nbsp;&nbsp;'$S2
	else
		echo '国外链接 <font color='#FF0000'>X</font>'
	fi
}

# used by wan-start and nat-start include
case $1 in
start)
    setAutostart
    if [ "$koolclash_enable" == "1" ]; then
        if [ ! -f $KSROOT/koolclash/config/config.yaml ]; then
            logger "[软件中心]: 没有找到 Clash 的配置文件（config.yaml），KoolClash 将会中断启动并回滚操作！"
            stopKoolclash
        elif [ ! -f $KSROOT/koolclash/config/Country.mmdb ]; then
            logger "[软件中心]: 没有找到 GeoLite IP 数据库（Country.mmdb），KoolClash 将会中断启动并回滚操作！"
            stopKoolclash
        else
            if [ $(yq r $KSROOT/koolclash/config/config.yaml dns.enable) == 'true' ] && [[ $(yq r $KSROOT/koolclash/config/config.yaml dns.enhanced-mode) == 'fake-ip' || $(yq r $KSROOT/koolclash/config/config.yaml dns.enhanced-mode) == 'redir-host' ]]; then
                startKoolclash
                logger "[软件中心]: KoolClash 启动完成！"
            else
                logger "[软件中心]: Clash 配置文件中 dns.enable 不为 true 或 dns.enhanced-mode 不为 fake-ip/redir-host，KoolClash 将会中断启动并回滚操作！"
                stopKoolclash
            fi
        fi
    else
        logger "[软件中心]: KoolClash 未设置开机自动启动！"
        stopKoolclash
    fi
    ;;
start_nat)
    logger "[软件中心]: NAT配置更改后重新配置 KoolClash 防火墙策略！"
    flushNAT
    logger "[软件中心]: KoolClash 防火墙策略清扫完成！"
    applyNAT
    logger "[软件中心]: KoolClash 防火墙策略配置完成！"
    ;;
stop)
    logger "[软件中心]: 准备关闭 KoolClash"
    stopKoolclash
    logger "[软件中心]: KoolClash 成功关闭"
    ;;
esac

# used by web submit
case $2 in
start)
    rm -rf /tmp/upload/koolclash_log.txt && touch /tmp/upload/koolclash_log.txt
    sleep 1
    setAutostart >/tmp/upload/koolclash_log.txt
    updateAllNeededConfig >>/tmp/upload/koolclash_log.txt
    sleep 2
    if [ ! -f $KSROOT/koolclash/config/config.yaml ]; then
        echo_date "【没有找到 Clash 的配置文件！】" >>/tmp/upload/koolclash_log.txt
        echo_date "【KoolClash 将会中断启动并回滚操作！】" >>/tmp/upload/koolclash_log.txt
        stopKoolclash >>/tmp/upload/koolclash_log.txt
        echo_date "【请在页面刷新以后重新上传 Clash 配置文件！】" >>/tmp/upload/koolclash_log.txt
        echo_date ------------------ 请不要关闭或者刷新页面！倒计时结束时会自动刷新！ ------------------ >>/tmp/upload/koolclash_log.txt
        echo "XU6J03M6" >>/tmp/upload/koolclash_log.txt
        http_response 'nofile'
    elif [ ! -f $KSROOT/koolclash/config/Country.mmdb ]; then
        echo_date "【没有找到 GeoLite IP 数据库！】" >>/tmp/upload/koolclash_log.txt
        echo_date "【KoolClash 将会中断启动并回滚操作！】" >>/tmp/upload/koolclash_log.txt
        stopKoolclash >>/tmp/upload/koolclash_log.txt
        echo_date "【请在页面刷新以后尝试更新 IP 数据库！】" >>/tmp/upload/koolclash_log.txt
        echo_date ------------------ 请不要关闭或者刷新页面！倒计时结束时会自动刷新！ ------------------ >>/tmp/upload/koolclash_log.txt
        echo "XU6J03M6" >>/tmp/upload/koolclash_log.txt
        http_response 'nofile'
    else
        if [ $(yq r $KSROOT/koolclash/config/config.yaml dns.enable) == 'true' ] && [[ $(yq r $KSROOT/koolclash/config/config.yaml dns.enhanced-mode) == 'fake-ip' || $(yq r $KSROOT/koolclash/config/config.yaml dns.enhanced-mode) == 'redir-host' ]]; then
            startKoolclash >>/tmp/upload/koolclash_log.txt
            echo_date ------------------ 请不要关闭或者刷新页面！倒计时结束时会自动刷新！ ------------------ >>/tmp/upload/koolclash_log.txt
            echo "XU6J03M6" >>/tmp/upload/koolclash_log.txt
            http_response 'success'
        else
            echo_date "【没有找到正确的 DNS 配置或 DNS 配置不合法！】" >>/tmp/upload/koolclash_log.txt
            echo_date "【Clash 配置文件中 dns.enable 不为 true 或 dns.enhanced-mode 不为 fake-ip/redir-host】" >>/tmp/upload/koolclash_log.txt
            echo_date "【KoolClash 将会中断启动并回滚操作！】" >>/tmp/upload/koolclash_log.txt
            stopKoolclash >>/tmp/upload/koolclash_log.txt
            echo_date "【请在页面刷新以后重新上传 Clash 配置文件！】" >>/tmp/upload/koolclash_log.txt
            echo_date ------------------ 请不要关闭或者刷新页面！倒计时结束时会自动刷新！ ------------------ >>/tmp/upload/koolclash_log.txt
            echo "XU6J03M6" >>/tmp/upload/koolclash_log.txt
            http_response 'nodns'
        fi
    fi
    ;;
stop)
    rm -rf /tmp/upload/koolclash_log.txt && touch /tmp/upload/koolclash_log.txt
    sleep 1
    setAutostart >/tmp/upload/koolclash_log.txt
    stopKoolclash >>/tmp/upload/koolclash_log.txt
    echo_date ------------------ 请不要关闭或者刷新页面！倒计时结束时会自动刷新！ ------------------ >>/tmp/upload/koolclash_log.txt
    echo "XU6J03M6" >>/tmp/upload/koolclash_log.txt
    http_response 'success'
    ;;
updateGeoIP)
    rm -rf /tmp/upload/koolclash_log.txt && touch /tmp/upload/koolclash_log.txt
    sleep 1
    geoipLicenseKey=$3
    updateGeoipDatabase >/tmp/upload/koolclash_log.txt
    echo_date ------------------ 请不要关闭或者刷新页面！倒计时结束时会自动刷新！ ------------------ >>/tmp/upload/koolclash_log.txt
    echo "XU6J03M6" >>/tmp/upload/koolclash_log.txt
    http_response 'success'
    ;;
uploadClashConfig)
    rm -rf /tmp/upload/koolclash_log.txt && touch /tmp/upload/koolclash_log.txt
    sleep 1
    uploadClashConfig >/tmp/upload/koolclash_log.txt
    echo_date ------------------ 请不要关闭或者刷新页面！倒计时结束时会自动刷新！ ------------------ >>/tmp/upload/koolclash_log.txt
    echo "XU6J03M6" >>/tmp/upload/koolclash_log.txt
    http_response 'success'
    ;;
getHttpAndProcessStatus)
    log2=$(getChinaStatus)
    log1=$(getForeignStatus)
    text1=$(getClashStatus)
    text2=$(getClashWatchDogStatus)

    http_response "$log1@@$log2@@$text1@@$text2"
    ;;
getDebugInfo)
    koolshare_version=$(cat $KSROOT/.soft_ver)
    clash_version=$($KSROOT/bin/clash -v)
    fallbackdns=$(dbus get koolclash_configure_dns)
    if [ ! -f $KSROOT/koolclash/config/config.yaml ]; then
        clash_allow_lan=''
        clash_ext_controller=''
        clash_redir=''
        clash_dns_enable=''
        clash_dns_ipv6=''
        clash_dns_mode=''
        clash_dns_listen=''
    else
        clash_allow_lan=$(yq r /koolshare/koolclash/config/config.yaml allow-lan)
        clash_ext_controller=$(yq r /koolshare/koolclash/config/config.yaml external-controller)
        clash_redir=$(yq r /koolshare/koolclash/config/config.yaml redir-port)
        clash_dns_enable=$(yq r /koolshare/koolclash/config/config.yaml dns.enable)
        clash_dns_ipv6=$(yq r /koolshare/koolclash/config/config.yaml dns.ipv6)
        clash_dns_mode=$(yq r /koolshare/koolclash/config/config.yaml dns.enhanced-mode)
        clash_dns_listen=$(yq r /koolshare/koolclash/config/config.yaml dns.listen)
    fi

    iptables_mangle=$(iptables -nvL PREROUTING -t mangle | sed 1,2d | grep 'clash' | base64 | base64 | xargs)
    iptables_nat=$(iptables -nvL PREROUTING -t nat | sed 1,2d | grep 'clash' | base64 | base64 | xargs)
    iptables_mangle_clash=$(iptables -nvL koolclash -t mangle | sed 1,2d | base64 | base64 | xargs)
    iptables_nat_clash=$(iptables -nvL koolclash -t nat | sed 1,2d | base64 | base64 | xargs)
    iptables_mangle_clash_dns=$(iptables -nvL koolclash_dns -t mangle | sed 1,2d | base64 | base64 | xargs)
    iptables_nat_clash_dns=$(iptables -nvL koolclash_dns -t nat | sed 1,2d | base64 | base64 | xargs)

    white_ip=$(ipset list koolclash_white | base64 | xargs)
    chromecast_nu=$(iptables -t nat -L PREROUTING -v -n --line-numbers | grep "dpt:53" | base64 | xargs)
    clash_process=$(ps | grep clash | grep -v grep | base64 | xargs)
    clash_config_dir=$(ls -lh /koolshare/koolclash/config | base64 | xargs)
    http_response "{ \\\"lan_ip\\\": \\\"${lan_ip}\\\", \\\"koolshare_version\\\": \\\"$koolshare_version\\\", \\\"clash_allow_lan\\\": \\\"$clash_allow_lan\\\", \\\"clash_ext_controller\\\": \\\"$clash_ext_controller\\\", \\\"clash_dns_enable\\\": \\\"$clash_dns_enable\\\", \\\"clash_dns_ipv6\\\": \\\"$clash_dns_ipv6\\\", \\\"clash_dns_mode\\\": \\\"$clash_dns_mode\\\", \\\"clash_dns_listen\\\": \\\"$clash_dns_listen\\\", \\\"fallbackdns\\\": \\\"$fallbackdns\\\", \\\"iptables_mangle\\\": \\\"$iptables_mangle\\\", \\\"iptables_nat\\\": \\\"$iptables_nat\\\", \\\"iptables_mangle_clash\\\": \\\"$iptables_mangle_clash\\\", \\\"iptables_nat_clash\\\": \\\"$iptables_nat_clash\\\", \\\"iptables_mangle_clash_dns\\\": \\\"$iptables_mangle_clash_dns\\\", \\\"iptables_nat_clash_dns\\\": \\\"$iptables_nat_clash_dns\\\", \\\"clash_redir\\\": \\\"$clash_redir\\\", \\\"firewall_white_ip\\\": \\\"$white_ip\\\", \\\"chromecast_nu\\\": \\\"$chromecast_nu\\\", \\\"clash_process\\\": \\\"$clash_process\\\", \\\"clash_config_dir\\\": \\\"$clash_config_dir\\\", \\\"clash_version\\\": \\\"$clash_version\\\"}"
    ;;
esac
