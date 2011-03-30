Factory.define :user do |user|
  user.first_name		"Roger"
  user.last_name		"Smith"
  user.email			"rsmith@example.com"
  user.password			"foobar"
  user.password_confirmation	"foobar"
end
