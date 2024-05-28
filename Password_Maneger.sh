#!/bin/zsh

echo "パスワードマネージャーへようこそ！"

echo サービス名を入力してください！
read service_name

echo ユーザー名を入力してください！
read user_name

echo パスワードを入力してください！
read password

echo $service_name >> password.txt
echo $user_name >> password.txt
echo $password >> password.txt
echo "------------------------" >> password.txt


echo Thank you!


