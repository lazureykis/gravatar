module Gravatar::Image
  
  class InvalidEmailFormat < StandardError; end
  class InvalidOptionName < StandardError; end
  class InvalidOptionValue < StandardError; end
    
  AVAILABLE_OPTIONS = [
    :default,       # d=[404|mm|identicon|monsterid|wavatar|retro]
    :force_default, # f=y
    :secure,        # using SECURE_URL
    :rating,        # r=[p|pg|r|x]
    :size,          # image size s=80
    :filetype       # .jpg, .png, .gif
  ]
  
  FILETYPES = %w( jpg png gif )
  
  DEFAULT_IMAGES = [
    '404',        # do not load any image if none is associated with the email hash, instead return an HTTP 404 (File Not Found) response
    'mm',         # (mystery-man) a simple, cartoon-style silhouetted outline of a person (does not vary by email hash)
    'identicon',  # a geometric pattern based on an email hash
    'monsterid',  # a generated 'monster' with different colors, faces, etc
    'wavatar',    # generated faces with differing features and backgrounds
    'retro'       # awesome generated, 8-bit arcade-style pixelated faces
  ]
  
  RATINGS = [
    'g',  # suitable for display on all websites with any audience type.
    'pg', # may contain rude gestures, provocatively dressed individuals, the lesser swear words, or mild violence.
    'r',  # may contain such things as harsh profanity, intense violence, nudity, or hard drug use.
    'x'   # may contain hardcore sexual imagery or extremely disturbing violence.
  ]
  
  NORMAL_URL =         "http://gravatar.com/avatar/"
  SECURE_URL = "https://secure.gravatar.com/avatar/"
  
  def self.get_url(email, options = {})
    raise InvalidEmailFormat.new(email) unless email_cleaned = Email.validate(email)
    email_hash = Email.get_hash(email_cleaned)
    
    options.each { |name, value| raise InvalidOptionName.new(name) unless AVAILABLE_OPTIONS.include?( name ) }
    
    url = options[:secure] ? SECURE_URL : NORMAL_URL
    query_params = {}
    
    if options[:rating]
      options[:rating] = options[:rating].to_s.strip.downcase
      raise InvalidOptionValue.new("Invalid rating must be #{RATINGS.join(', ')}.") unless RATINGS.include?( options[:rating] )
      query_params['r'] = options[:rating]
    end
    
    if options[:filetype]
      options[:filetype] = options[:filetype].to_s.strip.downcase.gsub(/\./, '').gsub(/jpeg/, 'jpg')
      raise InvalidOptionValue.new("Invalid file type: #{options[:filetype]}") unless FILETYPES.include?( options[:filetype] )
    end
    
    if options[:size]
      options[:size] = options[:size].to_i unless options[:size].is_a? Integer
      raise InvalidOptionValue.new("Invalid image size: #{options[:size]}") if options[:size] <= 0
      query_params['s'] = options[:size].to_s
    end
    
    if options[:default]
      options[:default] = options[:default].to_s.strip.downcase
      raise InvalidOptionValue.new("Invalid default image: #{options[:default]}") unless DEFAULT_IMAGES.include?( options[:default] )
      query_params['d'] = options[:default]
    end
    
    query_params['f'] = 'y' if options[:force_default]
    
    query = query_params.count > 0 ? "?" + query_params.collect{|k,v| "#{k}=#{v}"}.join('&') : nil
    
    url += email_hash
    url += ".#{options[:filetype]}" if options[:filetype]
    url += query if query
    
    url
  end
  
end