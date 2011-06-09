require 'digest/md5'

module Email
  
  def self.validate(email)
    if email && email.is_a?( String )
      
      email.strip!
      email.downcase!
    
      return email if email =~ /^[a-z][a-z0-9_\.]+@[a-z0-9\-_.]+\.[a-z]{2,4}$/
    end
  end
  
  def self.get_hash(email)
    if email && email.is_a?( String )  
      
      email.strip!
      email.downcase!
    
      Digest::MD5.hexdigest(email)
    end
  end
end