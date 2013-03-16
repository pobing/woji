#coding:utf-8
require 'spec_helper'

describe User do 
  before do
    @user = User.new(name: "jdd", email: "jdd@woji.com")
  end
  subject { @user }
  it { should respond_to (:name) }
  it { should respond_to (:email) }
  it { should be_valid }

  describe "when email is empty" do
   before {@user.email = "" }
   it { should_not be_valid }
  end
end