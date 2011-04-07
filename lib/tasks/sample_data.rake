require 'faker'

namespace :db do
  desc "Fill the database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Tito",
    	:email 			=> "tito@pool.com",
    	:password 		=> "foobar",
    	:password_confirmation 	=> "foobar",
        :welcome_code  		=> "welcome0")
    admin.toggle!(:admin)
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@joinopp.com"
      welcome_code = "welcome-#{n+1}"
      password = "password"
      User.create!(:name 			=> name,
	 	   :email			=> email,
		   :welcome_code 		=> welcome_code,
		   :password			=> password,
		   :password_confirmation 	=> password)
    end
  end

end
