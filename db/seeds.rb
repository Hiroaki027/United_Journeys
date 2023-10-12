# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  email: 'admin@admin',
  password: 'admin1'
  ) #admin用

# タグの作成
tags = %w(アメリカ 韓国 イギリス オーストラリア スペイン カナダ ドイツ)
tags.each { |tag_name| ActsAsTaggableOn::Tag.find_or_create_by(name: tag_name) }
tag_list = tags.sample(2)

# 一括で10個のユーザーデータを作成
# 10回繰り返し処理を行う

7.times do |n|
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

post1 = Post.new(
  title: "USA",
  content: "アメリカ大好き",
  member_id: 1,
  language: "英語",
)
post1.post_images.attach(io: File.open(Rails.root.join('app/assets/images/USA.png')), filename: 'USA.png')
post1.save!
post1.post_images.attach(io: File.open(Rails.root.join('app/assets/images/Italy.png')), filename: 'Italy.png')
post1.save!
post1.tag_list.add(tag_list)
post1.save!

post2 = Post.new(
  title: "Italy",
  content: "イタリア大好き",
  member_id: 2,
  language: "イタリア語",
)
post2.post_images.attach(io: File.open(Rails.root.join('app/assets/images/Italy.png')), filename: 'Italy.png')
post2.save!
post2.tag_list.add(tag_list)
post2.save!

post3 = Post.new(
  title: "Germany",
  content: "ドイツ大好き",
  member_id: 1,
  language: "ドイツ語",
)
post3.post_images.attach(io: File.open(Rails.root.join('app/assets/images/Germany.png')), filename: 'Germany.png')
post3.save!
post3.tag_list.add(tag_list)
post3.save!

post4 = Post.new(
  title: "UK",
  content: "イギリス大好き",
  member_id: 3,
  language: "英語",
)
post4.post_images.attach(io: File.open(Rails.root.join('app/assets/images/UK.jpg')), filename: 'UK.jpg')
post4.save!
post4.tag_list.add(tag_list)
post4.save!

post5 = Post.new(
  title: "Spain",
  content: "スペイン大好き",
  member_id: 4,
  language: "スペイン語",
)
post5.post_images.attach(io: File.open(Rails.root.join('app/assets/images/Spain.png')), filename: 'Spain.png')
post5.save!
post5.tag_list.add(tag_list)
post5.save!

post6 = Post.new(
  title: "France",
  content: "フランス大好き",
  member_id: 5,
  language: "フランス語",
)
post6.post_images.attach(io: File.open(Rails.root.join('app/assets/images/France.png')), filename: 'France.png')
post6.save!
post6.tag_list.add(tag_list)
post6.save!

post7 = Post.new(
  title: "Korea",
  content: "韓国大好き",
  member_id: 6,
  language: "韓国語",
)
post7.post_images.attach(io: File.open(Rails.root.join('app/assets/images/Korea.png')), filename: 'Korea.png')
post7.save!
post7.tag_list.add(tag_list)
post7.save!

post8 = Post.new(
  title: "Russia",
  content: "ロシア大好き",
  member_id: 7,
  language: "ロシア語",
)
post8.post_images.attach(io: File.open(Rails.root.join('app/assets/images/Russia.png')), filename: 'Russia.png')
post8.save!
post8.tag_list.add(tag_list)
post8.save!

post9 = Post.new(
  title: "Australia",
  content: "オーストラリア大好き",
  member_id: 5,
  language: "英語",
)
post9.post_images.attach(io: File.open(Rails.root.join('app/assets/images/Australia.png')), filename: 'Australia.png')
post9.save!
post9.tag_list.add(tag_list)
post9.save!

post10 = Post.new(
  title: "Brazil",
  content: "ブラジル大好き",
  member_id: 1,
  language: "ブラジル語",
)
post10.post_images.attach(io: File.open(Rails.root.join('app/assets/images/Brazil.png')), filename: 'Brazil.png')
post10.save!
post10.tag_list.add(tag_list)
post10.save!

7.times do |n|
  Comment.create!(
    member_id: n+1,
    post_id: n+1,
    comment: "コメント"
  )
end