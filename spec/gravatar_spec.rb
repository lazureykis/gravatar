require 'gravatar'

EMAIL = 'name@example.com'
HASH = 'a130ced3f36ffd4604f4dae04b2b3bcd'

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