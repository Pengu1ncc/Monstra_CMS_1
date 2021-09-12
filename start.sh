#!/bin/sh
# 重启服务
service php7.4-fpm restart
service apache2 restart

sed -i "s/test_flag/$FLAG/g" /home/penguincc/flag
export FLAG=not_flag
FLAG=not_flag
# 永不退出的进程
tail -f /var/log/1.txt