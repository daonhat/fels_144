# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create! name: "test", email: "test@gmail.com", password: "123456",
  password_confirmation: "123456", is_admin: true

39.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create! name: name, email: email, password: password,
    password_confirmation: password
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}

10.times do |n|
  title = Faker::Name.first_name
  description = Faker::Lorem.sentence
  Category.create!(title: title,
                 description: description,
                 created_at: Time.zone.now)
end

50.times do |n|
  content = Faker::Name.last_name
  word = Word.create!(content: content,category_id: 1)
  word_id = word.id
  answer_correct = Faker::Lorem.word
  WordAnswer.create!(content: answer_correct, is_correct: true, word_id: word_id)
  3.times do |t|
    answer_incorrect = Faker::Lorem.word
    WordAnswer.create!(content: answer_incorrect, is_correct: false, word_id: word_id)
  end
end
