# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'


50.times do 
  faker_confirmation_password = Faker::Internet.password
  User.create!(:firstname => Faker::Name.first_name, :lastname => Faker::Name.last_name, :email => Faker::Internet.email, :password => faker_confirmation_password, :password_confirmation => faker_confirmation_password) 
end
