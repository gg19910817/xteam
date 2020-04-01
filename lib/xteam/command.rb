require 'colored2'
require 'claide'
require 'molinillo/errors'

module Molinillo
  class ResolverError
    include CLAide::InformativeError
  end
end

module Xteam
  class PlainInformative
    include CLAide::InformativeError
  end

  class Command < CLAide::Command

    require_relative("./command/create/iOS.rb")

    self.abstract_command = true
    self.command = 'xteam'
    self.version = VERSION
    self.description = 'XTeam Tools'
    self.plugin_prefixes = %w(claide xteam)

    def self.options
      [
        ['--silent', 'Show nothing'],
      ].concat(super)
    end

    def self.run(argv)
      help! 'You cannot run xteam as root.' if Process.uid == 0 && !Gem.win_platform?

      super(argv)

    end

    def initialize(argv)
      super
    end

  end
end
