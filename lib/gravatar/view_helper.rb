module Gravatar::ViewHelper
  def gravatar_image_url(email, options = {})
    Gravatar::Image.get_url(email, options)
  end
end