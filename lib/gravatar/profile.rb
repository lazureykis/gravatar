require 'open-uri'
require 'uri'
require 'json'

module Gravatar::Profile
  
  include Gravatar
  
  def self.get(email)
    raise InvalidEmailFormat.new(email) unless email_cleaned = Email.validate(email)
    email_hash = Email.get_hash(email_cleaned)
    
    url = BASE_URL + email_hash + '.json'
    raw_data = open( URI.parse(url) ).read
    
    if raw_data && raw_data.size > 0
      return JSON.parse(raw_data)
    end
    
    # TODO: parse profile data
  end
  
  private
  
  BASE_URL = "http://gravatar.com/"
end