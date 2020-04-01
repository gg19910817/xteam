module Xteam
    class Command
        class Create < Command
            class IOS < Create
                self.summary = 'iOS项目创建工具'
                self.description = <<-DESC
                iOS项目创建工具
                DESC
                
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
                    # 确保文件名合法
                    verify_project_name!
                    # 确保文件夹不存在
                    verify_not_exists!

                    # installer = installer_for_config
                    # installer.repo_update = repo_update?(:default => false)
                    # installer.update = false
                    # installer.deployment = @deployment
                    # installer.clean_install = @clean_install
                    # installer.install!
                end
            end
        end
    end
end