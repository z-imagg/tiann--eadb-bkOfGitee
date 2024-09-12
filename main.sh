#!/bin/bash

#[使用] F_debFs=/app4/debianfs-arm64-full D_work=/app4/eadb_work_home/ phone=24846224 bash -x <(curl https://gitee.com/imagg/tiann--eadb/raw/z/main/main.sh)

# F_debFs=/app4/debianfs-arm64-full  #.tar.gz
F_debFs_tar=${F_debFs}.tar
F_debFs_targz=${F_debFs_tar}.gz
# D_work=/app4/eadb_work_home/
# phone=24846224


Url_debFs=https://github.com/tiann/eadb/releases/download/v0.1.6/debianfs-arm64-full.tar.gz

errMsg12="file not existed: ${F_debFs_targz}, exit code 12"
[[ -f $F_debFs_targz ]] || { echo $errMsg12; exit 12; }

errMsg13="work home dir 未指定 , exit code 13"
[[ -v D_work ]] || { echo $errMsg13; exit 13; }

errMsg14="phone 未指定, exit code 14"
[[ -v phone ]] || { echo $errMsg14; exit 14; }

rm -fr $D_work && mkdir -p $D_work

D_eadbGitRepo=$D_work/eadb/

git clone https://gitee.com/imagg/tiann--eadb.git   $D_eadbGitRepo

#解包
gunzip --force --keep $F_debFs_targz

D_DebRoot=/data/eadb

adb kill-server
C_adb="adb -s $phone"
$C_adb shell " su -c 'mkdir -p ${D_DebRoot}' "
#推送
D_tmp=/sdcard/
$C_adb push $F_debFs_tar $D_tmp/deb.tar
$C_adb push $D_eadbGitRepo/assets $D_tmp
$C_adb  shell "su -c '[[ ! -f /system/bin/sh ]] && echo error:no file /system/bin/sh'"
$C_adb  shell "su -c 'mv $D_tmp/deb.tar ${D_DebRoot}/deb.tar'"
$C_adb  shell "su -c 'mv $D_tmp/assets/* ${D_DebRoot}/'"
#加执行权限
$C_adb shell "su -c 'chmod +x ${D_DebRoot}/{device-*,run}'"
#解包
$C_adb shell "su -c '${D_DebRoot}/device-unpack'"
#chroot
chroot_cmd="[先进'adb shell',再在'adb shell'内chroot] : $C_adb shell ; su -c '${D_DebRoot}/run ${D_DebRoot}/debian'"
echo $chroot_cmd