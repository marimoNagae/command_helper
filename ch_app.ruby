#command_helper app body

def question
    puts <<-EOS
1:はい
2:いいえ
    EOS
end

def partition
    puts "-" * 50
end

def countdown 
    3.downto(1) do |count|
        print count.to_s + "　"
        sleep 1
    end
end


##初期設定##
filename = "wordlist.csv"
result1 = "result1.log" #タイピング
result2 = "result2.log" #テスト

words = {} 
wordlists = [] 


modes = ["コマンド追加モード", "練習モード"]
practice_modes = ["タイピングモード", "テストモード"]

#opening
partition
puts "command helperへようこそ."
sleep 1
partition
puts <<-EOS

command helperは、Linuxで使われるコマンドの学習ツールです.
1.コマンド追加モード　では、辞書にコマンドを追加することができます.
2.練習モード　　　　　では、辞書に登録されたコマンドのタイピング練習・テストができます.

EOS

##モード選択##
partition
sleep 1
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
            partition
            puts "「#{modes[mode-1]}」でいいですか？"
            question
            confirm  = gets.to_i
            if confirm == 1 ||confirm == 2
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
    puts "正しいモードを選択してください（半角数字を入力）"

end
partition
puts "#{modes[mode-1]}を選択しました."
sleep 1


case mode
when 1 #コマンド追加モード

    partition
    puts <<-EOS
***コマンド追加モード***

ここで辞書に追加したコマンドは、練習モードに反映されます.

    EOS
    while true
        partition
        puts "新しいコマンドを追加する前に、辞書に登録されているコマンド一覧を確認しますか？"
        question
        input = gets.to_i
        if input == 1 || input == 2
            break
        else
            partition
            puts "正しい数字を入力してください（半角数字を入力）"
        end
    end


    if input == 1
        #ファイル読み込み 
        File.open(filename,"r") do |f|
            f.gets 
            f.each_line do |line|
                line.chomp!
                c = line.split(",") 
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
        puts "確認出来たらEnterキーを押してください."
        stay = gets
    end
    partition
    puts "では、新しいコマンドを辞書に登録します. 追加をやめるときはCtrl＋Cでプログラムを終了してください."
    puts
    while true
        
        sleep 1
        puts "例のように入力してください.　(例)cd,ディレクトリ（フォルダ）を移動する."
        input_word = gets.chomp
        
        while true
            partition
            puts <<-EOS

これで追加しますか？
#{input_word}

            EOS
            question
            add = gets.to_i
            if add == 1 || add == 2
                break
            else
                partition
                puts "正しい数字を入力してください（半角数字を入力）"
            end
        end
        if add == 1
            File.open(filename,"a") do |fo|
                fo.puts "#{input_word}"
            end
            
            while true
                partition
                puts
                puts "もう一度追加しますか？"
                question
                input2 = gets.to_i
                if input2 == 1 || input2 == 2
                    break
                else
                    partition
                    puts "正しい数字を入力してください（半角数字を入力）"
                end
            end
            partition

            if input2 == 2
                puts "では、プログラムを終了します. お疲れ様でした！"
                break
            end

        end
    end



when 2 #練習モード
    partition
    puts <<-EOS
***練習モード***

1.タイピングモード　＞ コマンドのタイピング練習です.
2.テストモード　　　＞ コマンドの説明文を見て、説明に合うコマンドを入力してください.

    EOS
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
                partition 
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
        puts "正しいモードを選択してください（半角数字を入力）"

    end

    case mode
    when 1 #タイピングモード
        partition
        puts <<-EOS
***タイピングモード***
    
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
                    puts
                end
            end
            words = wordlists.sample(number)
            
            partition
            puts "問題は全部で#{words.size}問です."

            partition
            countdown
            puts
            puts "------START------"

            start_time = Time.now # 開始時間
            #コマンド一覧
            words.each do |key, value|
                loop do
                    puts key
                    if key == gets.chomp!
                        score += 10
                        partition
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
            puts "*** RESULT ***"
            puts
            puts <<-EOS
スコア：#{score}/#{words.size * 10 }点
タイム：#{time.round(1)} 秒
問題数：#{words.length}問
            EOS


            ##結果をファイルに記録##
            File.open(result1,"a") do |fo|
                fo.puts <<-EOS
日時：#{start_time.strftime("%Y年%m月%d日　%H時%M分")}
モード:タイピング
問題数：#{words.length}
時間: #{time.round(1)} 秒
得点: #{score}/#{words.size * 10}点
                EOS
                fo.puts "----------------------------------------------"
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
                partition
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
            score = 0
            miss = {}

            while true
                puts "問題は最大#{words.size}問解けます. 何問解きますか？（半角数字を入力）"
                number = gets.to_i
                if number <= words.size
                    break
                else
                    partition
                    puts "正しい数字を入力してください（半角数字を入力）"
                    puts
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
                    score += 100/number
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
            partition
            puts "*** RESULT ***"
            puts
            puts <<-EOS
スコア：#{score}点
タイム：#{time.round(1)}秒
問題数：#{number}問

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
            

            ##結果をファイルに記録##
            File.open(result2,"a") do |fo|
                fo.puts <<-EOS
日時：#{start_time.strftime("%Y年%m月%d日　%H時%M分")}
モード:テスト
問題数：#{number}
時間: #{time.round(1)} 秒
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
                partition
                puts "では、プログラムを終了します. お疲れ様でした！"
                break
            end

        end

    end

end