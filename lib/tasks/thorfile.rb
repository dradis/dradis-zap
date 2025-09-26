class ZapTasks < Thor
  include Rails.application.config.dradis.thor_helper_module

  namespace "dradis:plugins:zap"

  desc  "upload FILE", "upload ZAP XML results"
  def upload(file_path)
    require 'config/environment'

    unless File.exist?(file_path)
      $stderr.puts "** the file [#{file_path}] does not exist"
      exit -1
    end

    detect_and_set_project_scope

    importer = Dradis::Plugins::Zap::Importer.new(task_options)
    importer.import(file: file_path)
  end
end
