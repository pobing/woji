require 'spec_helper'

describe "StaticPages" do
  Capybara.default_driver = :selenium
  describe "static_pages_home" do
    it "page should have content 'home'" do
      visit '/static_pages/home'
      page.should have_content('home')
      page.should have_selector('title',
                    :text => "Woji | Home")
    end
  end
  describe "static_pages_about" do
    it "page should have content 'about'" do
      visit '/static_pages/about'
      page.should have_content('about')
      page.should have_selector('title',
                    :text => "Woji | About")
    end
  end
  describe "static_pages_home" do
    it "page should have content 'help'" do
      visit '/static_pages/help'
      page.should have_content('help')
    end
  end
end
