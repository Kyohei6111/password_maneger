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

    echo $service_name >> password.txt
    echo $user_name >> password.txt
    echo $password >> password.txt
    echo "------------------------" >> password.txt


    echo Thank you
else
fi
