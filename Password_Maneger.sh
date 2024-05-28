#!/bin/zsh

echo "パスワードマネージャーへようこそ！"
echo "次の選択肢から入力してください(Add Password/Get Password/Exit):"

read selection

if [ $selection = "Add Password" ]; then
    echo "サービス名を入力してください！"
    read service_name

    echo "ユーザー名を入力してください！"
    read user_name

    echo "パスワードを入力してください！"
    read password

    echo サービス名：$service_name >> password.txt
    echo $service_nameのユーザー名：$user_name >> password.txt
    echo $service_nameのパスワード：$password >> password.txt
    echo "------------------------" >> password.txt

    echo Thank you
elif [ $selection = "Get Password" ] ; then
    echo サービス名を入力してください：
    read search_name
    search_name_num=${#search_name}
    search_name_num=$((search_name_num+2))
    grep "サービス名：$search_name" password.txt
    grep "$search_nameのユーザー名：" password.txt | cut -c ${search_name_num}-
    grep "$search_nameのパスワード：" password.txt | cut -c ${search_name_num}-
fi