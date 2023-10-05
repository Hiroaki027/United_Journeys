# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 一括で10個のユーザーデータを作成
# 10回繰り返し処理を行う
10.times do |n|
  Member.create!(
    # n + 1で数字が重複しないようにする
    last_name: "テスト",
    first_name: "会員#{n + 1}",
    nick_name: "ゲスト#{n + 1}",
    residence: "Univers",
    introduction: "Hello,World",
    password: "password",
    email: "test#{n + 1}@test.com",
  )
end

10.times do |n|
  Post.create!(
    member_id: n+1,
    title: "テスト",
    content: "United Tests"
    )
  end
  
10.times do |n|
  PostComment.create!(
    member_id: n+1,
    post_id: n+1,
    comment: "コメント"
  )
end

10.times do |n|
  PostTag.create!(
    member_id: n+1,
    tag_id: n+1,
  )
end

10.times do |n|
  Tag.create!(
    name: "英語"
  )
end