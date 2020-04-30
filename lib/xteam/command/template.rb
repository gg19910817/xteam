require 'xcodeproj'

module Xteam
    class Command
        class Template < Command

            require_relative("../../../tool/tool.rb")
            require_relative("../../../tool/xcode.rb")

            self.summary = '模版代码生成工具'
            self.description = <<-DESC
            对指定的项目，生成模版代码。
            DESC
            
            self.arguments = [
                CLAide::Argument.new('PROJECT_PATH', true),
            ]

            def initialize(argv)
                # 这里可能获取到一个相对路径
                @project_path = argv.shift_argument
                super
            end
    
            def validate!
                super
                help! '输入项目路径' unless @project_path
            end

            def run
                @relative_path = "./#{@project_path}"
                # 先判断是否存在指定文件夹
                unless Dir.exist? @relative_path
                    puts "此项目路径找不到项目".red
                    return
                end

                @project_name = @project_path.split("/").last
                @xcodeproj_path = File.join(@relative_path, @project_name + ".xcodeproj")
                if File.exist? @xcodeproj_path
                    puts "发现iOS工程文件".yellow
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
                kind = Tool.new.ask_with_answers("输入模版", ["Table", "Collection", "Scroll"]).to_sym
                case kind
                when :table
                    snippets_path = ios_path + "/TABLE"
                when :collection
                    snippets_path = ios_path + "/COLLECTION"
                when :scroll
                    snippets_path = ios_path + "/SCROLL"
                else
                end

                page_name = Tool.new.ask("输入名称")  
                page_name_list = page_name.gsub(/(?=[A-Z])/, " ").split(" ")

                string_replacements = {
                    "TEMPLATE" => @project_name,
                    "N_A_M_E" => page_name,
                    "PROJECT_OWNER" => project_owner,
                    "OWNER_TEAM" => owner_team,
                    "TODAYS_DATE" => todays_date,
                    "TODAYS_YEAR" => todays_year
                }

                # 这里在xcode项目中写入文件和文件夹，还需要修改xcodeproj文件
                dir_path = File.join(@relative_path, @project_name, "Pages", page_name_list)
                if Dir.exists? dir_path
                    puts "项目中已经存在指定Page".red
                    return
                end

                Xcode.save(@project_path, snippets_path, File.join("Pages", page_name_list))

                Dir.foreach(snippets_path) do |name|
                    next if Dir.exists? name
                    text = File.read(File.join(snippets_path, name))

                    for find, replace in string_replacements
                        text = text.gsub(find, replace)
                    end

                    File.open(File.join(dir_path, name.gsub("N_A_M_E", page_name)), "w") { |file| file.puts text }
                end

            end
    
        end
    end
end