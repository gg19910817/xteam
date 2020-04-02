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
                @project_folder = "./#{@name}"
                # 先判断是否存在指定文件夹
                unless Dir.exist? @project_folder
                    puts "文件夹不存在".red
                    return
                end

                @project_name = @name.split("/").last

                if File.exist? @project_folder + "/Podfile"
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

                ios_path = File.expand_path("../../../../snippets/ios/", __FILE__)
                kind = ask_with_answers("输入模版", ["Table", "Collection", "Scroll"]).to_sym
                case kind
                when :table
                    snippets_path = ios_path + "/TABLE"
                when :collection
                    snippets_path = ios_path + "/COLLECTION"
                when :scroll
                    snippets_path = ios_path + "/SCROLL"
                else
                end

                @name = ask("输入名称").capitalize

                string_replacements = {
                    "TABLE" => @name,
                    "PROJECT_OWNER" => project_owner,
                    "OWNER_TEAM" => owner_team,
                    "TODAYS_DATE" => todays_date,
                    "TODAYS_YEAR" => todays_year
                }

                # 这里从所有文件中替换掉模版中的名称
                puts snippets_path
                Dir.foreach(snippets_path) do |name|
                    next if Dir.exists? name
                    text = File.read(File.join(snippets_path, name))

                    for find, replace in string_replacements
                        text = text.gsub(find, replace)
                    end

                    dir_path = File.join(@project_folder, @project_name, "Pages", @name)
                    if Dir.exists? dir_path
                        puts "项目中已经存在指定Page".red
                        return
                    end
                    Dir.mkdir(dir_path)
                    File.open(File.join(dir_path, name.gsub("TABLE", @name)), "w") { |file| file.puts text }
                end

            end
    
        end
    end
end