Factory.define :user do |user|
	user.name					"Michael Hartl"
	user.email					"mhartl@example.com"
	user.password				"foobar666"
	user.password_confirmation	"foobar666"
end

Factory.sequence :email do |n|
	
	"person-#{n}@example.com"
end
