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
    it "should have a signup page at '/signup'" do
      get '/signup'
      response.should have_selector("title", :content => "Sign up Page")
    end
  end

  describe "when not signed in" do
    it "should have a signed in link" do
      visit root_path
      response.should have_selector("a", :href => signin_path, :content => "Sign In")
    end
  end

  describe "when signed in" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      visit signin_path
      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_button
    end

    it "should have a signout link" do
      visit root_path
      response.should have_selector("a", :href => signout_path, :content => "Sign out")
    end

    it "should have a profile link" do
      visit root_path
      response.should have_selector("a", :href => user_path(@user), :content => "Profile")      
    end
  end
end
