require 'spec_helper'

describe "StaticPages" do
  Capybara.default_driver = :selenium
   # before { visit root_path }
   subject { page }
  describe "static_pages_home" do
    it "page should have content 'home'" do
      visit "/home" #home_path
      should have_content('home')
      should have_selector('title',
                    :text => "Woji | Home")
    end
  end
  describe "static_pages_about" do
    it "page should have content 'about'" do
      visit about_path
      should have_content('about')
      should have_selector('title',
                    :text => "Woji | About")
    end
  end
  describe "static_pages_home" do
    it "page should have content 'help'" do
      visit help_path
      page.should have_content('help')
    end
  end
end
