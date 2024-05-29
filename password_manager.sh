#!/bin/zsh

echo "パスワードマネージャーへようこそ！"

number=1
#Exitが入力されるまで処理が続くためにwhile構文を挿入
while [ $number -eq 1 ]; 

do

 echo "次の選択肢から入力してください(Add Password/Get Password/Exit):"

 read selection
 #Add Passwordがにゅうちょくされたときの処理
 if [ $selection = "Add Password" ]; then
 #念の為変数をリセット
   service_name=""
   user_name=""
   password=""

#ここからサービス名の入力・空欄の場合はエラーが出るように設定
   while [ -z $service_name ];
   do
    echo "サービス名を入力してください！"
    read service_name
    #入力が空欄の場合
    if [ -z $service_name ]; then
      echo サービス名が空欄です。中止する場合はExitを入れてください。
   #Exitが入力されたらプログラムから離脱
    elif [ $service_name = "Exit" ]; then
      echo "Thank you!"
      exit
    fi
   done

   #正しく入力された場合はユーザー名の入力に進む、空欄の場合はループ処理
   while [ -z $user_name ]
   do
      echo "ユーザー名を入力してください！"
      read user_name
         #入力が空欄の場合
      if [ -z $user_name ]; then
         echo サービス名が空欄です。中止する場合はExitを入れてください。
       #Exitが入力されたらプログラムから離脱
      elif [ $user_name = "Exit" ]; then
         echo "Thank you!"
         exit
      fi
   done
    

    echo "パスワードを入力してください！"
    read password

    echo サービス名：$service_name >> password.txt
    echo ユーザー名：$user_name >> password.txt
    echo パスワード：$password >> password.txt
    echo "------------------------" >> password.txt

    echo パスワードの追加は成功しました。
 elif [ $selection = "Get Password" ] ; then
    echo サービス名を入力してください：
    read search_name
    search_name_num=${#search_name}
    search_name_num=$((search_name_num+2))
    grep -A 2 "サービス名：$search_name" password.txt

 elif [ $selection = "Exit" ] ; then
    number=$((number+1))
 else
    echo "入力が間違えています。Add Password/Get Password/Exit から入力していください"
 fi    

done


echo "Thank you!"