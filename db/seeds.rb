# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create(email: "admin@admin.com",password: "password")

30.times.each do |i|
  User.create!(email: "user#{i+1}@user.com",password:"password",
    name:"田中 太郎#{i+1}", goal_hour: rand(1..99), goal_minute: rand(1..59),introduction:"hogehogehogehoge")
end


  # create_table "notes", force: :cascade do |t|
  #   t.integer "user_id", null: false
  #   t.string "title", null: false
  #   t.text "body", null: false
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  #   t.index ["title"], name: "index_notes_on_title"
  #   t.index ["user_id"], name: "index_notes_on_user_id"
  # end
30.times.each do |i|
  Note.create!(user_id: rand(1..30),title: "ポートフォリオ制作について#{i}",body:"seedファイルで作られたbodyです！",tag_list: ["ポートフォリオ","Ruby_on_rails"])
end

  # create_table "study_logs", force: :cascade do |t|
  #   t.integer "user_id", null: false
  #   t.string "memo"
  #   t.date "working_date", null: false
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  #   t.integer "hour", default: 0, null: false
  #   t.integer "minute", default: 0, null: false
  #   t.index ["user_id"], name: "index_study_logs_on_user_id"
  # end

30.times.each do |i|
  StudyLog.create!(user_id: rand(1..30),memo:"ポートフォリオ",hour: rand(1..23),minute: rand(1..59),working_date: Date.today,tag_list: ["Ruby_on_rails"])
end