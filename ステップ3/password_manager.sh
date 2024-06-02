#!/bin/zsh

#-----example@email.comをGPGのキーに紐づいているメールアドレスに置き換えてくださいgit----------
pass_email=danishi1121@gmail.com

echo "パスワードマネージャーへようこそ！"

number=1

#password.pngがない時はpassword.pngを作成
passwoed_gpg_file_nmu=$(ls | grep password.txt.gpg | wc -l)
passwoed_file_nmu=$(ls | grep password.txt | wc -l)
if [ $passwoed_gpg_file_nmu -eq 0 ] && [ $passwoed_file_nmu -eq 0 ]; then
   echo パスワードマネージャー >> password.txt
   gpg --encrypt --recipient $pass_email password.txt
   #暗号化する前のファイルは削除
   rm password.txt
fi

#Exitが入力されるまで処理が続くためにwhile構文を挿入
while [ $number -eq 1 ];

do

   echo "次の選択肢から入力してください(Add Password/Get Password/Exit):"

   read selection
   #Add Passwordが入力されたときの処理
   if [ $selection = "Add Password" ]; then
      #変数をリセット
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
         else
            #「サービス名：」という文字列があると表示がうまくいかない可能性があるため…
            case "$user_name" in
               #サービス名という文字列が含まれている場合はservice_nameを空欄にしてループを継続する
               *サービス名：*)
                  echo "「サービス名：」という文字列は使えません。他の文字列にしてください"
                  user_name=""
                  ;;
               #サービス名が入っていない場合はservice_nameをそのままにしてループから抜ける
               *)
                  ;;
            esac
         fi
      done

      #正しく入力された場合はユーザー名の入力に進む、空欄の場合はループ処理
      while [ -z $password ]
      do
         echo "パスワードを入力してください！"
         read password
         if [ -z $password ]; then
            echo  サービス名が空欄です。中止する場合はExitを入れてください。
            #Exitが入力されたらプログラムから離脱
         elif [ $password = "Exit" ]; then
            echo "Thank you!"
            exit
         else
            #「サービス名：」という文字列があると表示がうまくいかない可能性があるため…
            case "$password" in
               #サービス名という文字列が含まれている場合はservice_nameを空欄にしてループを継続する
               *サービス名：*)
                  echo "「サービス名：」という文字列は使えません。他の文字列にしてください"
                  password=""
                  ;;
               #サービス名が入っていない場合はservice_nameをそのままにしてループから抜ける
               *)
                  ;;
            esac
         fi
      done

      #サービス名、ユーザー名、パスワードをpassword.txtに追加
      #まずは暗号ファイルを復号
      gpg --output password.txt --decrypt password.txt.gpg
      rm password.txt.gpg

      echo サービス名：$service_name >> password.txt
      echo ユーザー名：$user_name >> password.txt
      echo パスワード：$password >> password.txt

      #追加後にファイルを暗号化
      gpg --encrypt --recipient $pass_email password.txt
      #暗号化する前のファイルは削除
      rm password.txt

      echo パスワードの追加は成功しました。


      #Get Passwordが入力された場合、
   elif [ $selection = "Get Password" ] ; then
      #まず変数をリセット
      search_name=""
      search_service_num=""
      #serch_nameが空欄の間は繰り返す！
      while [ -z $search_name ]
      do
         echo サービス名を入力してください：
         read search_name

         #まずファイルを復号
         gpg --output password.txt --decrypt password.txt.gpg
         #復号に成功したらファイルを削除
         rm password.txt.gpg

         #以下の変数には一致するサービス名があれば1以上を、なければ0が代入される
         search_service_num=$(grep "サービス名："$search_name password.txt | wc -l)
         #ファイルを暗号化
         gpg --encrypt --recipient $pass_email password.txt
         #暗号化する前のファイルは削除
         rm password.txt

         #そもそもサービス名が入力されない場合
         if [ -z $search_name ]; then
            echo "サービス名が空欄です。中止する場合はExitを入れてください。"
         #登録済みサービスがある場合（$search_service_numが1以上の場合）
         elif [ $search_service_num -ge 1 ]; then
            #まずファイルを復号
            gpg --output password.txt --decrypt password.txt.gpg
         #復号に成功したらファイルを削除
            rm password.txt.gpg
            #「サービス名：（入力したサービス名）と2個下の行を返す
            grep -A 2 "サービス名：$search_name" password.txt
            #ファイルを暗号化
            gpg --encrypt --recipient $pass_email password.txt
            #暗号化する前のファイルは削除
            rm password.txt
         #"Exitが入力された場合"
         elif [ $search_name = "Exit" ]; then
         exit
         #登録されていないサービスだった場合
         elif [ $search_service_num -ge 0 ]; then
            echo "そのサービスは登録されていません。"
         fi
      done

      #"Exit"が入力された場合はnumberに1を足してループから抜ける
   elif [ $selection = "Exit" ] ; then
      number=$((number+1))
      #Add Password/Get Password/Exit以外が入力された場合
   else
      echo "入力が間違えています。Add Password/Get Password/Exit から入力していください"
   fi

done

echo "Thank you!"
