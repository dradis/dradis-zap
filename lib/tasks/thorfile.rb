class ZapTasks < Thor
  include Core::Pro::ProjectScopedTask if defined?(::Core::Pro)

  namespace "dradis:plugins:zap"

  desc  "upload FILE", "upload ZAP XML results"
  def upload(file_path)
    require 'config/environment'

    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG

    unless File.exists?(file_path)
      $stderr.puts "** the file [#{file_path}] does not exist"
      exit -1
    end

    content_service = nil
    template_service = nil

    template_service = Dradis::Plugins::TemplateService.new(plugin: Dradis::Plugins::Zap)
    if defined?(Dradis::Pro)
      detect_and_set_project_scope
      content_service = Dradis::Pro::Plugins::ContentService.new(plugin: Dradis::Plugins::Zap)
    else
      content_service = Dradis::Plugins::ContentService.new(plugin: Dradis::Plugins::Zap)
    end

    importer = Dradis::Plugins::Zap::Importer.new(
                logger: logger,
       content_service: content_service,
      template_service: template_service
    )

    importer.import(file: file_path)

    logger.close
  end
end
