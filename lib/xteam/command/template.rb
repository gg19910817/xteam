module Xteam
    class Command
        class Template < Command

            self.summary = '模版工具'
            self.description = <<-DESC
            模版工具
            DESC
            
            self.arguments = [
                CLAide::Argument.new('NAME', true),
            ]

            def initialize(argv)
                @name = argv.shift_argument
                super
            end
    
            def validate!
                super
                help! '输入项目名称' unless @name
            end

            def run
                project_folder = "./#{@name}"
                # 先判断是否存在指定文件夹
                unless Dir.exist? project_folder
                    puts "文件夹不存在".red
                    return
                end

                if File.exist? project_folder + "/Podfile"
                    puts "发现Podfile".yellow
                    @type = :swift
                end

                case @type
                when :swift
                    swift_project
                else
                end

            end

            def swift_project
                # 获取github的名字
                github_user_name = `security find-internet-password -s github.com | grep acct | sed 's/"acct"<blob>="//g' | sed 's/"//g'`.strip
                project_owner = github_user_name
                owner_team = project_owner
                todays_date = Time.now.strftime "%m/%d/%Y"
                todays_year = Time.now.year.to_s

                ios_path = "../../../../snippets/ios/"
                kind = ask_with_answers("输入模版", ["Table", "Collection", "Scroll"]).to_s
                case kind
                when :table
                    snippets_path = ios_path + "TABLE"
                when :collection
                    snippets_path = ios_path + "COLLECTION"
                when :scroll
                    snippets_path = ios_path + "SCROLL"
                else
                end

                @name = ask("输入名称")

                string_replacements = {
                    "TEMPLATE" => @name,
                    "PROJECT_OWNER" => project_owner,
                    "OWNER_TEAM" => owner_team,
                    "TODAYS_DATE" => todays_date,
                    "TODAYS_YEAR" => todays_year
                }

                # 这里从所有文件中替换掉模版中的名称
                Dir.glob(snippets_path).each do |name|
                    next if Dir.exists? name
                    text = File.read(name)

                    for find, replace in string_replacements
                        text = text.gsub(find, replace)
                    end

                    File.open(name, "w") { |file| file.puts text }
                end
            end

            def ask(question)
                answer = ""
                loop do
                  puts "\n#{question}?"

                  answer = STDIN.gets.chomp
          
                  break if answer.length > 0
          
                  print "\nYou need to provide an answer."
                end
                answer
            end

            def ask_with_answers(question, possible_answers)
        
                print "\n#{question}? ["
        
                print_info = Proc.new {
        
                possible_answers_string = possible_answers.each_with_index do |answer, i|
                    _answer = (i == 0) ? answer.underlined : answer
                    print " " + _answer
                    print(" /") if i != possible_answers.length-1
                end
                print " ]\n"
                }
                print_info.call
        
                answer = ""
        
                loop do
                answer = STDIN.gets.downcase.chomp
        
                answer = "yes" if answer == "y"
                answer = "no" if answer == "n"
        
                # default to first answer
                if answer == ""
                    answer = possible_answers[0].downcase
                    print answer.yellow
                end
        
                break if possible_answers.map { |a| a.downcase }.include? answer
        
                print "\nPossible answers are ["
                print_info.call
                end
        
                answer
            end
    
        end
    end
end