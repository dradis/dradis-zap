module Dradis::Plugins::Zap
  class Engine < ::Rails::Engine
    isolate_namespace Dradis::Plugins::Zap

    include ::Dradis::Plugins::Base
    description 'Processes ZAP XML format'
    provides :upload

    def self.template_names
      { module_parent => { evidence: 'evidence', issue: 'issue' } }
    end
  end
end
