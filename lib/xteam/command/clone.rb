module Xteam
    class Command
        class Clone < Command

            self.summary = '拉取模版工程'
            self.description = <<-DESC
            拉取模版工程
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
                help! '输入模板名' unless @name
            end

            def run

                @tempale_name = ""
                case @name.to_sym
                    when :ios
                        @tempale_name = "iOSTemplate"
                    when :scrapy
                        @tempale_name = "ScrapyTemplate"
                    when :egg
                        @tempale_name = "EggTemplate"
                end

                unless @tempale_name.length > 0
                    puts "没有此模版".red
                    return
                end

                @name = @tempale_name
                project_folder = "./#{@name}"
                # 先判断是否存在指定文件夹
                if Dir.exist? project_folder
                    puts "文件夹已经存在，请先删除或移动。".red
                    return
                end

                `git clone https://github.com/gg19910817/EggTemplate #{@name}`

            end
        end
    end
end