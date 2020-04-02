module Xteam
    class Command
        class Create < Command
            class Egg < Create
                self.summary = 'Egg项目创建工具'
                self.description = <<-DESC
                Egg项目创建工具
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
                    help! '项目名必须大于等于四个字符' if @name.length < 4
                end

                def run
                    project_folder = "./#{@name}"
                    # 先判断是否存在指定文件夹
                    if Dir.exist? project_folder
                        puts "文件夹已经存在，请先删除或移动。".red
                        return
                    end

                    @name = @name.capitalize

                    `git clone https://github.com/gg19910817/EggTemplate #{@name}`

                    # 获取github的名字
                    github_user_name = `security find-internet-password -s github.com | grep acct | sed 's/"acct"<blob>="//g' | sed 's/"//g'`.strip
                    project_owner = github_user_name

                    string_replacements = {
                        "TEMPLATE" => @name,
                        "PROJECT_OWNER" => project_owner
                    }

                    # 这里从所有文件中替换掉模版中的名称
                    Dir.glob(project_folder + "/**/**/**/**").each do |name|
                        next if Dir.exists? name
                        text = File.read(name)

                        for find, replace in string_replacements
                            text = text.gsub(find, replace)
                        end

                        File.open(name, "w") { |file| file.puts text }
                    end

                    Dir.chdir(@name)
                    # Git重新初始化
                    `rm -rf .git`
                    `git init`
                    `git add .`
                    `git commit -m "first commit"`
                end
            end
        end
    end
end