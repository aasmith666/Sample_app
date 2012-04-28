require 'faker'

namespace :db do

	describe "Fill database with sample data"
	task :populate => :environment do
		Rake::Task['db:reset'].invoke
		admin = User.create!(	:name => "Example User",
						:email => "example@railstutorial.org",
						:password => "ratfink666",
						:password_confirmation => "ratfink666")
		admin.toggle!(:admin)
		99.times do |n|
			name = Faker::Name.name
			email = "test666-#{n+1}@gmail.com"
			password = "password"
			User.create!(:name => name,
						:email => email,
						:password => password,
						:password_confirmation => password)
		end

		User.all(:limit => 6).each do |user|
			50.times do
				user.microposts.create!(:content => Faker::Lorem.sentence(5))
			end
		end
	end
end
