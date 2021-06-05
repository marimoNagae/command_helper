# command_helper
command helperは、Linuxコマンドの学習ツールです.  
  
- ch_app.ruby  -->command helper本体.  
- wordlist.csv -->コマンド辞書（コマンド名と説明が入っています.）
- result1.log  -->タイピングモードの点数などの記録を保存するファイルです。
- result2.log  -->テストモードの点数などの記録を保存するファイルです.
  
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
  -タイピングモードでは、コマンドのタイピング練習ができます.
  -テストモードでは、コマンドの説明文に合うコマンドを入力するテストが受けられます.

# License
"Command helper" is under MIT license.
