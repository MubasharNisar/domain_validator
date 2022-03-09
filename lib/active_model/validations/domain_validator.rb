require 'uri'

module ActiveModel
  module Validations

    # See: https://gist.github.com/rietta/3836366
    #
    # Domain Validator by Frank Rietta
    # (C) 2012 Rietta Inc. All Rights Reserved.
    # Licensed under terms of the BSD License.
    #
    # To use in a validation, add something like this to your model:
    #
    #   validates :name, domain: true
    #
    class DomainValidator < ActiveModel::EachValidator

      def validate_each(record, attribute, value)
        return if value.blank?

        # The shortest possible domain name something like Google's g.cn, which is four characters long
        # The longest possible domain name, as per RFC 1035, RFC 1123, and RFC 2181 is 253 characters
        if value.length < 4
          record.errors.add(attribute, :'domain.short', options)
        elsif value.length > 253
          record.errors.add(attribute, :'domain.long', options)
        elsif value !~ /\A([a-z0-9]([a-z0-9\-]{0,61}[a-z0-9])?\.)+[a-z]{2,}\z/
          record.errors.add(attribute, :'domain.invalid', options)
        elsif value.include?('://')
          record.errors.add(attribute, :'domain.protocol', options)
        elsif value.include?('/')
          record.errors.add(attribute, :'domain.slashes', options)
        elsif !value.include?('.')
          record.errors.add(attribute, :'domain.dots', options)
        else

          # Finally, see if the URI parser recognizes this as a valid URL when given a protocol;
          # remember, we have already rejected any value that had a protocol specified already
          valid = begin
            URI.parse('http://' + value).kind_of?(URI::HTTP)
          rescue URI::InvalidURIError
            false
          end

          unless valid
            record.errors.add(attribute, :'domain.invalid', options)
          end

        end

      end # validate_each

    end # DomainValidator

  end
end
