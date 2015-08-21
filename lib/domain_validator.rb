require 'active_model'
require 'active_support/i18n'
require 'active_support/inflector'

require 'active_model/validations/domain_validator'

module DomainValidator
end

I18n.load_path << File.dirname(__FILE__) + '/domain_validator/locale/en.yml'
