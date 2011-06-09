require 'open-uri'
require 'uri'
require 'json'

module Gravatar::Profile
  
  include Gravatar
  
  def self.get(email, options = {})
    raise InvalidEmailFormat.new(email) unless email_cleaned = Email.validate(email)
    options.each { |name, value| raise InvalidOptionName.new(name) unless name == :as }
    if options[:as]
      raise InvalidOptionValue.new("Invalid option value: :as => #{options[:as]}.") unless TYPES.include?( options[:as] )
    end
    
    email_hash = Email.get_hash(email_cleaned)
    options[:as] ||= :ruby
    url = BASE_URL + email_hash + TYPES[options[:as]] # return hash by default
    raw_data = open( URI.parse(url) ).read
    
    if raw_data && raw_data.size > 0
      return case options[:as]
      when :ruby
        then parse_json(raw_data)
      when :json, :html, :php, :xml
        then raw_data # don't parse these formats
      end
    end
  end
  
  private
  
  def self.parse_json(raw_data)
    obj = JSON.parse(raw_data)
    
    # get first entry
    raise InvalidDataReceived.new("Cannot parse data recieved from gravatar: #{raw_data}") unless obj && obj['entry'] && obj['entry'][0]
    
    obj['entry'][0]
  end
  
  # TODO: implement qr code and vcard formats
  TYPES = {
    :html => '',
    :xml => '.xml',
    :php => '.php',
    :json => '.json',
    :ruby => '.json' # returns ruby hash, default value
    #:vcard => '.vcf',
    #:qr => 'qr'
    }
  
  BASE_URL = "http://gravatar.com/"
end