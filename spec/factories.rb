Factory.define :user do |user|
  user.name		        "Roger"
  user.welcome_code		"Smith"
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
