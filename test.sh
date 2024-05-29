#!/bin/zsh

read search_name
search_num=1
row_num=$(wc -l password.txt | grep -o '[0-9]*')
echo $row_num

while [ $search_num -le $row_num ]
do
    outcome=$(sed -n ${search_num}p password.txt | grep "サービス名：$search_name")
    echo $outcome
    b="サービス名：$search_name"
    echo $b
    if [ ${outcome} = "サービス名：$search_name" ]; then
         a=$(sed -n ${search_num}p password.txt)
        echo $a
        search_num=$((search_num+1))
        a=$(sed -n ${search_num}p password.txt)
        echo $a
        search_num=$((search_num+1))
        a=$(sed -n ${search_num}p password.txt)
        echo $a
     else
    fi
 search_num=$((search_num+1))
done