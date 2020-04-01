module Xteam
    class Command
        class Create < Command
            class IOS < Create
                self.summary = 'iOS项目创建工具'
                self.description = <<-DESC
                iOS项目创建工具
                DESC
                
                self.arguments = [
                    CLAide::Argument.new('NAME', true),
                ]

                def self.options
                    [
                        ['--objc', '创建OC项目，默认为swift'],
                    ].concat(super)
                end

                def initialize(argv)
                    @name = argv.shift_argument
                    super
                    @objc = argv.flag?('objc', false)
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

                    `git clone https://github.com/gg19910817/iOSTemplate #{@name}`

                    # 获取github的名字
                    github_user_name = `security find-internet-password -s github.com | grep acct | sed 's/"acct"<blob>="//g' | sed 's/"//g'`.strip
                    project_owner = github_user_name
                    owner_team = project_owner
                    todays_date = Time.now.strftime "%m/%d/%Y"
                    todays_year = Time.now.year.to_s

                    string_replacements = {
                        "TEMPLATE" => @name,
                        "PROJECT_OWNER" => project_owner,
                        "OWNER_TEAM" => owner_team,
                        "TODAYS_DATE" => todays_date,
                        "TODAYS_YEAR" => todays_year
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

                    # 修改xcodeproj和xcscheme文件
                    scheme_path = project_folder + "/TEMPLATE.xcodeproj/xcshareddata/xcschemes/"
                    File.rename(scheme_path + "TEMPLATE.xcscheme", scheme_path +  @name + ".xcscheme")
                    File.rename(project_folder + "/TEMPLATE.xcodeproj", project_folder + "/" +  @name + ".xcodeproj")

                    # 修改几个文件夹的名称
                    if Dir.exist? project_folder + "/TEMPLATE"
                        File.rename(project_folder + "/TEMPLATE", project_folder + "/" + @name)
                    end
                    if Dir.exist? project_folder + "/TEMPLATETests"
                        File.rename(project_folder + "/TEMPLATETests", project_folder + "/" + @name + "Tests")
                    end
                    if Dir.exist? project_folder + "/TEMPLATEUITests"
                        File.rename(project_folder + "/TEMPLATEUITests", project_folder + "/" + @name + "UITests")
                    end

                    # # Pod Update
                    # `cd #{@name} && pod update`

                    # Git重新初始化
                    `cd #{@name} && rm -rf .git`
                    `cd #{@name} && git init`
                    `cd #{@name} && git add .`
                    `cd #{@name} && git commit -m "first commit"`
                end
            end
        end
    end
end