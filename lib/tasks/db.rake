namespace :db do
  desc "generate admin"
  task :admin => :environment do
   pass = rand(36**6).to_s 32
   attr = { :login => "admin", :password => pass,:password_confirmation => pass,:status => 1,:is_admin => 1 }
   user = User.new(attr)
   if user.save(:validate=>false)
   	puts "login: #{user.login},password: #{user.password}"
   else
   	puts user.errors
   end
  end	
end

