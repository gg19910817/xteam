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
                    super
                    @objc = argv.flag?('objc', false)
                end
        
                def run
                    puts 
                end
            end
        end
    end
end