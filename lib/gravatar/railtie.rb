require 'gravatar'

module Gravatar
  class Railtie < Rails::Railtie
    initializer 'gravatar.initialize', :after => :after_initialize do
      ActionView::Base.send(:include, Gravatar::ViewHelper)
    end
  end
end