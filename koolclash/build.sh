#!/bin/sh

# build script for rogsoft project

MODULE="koolclash"
VERSION="0.18"
TITLE="KoolClash for merlin"
DESCRIPTION="基于规则的代理程序 Clash"
HOME_URL="Module_koolclash.asp"
TAGS="网络 安全"
AUTHOR="KevinWee"
LINK="https://github.com/Dreamacro/clash"

# Check and include base
DIR="$( cd "$( dirname "$BASH_SOURCE[0]" )" && pwd )"

# now include build_base.sh
. $DIR/../softcenter/build_base.sh

# change to module directory
cd $DIR

# do something here
do_build_result
