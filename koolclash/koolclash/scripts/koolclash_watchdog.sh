#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
eval $(dbus export koolclash_)
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'
url="https://sc.ftqq.com/SCU4600Tff285509a1bbef8571bd1d57999bb4f258568a5ed115f.send"

while [ "$koolclash_enable" == "1" ]; do
    echo_date "开始检查进程状态..."

    if [ ! -n "$(pidof clash)" ]; then
        result=`wget --no-check-certificate --post-data "text=RT-AC86U&desp=clash进程崩溃，马上重启啦" -qO- ${url}`
        if [ -n $(echo $result | grep "success") ];then
            echo_date "ServerChan通知消息发送成功"
        fi
        start-stop-daemon -S -q -b -m -p /var/run/koolclash.pid -x /koolshare/bin/clash -- -d $KSROOT/koolclash/config/
        echo_date "重启 Clash 进程"
    fi

    sleep 2
    continue
done
