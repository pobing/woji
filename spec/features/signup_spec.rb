describe "the signup process", :type => :feature do
  before :each do
    # User.make(:email => 'user@example.com', :password => 'caplin')
  end

  it "signs me in" do
    within("#session") do
      fill_in 'Login', :with => 'user@example.com'
      fill_in 'Password', :with => 'password'
    end
    click_link 'Sign in'
  end
end