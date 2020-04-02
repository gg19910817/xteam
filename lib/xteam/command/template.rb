module Xteam
    class Command
        class Template < Command
            require_relative('./template/ios.rb')
            require_relative('./template/scrapy.rb')
            require_relative('./template/egg.rb')

            self.abstract_command = true
            self.summary = '为项目提供模版文件和代码'
            self.description = <<-DESC
            模版文件和代码
            DESC
    
        end
    end
end