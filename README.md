# command_helper
command helperは、Linuxコマンドの学習ツールです.  
  
- ch_app.ruby  -->command helper本体.  
- wordlist.csv -->コマンド辞書（コマンド名と説明が入っています.）
- result1.log  -->タイピングモードの点数などの記録を保存するファイルです。
- result2.log  -->テストモードの点数などの記録を保存するファイルです.
  
  
command helper is a Linux command learning tool (in Japanese). 
  
- ch_app.ruby -->command helper itself.  
- wordlist.csv -->Command dictionary (contains command names and descriptions).
- result1.log -->A file to save your typing mode scores.
- result2.log -->A file to save the scores in test mode.
  
# Requirements
* ruby 2.5.1
  
# Usage
ターミナルで'ruby ch_app.ruby'を実行（Ubuntu推奨：文字コードがutf-8であれば使用できます.）  
  
モード一覧：  
1.コマンド追加モード  
2.練習モード
  -タイピングモード
  -テストモード  
  
- 1のコマンド追加モードでは、2の練習モードで使用するコマンド辞書にコマンドを追加することができます.　　
- 2の練習モードにはタイピングモードとテストモードがあります.  
  - タイピングモードでは、コマンドのタイピング練習ができます.  
  - テストモードでは、コマンドの説明文に合うコマンドを入力するテストが受けられます.  
  
  
    
Run 'ruby ch_app.ruby' in a terminal (Ubuntu recommended: if the character encoding is utf-8, you can use it.  
  
Mode list:  
1. Add command mode  
2. Practice mode
  -Typing mode
  -Test mode  
  
- In the Add Command mode, you can add commands to the command dictionary used in the Practice mode.　　
- The two practice modes are the typing mode and the test mode.  
  - In the typing mode, you can practice typing the commands.  
  - In test mode, you can take a test to type a command that matches the description of the command.  


# License
"Command helper" is under MIT license.
