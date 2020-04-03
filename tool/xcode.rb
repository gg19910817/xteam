require 'xcodeproj'

module Xteam
    class Xcode
        # 迭代生成group
        # Xcode项目中，使用PBXGroup，如果包含path，就为一个实体文件夹，否则只是一个引用。
        # from 项目目录
        # to 工程内目录（相对于project_folder）
        # 会将文件夹内容全部写入指定项目文件夹和工程文件中（这里默认加入所有target）

        def self.save(input, from, save_path)
            
            project_path = File.expand_path(input)
            project_name = project_path.split("/").last
            xcodeproj_path = File.join(project_path, project_name + ".xcodeproj")

            project = Xcodeproj::Project.open(xcodeproj_path)

            save_path = File.join(project_name, save_path)
            folder_list = save_path.split("/")

            tmp_path = project_path
            relative_tmp_path = ""
            for folder in folder_list do
                if folder.length > 0
                    tmp_path = File.join(tmp_path,folder)
                    if relative_tmp_path.length > 0
                        relative_tmp_path = relative_tmp_path + "/"
                    end
                    relative_tmp_path = relative_tmp_path + folder

                    unless Dir.exists? tmp_path
                        Dir.mkdir(tmp_path)
                        group = project.main_group.find_subpath(relative_tmp_path, true)
                        group.set_source_tree('<group>')
                        group.set_path(folder)
                        group.name = folder
                        project.save
                    end
                end
            end

            project.save
        end
    end
end