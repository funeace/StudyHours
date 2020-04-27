# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create(email: "admin@admin.com",password: "password")

15.times.each do |i|
  User.create!(email: "user#{i+1}@user.com",password:"password",
    name:"田中 太郎#{i+1}", goal_hour: 20*i, goal_minute: 0,introduction:"hogehogehogehoge")
end