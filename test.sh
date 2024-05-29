#!/bin/zsh

a=1
a=""
echo $a

if [ -z $a ]; then
    echo 成功
else
    echo 失敗
fi

