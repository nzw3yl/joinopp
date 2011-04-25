

namespace :db do
  desc "Fill the database with sample data"
  task :populate => :environment do
    require 'faker'
    Rake::Task['db:reset'].invoke
    make_users
    make_undertakings
    make_invitations
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
      welcome_code = "welcome-#{n+1}"
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
        title = Faker::Lorem.sentence(6)
        description = Faker::Lorem.sentence(6)
        access_code = Faker::Lorem.words(2)
        user.undertakings.create!(:title => title, :description => description, :access_code => access_code)
      end    
    end
  end

  def make_invitations
    users = User.all
    user = users.first
    invitees = users[1..24]
    inviters = users[3..20]
    invitees.each { |invited| user.invite!(invited, user.undertakings.first) }
    inviters.each { |inviter| inviter.invite!(user, inviter.undertakings.first) }
  end

end
