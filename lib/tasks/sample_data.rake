

namespace :db do
  desc "Fill the database with sample data"
  task :populate => :environment do
    require 'faker'
    Rake::Task['db:reset'].invoke
    make_users
    make_undertakings
    make_relationships
  end

  def make_users
    admin = User.create!(:name => "Tito",
    	:email 			=> "tito@pool.com",
    	:password 		=> "foobar",
    	:password_confirmation 	=> "foobar",
        :welcome_code  		=> "welcome0")
    admin.toggle!(:admin)
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@joinopp.com"
      welcome_code = "nzw3yl-#{n+1}"
      password = "password"
      User.create!(:name 			=> name,
	 	   :email			=> email,
		   :welcome_code 		=> welcome_code,
		   :password			=> password,
		   :password_confirmation 	=> password)
    end
  end

 

  def make_undertakings
    User.all(:limit =>25).each do |user|
      25.times do
        title = Faker::Lorem.words(6).join[0..24]
        description = Faker::Lorem.sentence(6)
        access_code = Faker::Lorem.words(2)
        user.undertakings.create!(:title => title, :description => description, :access_code => access_code)
      end    
    end
  end


  def make_relationships
    undertakings = Undertaking.all
    undertaking = undertakings.first
    contributing = undertakings[1..25]
    contributors = undertakings[3..20]
    contributing.each { |contributed| undertaking.contribute!(contributed) }
    contributors.each { |contributor| contributor.contribute!(undertaking) }
  end
  
end
