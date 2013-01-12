FactoryGirl.define do 
  factory :user do
    name "Test"
    email "test.test@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end
end