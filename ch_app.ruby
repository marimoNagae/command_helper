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

def countdown #カウントダウン
    3.downto(1) do |count|
        print count.to_s + "　"
        sleep 1
    end
end


##初期設定##
filename = "wordlist.csv"
#filename2 = "wordlist.txt"
result = "result.log"
score = 0
words = {} #ハッシュ
wordlists = [] #配列
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
        while true
            puts "「#{modes[mode-1]}」でいいですか？"
            question
            confirm  = gets.to_i
            if confirm == 1 ||confirm == 2
                break
            else
                puts "正しい数字を入力してください（半角数字を入力）"
            end
        end
        if confirm == 2
            mode = 0
        end
    end

    case mode
    when 1,2
        break
    end

    puts "正しいモードを選択してください（半角数字を入力）"

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
    if input == 1
        #ファイル読み込み 
        File.open(filename,"r") do |f|
            f.gets #読み込みファイル一行目読み飛ばし
            f.each_line do |line|
                line.chomp!
                c = line.split(",") # ，で区切る
                words[c[0]] = c[1] #ハッシュ追加
                wordlist
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
        input_word = gets.chomp
        
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
            while true
                puts 
                puts "「#{practice_modes[mode-1]}」でいいですか？"
                question
                confirm  = gets.to_i
                if confirm == 1 || confirm == 2
                    break
                else
                    partition
                    puts "正しい数字を入力してください（半角数字を入力）"
                end
            end
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
        partition
        puts <<-EOS
***タイピング練習***
    
表示されるコマンド名を入力し、Enterキーを押すと次の問題に移ります.
間違えていたらもう一度入力しなおしです.
    
        EOS
        partition

        #ファイル読み込み 
        File.open(filename,"r") do |f|
            f.gets #読み込みファイル一行目読み飛ばし
            f.each_line do |line|
                line.chomp!
                c = line.split(",") # ，で区切る
                #words[c[0]] = c[1] #ハッシュ追加
                wordlists.push(c[0])
            end
        end

        while true
            score = 0
            while true
                puts "問題は最大#{wordlists.size}問解けます. 何問解きますか？（半角数字を入力）"
                number = gets.to_i
                if number <= wordlists.size
                    break
                else
                    partition
                    puts "正しい数字を入力してください（半角数字を入力）"
                end
            end
            words = wordlists.sample(number)
            
            partition
            puts "問題は全部で#{words.size}問です."

            partition
            countdown
            puts
            puts "------START------"
            partition

            start_time = Time.now # 開始時間
            #コマンド一覧
            words.each do |key, value|
                loop do
                    puts key
                    if key == gets.chomp!
                    score += 10
                    break
                    else
                    puts "もう一度"
                    score -= 10
                    end
                end
            end
            puts
            partition
            end_time = Time.now # 終了時刻

            ## 結果の表示
            time = end_time - start_time
            puts <<-EOS
スコア：#{score}/#{words.size * 10 }点
タイム：#{time.round(1)} 秒
問題数：#{words.length}問
            EOS

            while true
                partition
                puts 
                puts "もう一度プレイしますか？（半角数字を入力）"
                question
                replay = gets.to_i

                if replay == 1 || replay == 2
                    break
                end
                puts "正しい数字を入力してください."
            end

            if replay == 2
                puts "では、プログラムを終了します. お疲れ様でした！"
                break
            end
        end


    when 2 #テストモード
        partition
        puts <<-EOS
***テストモード***
    
コマンドの説明文が表示されるので、正しいと思うコマンドを入力し、Enterキーを押してください.
    
        EOS
        partition
        #ファイル読み込み 
        File.open(filename,"r") do |f|
            f.gets #読み込みファイル一行目読み飛ばし
            f.each_line do |line|
                line.chomp!
                c = line.split(",") # ，で区切る
                words[c[0]] = c[1] #ハッシュ追加
            end
        end
        words = words.invert #ハッシュの値とキーを入れ替える
        while true

            while true
                puts "問題は最大#{words.size}問解けます. 何問解きますか？（半角数字を入力）"
                number = gets.to_i
                if number <= words.size
                    break
                else
                    partition
                    puts "正しい数字を入力してください（半角数字を入力）"
                end
            end
            words = words.sort_by{rand}
                
            partition
            puts "問題は全部で#{number}問です."
            countdown
            puts
            puts "------START------"

            #開始時間
            start_time = Time.now 

            qcount = 0
            #出題
            words.each do |key, value|
                puts key
                print ">"
                if value == gets.chomp
                    score += 100/words.length
                else
                    puts "正しくは#{value}です."
                    miss[key] = value
                end
                
                qcount += 1
                if qcount < number
                    puts "----------"
                else
                    break
                end
            end

            #終了時刻
            end_time = Time.now 
            #タイム
            time = end_time - start_time 

            if miss.empty?
                score = 100
            end

            #結果表示(timeにround関数を使用。四捨五入少数第一位）
            puts <<-EOS

* 結果 *
タイム：#{time.round(1)}秒 
スコア：#{score}点
あなたが間違えた単語

            EOS
            #間違えた単語の表示
            if miss.empty? 
                puts "-> ありません. Perfect!"
            else
                miss.each do |key, value|
                    puts "#{key}: #{value}"
                end
            end 
            

            while true
                partition
                puts "もう一度プレイしますか？（半角数字を入力）"
                question
                replay = gets.to_i

                if replay == 1 || replay == 2
                    break
                end
                partition
                puts "正しい数字を入力してください."
            end

            if replay == 2
                puts "では、プログラムを終了します. お疲れ様でした！"
                break
            end

        end

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