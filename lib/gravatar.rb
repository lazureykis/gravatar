require "gravatar/version"

require 'gravatar/email'
require 'gravatar/image'
require 'gravatar/profile'

# http://gravatar.com/site/implement/

module Gravatar
  class InvalidEmailFormat < StandardError; end
  class InvalidOptionName < StandardError; end
  class InvalidOptionValue < StandardError; end
end