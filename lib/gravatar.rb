require "gravatar/version"

require 'gravatar/email'
require 'gravatar/image'
require 'gravatar/profile'

require 'gravatar/view_helper'
require 'gravatar/railtie' if defined?(::Rails::Railtie)

# http://gravatar.com/site/implement/

module Gravatar
  class InvalidEmailFormat < StandardError; end
  class InvalidOptionName < StandardError; end
  class InvalidOptionValue < StandardError; end
  class InvalidDataReceived < StandardError; end
end