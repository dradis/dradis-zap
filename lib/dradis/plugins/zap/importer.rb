module Dradis::Plugins::Zap
  class Importer < Dradis::Plugins::Upload::Importer
    def self.templates
      { evidence: 'evidence', issue: 'issue' }
    end

    # The framework will call this function if the user selects this plugin from
    # the dropdown list and uploads a file.
    # @returns true if the operation was successful, false otherwise
    def import(params={})
      file_content    = File.read( params.fetch(:file) )

      logger.info{'Parsing ZAP output file...'}
      @doc = Nokogiri::XML( file_content )
      logger.info{'Done.'}

      if @doc.xpath('/OWASPZAPReport/site').empty?
        error = "No scan results were detected in the uploaded file (/OWASPZAPReport/site). Ensure you uploaded an ZAP XML report."
        logger.fatal{ error }
        content_service.create_note text: error
        return false
      end

      @doc.xpath('/OWASPZAPReport/site').each do |xml_site|
        process_site(xml_site)
      end

      return true
    end # /import


    private
    attr_accessor :site_node

    def process_site(xml_site)

      host = xml_site[:host]
      name = xml_site[:name]

      self.site_node = content_service.create_node(label: host, type: :host)
      logger.info{ "\tSite name: #{name}" }

      xml_site.xpath('./alerts/alertitem').each do |xml_alert_item|
        process_alert_item(xml_alert_item)
      end
    end

    def process_alert_item(xml_alert_item)
      plugin_id = xml_alert_item.at_xpath('./pluginid').text()
      logger.info{ "\t\t => Creating new issue (plugin_id: #{plugin_id})" }

      issue_text = mapping_service.apply_mapping(source: 'issue', data: xml_alert_item)
      issue = content_service.create_issue(text: issue_text, id: plugin_id)


      xml_alert_item.xpath('./instances/instance').each do |xml_instance|
        logger.info{ "\t\t => Creating new evidence" }

        evidence_content = mapping_service.apply_mapping(source: 'evidence', data: xml_instance)
        content_service.create_evidence(issue: issue, node: site_node, content: evidence_content)
      end
    end
  end
end
