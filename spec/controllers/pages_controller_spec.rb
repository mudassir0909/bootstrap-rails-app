require 'spec_helper'

describe PagesController do
  render_views
  ROUTES = ["home", "contact", "about"]

  ROUTES.each { |url|
    describe "GET #{url}" do

      # page existence test
      it "returns http success" do
        get url
        response.should be_success
      end
      
      # right title existence test
      it "should have the right title" do
        get url
        response.should have_selector("title", :content => "#{url.capitalize} Page")
      end
    end
  }

end

