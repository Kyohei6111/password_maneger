#!/bin/zsh

read search_name
search_service_num=$(grep "サービス名："$search_name password.txt | wc -l)
echo $search_service_num
if [ $search_service_num -eq 1 ]; then
echo 成功！
fi