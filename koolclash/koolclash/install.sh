#! /bin/sh
export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
eval $(dbus export koolclash)
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'
IPDB_VERSION=20191029

# 判断路由架构和平台
case $(uname -m) in
	aarch64)
		if [ "`uname -o|grep Merlin`" ] && [ -d "/koolshare" ];then
			echo_date 固件平台【koolshare merlin aarch64 / merlin_hnd】符合安装要求，开始安装插件！
		else
			echo_date 本插件适用于【koolshare merlin aarch64 / merlin_hnd】固件平台，你的平台不能安装！！！
			exit 1
		fi
		;;
	*)
		echo_date 本插件适用于koolshare merlin aarch64固件平台，你的平台：$(uname -m)不能安装！！！
		echo_date 退出安装！
		exit 1
	;;
esac

if [ -n "$(pidof clash)" ]; then
    # 停止 KoolClash
    koolclash_reenable_after_install=1
    echo_date "KoolClash: 检测到 Clash 正在运行..."
    echo_date "KoolClash: 停止 Clash 以更新/安装 KoolClash..."
    echo_date 'KoolClash:【更新 KoolClash 过程中可能会出现「软件中心异常」的提示，是正常现象！】'
    echo_date 'KoolClash:【请不要刷新或关闭页面，务必等待安装完成、页面自动跳转！】'
    sleep 4
    sh $KSROOT/scripts/koolclash_control.sh stop_for_install
    sleep 1
    echo_date "KoolClash: Clash 已经停止，继续更新/安装..."
fi

# 清理 旧文件夹
echo_date "KoolClash: 清理旧版文件..."
rm -rf $KSROOT/bin/clash >/dev/null 2>&1
rm -rf $KSROOT/bin/yq >/dev/null 2>&1
rm -rf $KSROOT/bin/httping >/dev/null 2>&1
rm -rf $KSROOT/scripts/koolclash_* >/dev/null 2>&1
rm -rf $KSROOT/init.d/S99koolclash.sh >/dev/null 2>&1
rm -rf $KSROOT/init.d/N99koolclash.sh >/dev/null 2>&1
rm -rf $KSROOT/webs/Module_koolclash.asp >/dev/null 2>&1
rm -rf $KSROOT/res/icon-koolclash* >/dev/null 2>&1
rm -rf $KSROOT/res/koolclash_* >/dev/null 2>&1
[ -f "/koolshare/webs/files/koolclash.tar.gz" ] && rm -rf /koolshare/webs/files/koolclash.tar.gz >/dev/null 2>&1

# 创建相关的文件夹
echo_date "KoolClash: 创建文件夹..."
mkdir -p $KSROOT/koolclash/config
mkdir -p $KSROOT/init.d

# 检测储存空间是否足够
echo_date 检测jffs分区剩余空间...
SPACE_AVAL=$(df|grep jffs | awk '{print $4}')
SPACE_NEED=$(du -s /tmp/koolclash | awk '{print $1}')
if [ "$SPACE_AVAL" -gt "$SPACE_NEED" ];then
	echo_date 当前jffs分区剩余"$SPACE_AVAL" KB, 插件安装需要"$SPACE_NEED" KB，空间满足，继续安装！
else
	echo_date 当前jffs分区剩余"$SPACE_AVAL" KB, 插件安装需要"$SPACE_NEED" KB，空间不足！
	echo_date 退出安装！
	exit 1
fi

# 复制文件
cd /tmp

echo_date "KoolClash: 复制安装包内的文件到路由器..."

cp -rf /tmp/koolclash/bin/clash-linux-armv8 $KSROOT/bin/clash
cp -rf /tmp/koolclash/bin/yq_linux_arm $KSROOT/bin/yq
cp -rf /tmp/koolclash/bin/httping $KSROOT/bin/httping
cp -rf /tmp/koolclash/scripts/* $KSROOT/scripts/
cp -rf /tmp/koolclash/webs/* $KSROOT/webs/
cp -rf /tmp/koolclash/res/* $KSROOT/res/
cp /tmp/koolclash/uninstall.sh $KSROOT/scripts/uninstall_koolclash.sh

if [ ! -f $KSROOT/koolclash/config/Country.mmdb ]; then
    cp -rf /tmp/koolclash/koolclash/config/Country.mmdb $KSROOT/koolclash/config/Country.mmdb
    dbus set koolclash_ipdb_version=$IPDB_VERSION
fi

# 为新安装文件赋予执行权限...
echo_date "KoolClash: 设置可执行权限"
chmod 755 $KSROOT/bin/*
chmod 755 $KSROOT/scripts/koolclash_*

local_version=$(cat $KSROOT/res/koolclash_.version)
echo_date "KoolClash: 设置版本号为 $local_version..."
dbus set koolclash_version=$local_version

sleep 1

echo_date "KoolClash: 删除相关安装包..."
rm -rf /tmp/koolclash* >/dev/null 2>&1

echo_date "KoolClash: 设置插件信息..."

dbus set softcenter_module_koolclash_description="基于规则的代理程序 Clash"
dbus set softcenter_module_koolclash_install=1
dbus set softcenter_module_koolclash_name=koolclash
dbus set softcenter_module_koolclash_title=koolclash
dbus set softcenter_module_koolclash_version=$local_version

sleep 1

if [ "$koolclash_reenable_after_install" == "1" ]; then
    echo_date 'KoolClash: 重启 Clash...'
    sleep 2
    sh $KSROOT/scripts/koolclash_control.sh start_after_install
    sleep 1
    echo_date 'KoolClash: Clash 重启完成...'
fi

echo_date "KoolClash: 插件安装完成..."

dbus remove koolclash_reenable_after_install
