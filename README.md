```shell
F_debFs=/tmp/debianfs-arm64-full
#github通常需要科学上网，可手工下载后保存为该文件名
wget https://github.com/tiann/eadb/releases/download/v0.1.6/debianfs-arm64-full.tar.gz -O $F_debFs.tar.gz

F_debFs=$F_debFs D_work=/app4/eadb_work_home/ phone=24846224 bash <(curl https://gitee.com/imagg/tiann--eadb/raw/z/main/main.sh)
#若排查错误， 请修改 "bash" 为 "bash -x"
```