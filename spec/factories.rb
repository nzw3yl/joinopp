Factory.define :user do |user|
  user.name		        "Roger"
  user.welcome_code		"welcome"
  user.email			"rsmith@example.com"
  user.password			"foobar"
  user.password_confirmation	"foobar"

  Factory.sequence :email do |n|
    "person-#{n}@example.com"
  end

  Factory.sequence :welcome_code do |n|
    "welcome-#{n}"
  end
end

Factory.define :undertaking do |ut|
  ut.title 			"Kill Bill"
  ut.description		"5 finger exploding heart"
  ut.success_if    		"instant death"
  ut.access_code   		"welcome"

  Factory.sequence :access_code do |n|
    "welcome-#{n}"
  end
end

Factory.define :invitation do |inv|
  inv.email			"rsmith@example.com"
  inv.access_code		"welcome"
  inv.inviter_id		1	

  Factory.sequence :i_email do |n|
    "person-#{n}@example.com"
  end
  Factory.sequence :i_access_code do |n|
    "welcome-#{n}"
  end
end
