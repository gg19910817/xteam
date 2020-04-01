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
                    puts  @name,@objc
                end
            end
        end
    end
end