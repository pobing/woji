require 'spec_helper'

describe "StaticPages" do
  Capybara.default_driver = :selenium
  describe "GET /static_pages" do
    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      #visit 'www.baidu.com'
      page.should have_content('StaticPages')
    end
  end
end
