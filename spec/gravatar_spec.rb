require 'shoulda'
require 'gravatar'

EMAIL = 'name@example.com'
HASH = 'a130ced3f36ffd4604f4dae04b2b3bcd'

describe Gravatar do
  it "should generate link" do
    Gravatar.image_url(EMAIL).should == "http://gravatar.com/avatar/#{HASH}"
  end
  
  it "should generate secure link" do
    Gravatar.image_url(EMAIL, :secure => true).should == "https://secure.gravatar.com/avatar/#{HASH}"
  end
  
  it "should generate link with rating option passed as symbol or string" do
    Gravatar.image_url(EMAIL, :rating => :x).should ==  "http://gravatar.com/avatar/#{HASH}?r=x"
    Gravatar.image_url(EMAIL, :rating => :X).should ==  "http://gravatar.com/avatar/#{HASH}?r=x"
    Gravatar.image_url(EMAIL, :rating => 'x').should == "http://gravatar.com/avatar/#{HASH}?r=x"
    Gravatar.image_url(EMAIL, :rating => 'X').should == "http://gravatar.com/avatar/#{HASH}?r=x"
  end
  
  it "should raise exception on invalid rating option" do
    lambda { Gravatar.image_url(EMAIL, :rating => 'bad_value') }.should raise_error
  end
  
  it "should generate link with options" do
    Gravatar.image_url(EMAIL, :rating => :x).should ==  "http://gravatar.com/avatar/#{HASH}?r=x"
  end
  
  it "should generate link with filetype" do
    Gravatar.image_url(EMAIL, :filetype => :jpeg).should == "http://gravatar.com/avatar/#{HASH}.jpg"
    Gravatar.image_url(EMAIL, :filetype => "PNG").should == "http://gravatar.com/avatar/#{HASH}.png"
  end
end