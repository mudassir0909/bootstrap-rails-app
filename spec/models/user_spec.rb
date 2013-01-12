# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  before :each do
    @attr = { 
      :name => "Mudassir", 
      :email => "lime.4951@gmail.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end

  it "should create a new instance with valid attributes" do
    User.create! @attr
  end

  it "should require a name" do
    nameless_user = User.new @attr.merge(:name => "")
    nameless_user.should_not be_valid
  end

  it "should require an email" do
    no_email_user = User.new @attr.merge(:email => "")
    no_email_user.should_not be_valid
  end

  it "should reject the names that are too long" do
    long_name = "a"*51
    long_name_user = User.new @attr.merge(:name => long_name)
    long_name_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject a user with duplicate email address" do
    User.create! @attr
    duplicate = User.new @attr
    duplicate.should_not be_valid
  end

  it "should reject user with duplicate email up to case" do
    caps_email = @attr[:email].upcase
    User.create! @attr.merge(:email => caps_email)
    duplicate_upcase = User.new(@attr)
    duplicate_upcase.should_not be_valid
  end

  describe "password validations" do
    it "should require a password" do
      User.new(@attr.merge(password: "", password_confirmation: "")).should_not be_valid
    end
    
    it "should require a matching confirming password" do
      User.new(@attr.merge(password_confirmation: "some_random")).should_not be_valid
    end

    it "should reject short passwords" do
      short = "a"*5
      User.new(@attr.merge(password: short, password_confirmation: short)).should_not be_valid
    end

    it "should reject long passwords " do
      long = "a"*41
      User.new(@attr.merge(password: long, password_confirmation: long)).should_not be_valid
    end
  end

  describe "password encryption" do
    
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do
      it "should be true if passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end

      it "shoudl be false if passwords do not match" do
        @user.has_password?("some some_random").should be_false
      end
    end

    describe "authenticate method" do

      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "some_random")
        wrong_password_user.should be_nil
      end

      it "should return nil with email address with no user" do
        invalid_user = User.authenticate("some@email.com", @attr[:password])
        invalid_user.should be_nil
      end

      it "should return user on email/password match" do
        valid_user = User.authenticate(@attr[:email], @attr[:password])
        valid_user.should == @user
      end
    end
  end
end
