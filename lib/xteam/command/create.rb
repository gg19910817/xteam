module Xteam
    class Command
        class Create < Command
            require_relative('./create/ios.rb')

            self.abstract_command = true
            self.summary = '创建iOS，Android，Vue，Egg，Flutter基础工程'
            self.description = <<-DESC
            项目创建工具（iOS，Android，Vue，Egg，Flutter）
            DESC
    
        end
    end
end