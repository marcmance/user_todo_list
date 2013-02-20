namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(first_name: "Example User",
                 last_name: "example last name",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    50.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      last_name = "smith"
      User.create!(first_name: name,
                   last_name: last_name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end