require 'spec_helper'

describe "LayoutLinks" do
  describe "GET /layout_links" do
    it "should have a Home page at '/'" do
      get '/'
      response.should have_selector("title", :content => "Home Page")
    end
    it "should have a Home page at '/about'" do
      get '/about'
      response.should have_selector("title", :content => "About Page")
    end
    it "should have a Home page at '/contact'" do
      get '/contact'
      response.should have_selector("title", :content => "Contact Page")
    end
    it "should have a Home page at '/help'" do
      get '/help'
      response.should have_selector("title", :content => "Help Page")
    end
  end
end
