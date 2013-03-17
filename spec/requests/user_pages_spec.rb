require 'spec_helper'

describe "UserPages" do
  subject { page }
  describe "signup" do
  	before { visit signup_path }
    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end

  describe "user profile" do
  	#let (:user) { FactoryGirl.create(:user) }
  	attr = {name: "test",email: "test@woji.com", password: "123456",password_confirmation: "123456"}
    user = User.create attr
  	before { visit user_path(user)}
  	it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }
  end

end
