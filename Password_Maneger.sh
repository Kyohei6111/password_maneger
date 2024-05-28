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
    echo $service_name｜ユーザー名：$user_name >> password.txt
    echo $service_name｜パスワード：$password >> password.txt
    echo "------------------------" >> password.txt

    echo Thank you
elif [ $selection = "Get Password" ] ; then
    echo サービス名を入力してください：
    read search_name
    grep "サービス名：$search_name" password.txt
    grep "$search_name｜ユーザー名：" password.txt | cut -f 2 -d "｜"
    grep "$search_name｜パスワード：" password.txt | cut -f 2 -d "｜"
fi
