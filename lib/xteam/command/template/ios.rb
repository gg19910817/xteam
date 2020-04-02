module Xteam
    class Command
        class Template < Command
            class IOS < Template
                require_relative('./ios/swift.rb')

                self.abstract_command = true
                self.summary = 'ios的模版'
                self.description = <<-DESC
                ios的模版
                DESC
            end
        end
    end
end