#command_helper
# coding:utf-8

def question
    puts <<-EOS
1:はい
2:いいえ
    EOS
end

def partition
    puts "-" * 50
end

##初期設定##
filename = "wordlist.csv"
#filename2 = "wordlist.txt"
result = "result.log"
score = 0
words = {}
miss = {}
#modes = ["入門(日本語→英語)","中級(日本語→英語)","入門(英語→日本語)","中級(英語→日本語)"] 
modes = ["単語追加モード", "練習モード"]
#dictionary_modes = ["コマンド検索","辞書に単語を追加"]
practice_modes = ["タイピング練習", "テストモード"]



##モード選択##
puts "モードを選択してください（半角数字を入力）"

while true

   partition
    modes.each_with_index do |mode,i|
        puts "#{i+1}:#{mode}"
    end
    partition
    
    mode = gets.to_i 
    
    if mode == 1 || mode == 2
        puts 
        puts "「#{modes[mode-1]}」でいいですか？"
        question
        confirm  = gets.to_i
        if confirm == 2
            mode = 0
        end
    end

    case mode
    when 1,2
        break
    end

    puts "もう一度モードを選択してください（半角数字を入力）"

end
puts ""
puts "#{modes[mode-1]}を選択しました."
sleep 1


case mode
when 1 #単語追加モード

    partition
    puts <<-EOS
***単語追加モード***

ここで辞書に追加したコマンドは、練習モードに反映されます.

    EOS
    partition

    puts "新しいコマンドを追加する前に、辞書に登録されているコマンド一覧を確認しますか？"
    question
    input = gets.to_i
    if input = 1
        #ファイル読み込み 
        File.open(filename,"r") do |f|
            f.gets #読み込みファイル一行目読み飛ばし
            f.each_line do |line|
                line.chomp!
                c = line.split(",") # ，で区切る
                words[c[0]] = c[1] #ハッシュ追加
            end
        end

        partition
        #コマンド一覧
        words.each do |key, value|
            puts ""
            puts key + "：" + value
        end
        puts
        partition
    end
 
    puts "では、新しいコマンドを辞書に登録します."
    while true
        
        sleep 1
        puts "例のように入力してください.　(例)cd,ディレクトリ（フォルダ）を移動する."
        input_word = gets
        
        puts <<-EOS

        これで追加しますか？
        #{input_word}

        EOS
        question
        add = gets.to_i
        if add == 1
            File.open(filename,"a") do |fo|
                fo.puts "#{input_word}"
            end
        
            puts
            puts "もう一度追加しますか？"
            question
            input2 = gets.to_i
            partition

            if input2 == 2
                puts "プログラムを終了します."
                break
            end

        end
    end



when 2
    partition
    puts "どちらの機能を使いますか？（半角数字を入力）"
    while true

        puts
        practice_modes.each_with_index do |mode,i|
            puts "#{i+1}:#{mode}"
        end
        partition
        mode = gets.to_i

        if mode == 1 || mode == 2
            puts 
            puts "「#{practice_modes[mode-1]}」でいいですか？"
            question
            confirm  = gets.to_i
            if confirm == 2
                mode = 0
            end
        end

        case mode
        when 1,2
            break
        end
        partition
        puts "もう一度モードを選択してください（半角数字を入力）"

    end

    case mode
    when 1 #タイピング練習
        

    when 2 #テストモード
    
    end


end



##ターミナル上で単語を追加##
=begin
puts ""
puts "単語リストに単語を追加しますか？"
question
input = gets.to_i
if input == 1
    while true
        puts ""
        puts "例のように入力してください(例)りんご,apple"
        input_word = gets
        puts <<-EOS

これで追加しますか？"
#{input_word}
        EOS
        question
        add = gets.to_i
        if add == 1
            File.open(filename,"a") do |fo|
                fo.puts "#{input_word}"
            end
        else
            puts ""
            puts "もう一度追加しますか？"
            question
            input2 = gets.to_i
            if input2 == 2
                break
            end
        end
    end
end


##ファイル読み込み##
File.open(filename,"r") do |fp|
    fp.gets
    fp.each_line do |line|
        line.chomp!
        c = line.split(",")
        words[c[0]] = c[1]
    end
end


##ハッシュとキーを入れ替え##
if mode == 3 or mode == 4
    words = words.invert
end

sleep(1)
puts "単語テストを始めます"
sleep(1)
puts "全部で#{words.size}問です"
sleep(1)
puts <<-EOS
3秒後にテストを開始します

3
EOS
sleep (1)
puts "2"
sleep (1)
puts "1"
sleep (1)
puts <<-EOS
--------------------------------------------------
テスト開始
--------------------------------------------------
EOS

start_time = Time.now # 開始時間


##問題部分##
words.each do |key, value|
    puts ""
    puts key
    if value == gets.chomp!
        score += 100/words.size
        puts ""
        puts "正解"
    else
        puts <<-EOS

不正解
ただしくは#{value}です
        EOS
        miss[key] = value
    end
end

end_time = Time.now # 終了時刻

puts <<-EOS

終了
EOS


##経過時間##
time = end_time - start_time

#ミスなしなら100点
if miss.empty?
    score = 100
end

##結果表示、間違った単語一覧##
puts <<-EOS

* 結果 *
タイム：#{time.round(1)}秒 
スコア：#{score}点
あなたが間違えた単語

EOS
if miss.empty? 
    puts "ありません。全問正解！"
else
    puts "間違った単語"
    miss.each do |key, value|
        puts "#{key} : #{value}"
    end
end


##結果をファイルに記録##
File.open(result,"a") do |fo|
    fo.puts <<-EOS
日時：#{start_time}
モード:#{modes[mode-1]}
問題数：#{words.size}
時間: #{time} 秒
得点: #{score}点
    EOS
    if miss.empty? 
        fo.puts "全問正解"
    else
        fo.puts "間違った単語"
        miss.each do |key, value|
            fo.puts "#{key} : #{value}"
        end
    end
    fo.puts "----------------------------------------------"
end

=end