module Dradis::Plugins::Zap
  # This simple field processor tries to locate the fields as nested XML tags
  # under the root element.
  class FieldProcessor < Dradis::Plugins::Upload::FieldProcessor

    # No need to implement anything here
    # def post_initialize(args={})
    # end

    def value(args={})
      field = args[:field]

      # fields in the template are of the form <foo>.<field>, where <foo>
      # is common across all fields for a given template (and meaningless).
      _, name = field.split('.')

      if tag = @data.at_xpath(name)
        tag.text().gsub(/<p>/, '').gsub(/<\/p>/, "\n\n")
      else
        'n/a'
      end
    end
  end

end
