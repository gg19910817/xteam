require 'colored2'
require 'claide'

module Xteam

  class Command < CLAide::Command

    require_relative('./command/create/iOS.rb')

    self.abstract_command = true
    self.command = 'xteam'
    self.version = VERSION
    self.description = 'XTeam 官方管理工具'

    def self.options
      [
        ['--tips', '关键操作醒目提示'],
      ]
    end

  end
end
