require 'gravatar'

EMAIL = 'beau@dentedreality.com.au'
HASH = '205e460b479e2e5b48aec07710c08d50'

describe Gravatar::Profile do
  it "should get profile" do
    Gravatar::Profile.get(EMAIL).should_not == nil
  end
  
  context "recieved data" do
    before :all do
      @profile = Gravatar::Profile.get(EMAIL)
    end
    
    it "must have a hash" do
      @profile['hash'].should == HASH
    end
    
    it "must have a name" do
      @profile['name']['formatted'].should == "Beau Lebens"
    end
  end
end

describe Gravatar::Email do
  
  it "should get correct hash" do
    Gravatar::Email.get_hash(EMAIL).should == HASH
  end
  
  it "should parse normal" do
    Gravatar::Email.validate(EMAIL).should == EMAIL
  end
  
  it "should parse upcase" do
    Gravatar::Email.validate(EMAIL.upcase).should == EMAIL
  end
  
  it "should parse with whitespace" do
    Gravatar::Email.validate("  #{EMAIL}  ").should == EMAIL
  end
  
  it "should not parse without correct root domain" do
    Gravatar::Email.validate('name@domain.m').should be_nil
    Gravatar::Email.validate('name@domain.verylongrootdomain').should be_nil
  end
  
  it "should parse underscores and dots" do
    Gravatar::Email.validate('name_@domain.com').should_not == nil
    Gravatar::Email.validate('my.very-big_name@gmail.com').should_not == nil
  end
  
  %w( ! # $ % & ' * + - / = ? ^ _ ` { | } ~ ).each do |char|
    it "should parse with character '#{char}' in the middle" do
      Gravatar::Email.validate("first#{char}last@domain.com").should_not == nil
    end
  end
end

describe Gravatar::Image do
  it "should generate link" do
    Gravatar::Image.get_url(EMAIL).should == "http://gravatar.com/avatar/#{HASH}"
  end
  
  it "should generate secure link" do
    Gravatar::Image.get_url(EMAIL, :secure => true).should == "https://secure.gravatar.com/avatar/#{HASH}"
  end
  
  it "should accept bad emails" do
    Gravatar::Image.get_url("  #{EMAIL.upcase}  ").should == "http://gravatar.com/avatar/#{HASH}"
  end
  
  it "should generate link with rating option passed as symbol or string" do
    Gravatar::Image.get_url(EMAIL, :rating => :x).should ==  "http://gravatar.com/avatar/#{HASH}?r=x"
    Gravatar::Image.get_url(EMAIL, :rating => :X).should ==  "http://gravatar.com/avatar/#{HASH}?r=x"
    Gravatar::Image.get_url(EMAIL, :rating => 'x').should == "http://gravatar.com/avatar/#{HASH}?r=x"
    Gravatar::Image.get_url(EMAIL, :rating => 'X').should == "http://gravatar.com/avatar/#{HASH}?r=x"
  end
  
  it "should generate link with options" do
    Gravatar::Image.get_url(EMAIL, :rating => :x).should ==  "http://gravatar.com/avatar/#{HASH}?r=x"
  end
  
  it "should generate link with filetype" do
    Gravatar::Image.get_url(EMAIL, :filetype => :jpeg).should == "http://gravatar.com/avatar/#{HASH}.jpg"
    Gravatar::Image.get_url(EMAIL, :filetype => "PNG").should == "http://gravatar.com/avatar/#{HASH}.png"
  end
  
  it "should generate link with filetype and size" do
    Gravatar::Image.get_url(EMAIL, :filetype => :jpeg, :size => 10).should == "http://gravatar.com/avatar/#{HASH}.jpg?s=10"
    Gravatar::Image.get_url(EMAIL, :filetype => "PNG", :size => 90).should == "http://gravatar.com/avatar/#{HASH}.png?s=90"
  end
  
  it "should raise exception on invalid option name" do
    lambda { Gravatar::Image.get_url(EMAIL, :bad_option => 'value') }.should raise_error
  end
  
  it "should raise exception on invalid rating option" do
    lambda { Gravatar::Image.get_url(EMAIL, :rating => 'bad_value') }.should raise_error
  end
  
  it "should raise exception on invalid rating option" do
    lambda { Gravatar::Image.get_url(EMAIL, :filetype => 'bad_value') }.should raise_error
  end
  
  it "should generate link with default image" do
    Gravatar::Image.get_url(EMAIL, :default => 'mm').should == "http://gravatar.com/avatar/#{HASH}?d=mm"
  end
end