# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#admin用
Admin.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |admin|
  admin.password = ENV['ADMIN_PASSWORD']
end

nick_names = ['ヒロ016','イチゴ015','ゼロツー002','ゴロー056','ゾロメ666','ミツル326','フトシ214','ミク390','ココロ556','イクノ196','ナオミ703']
last_names = ['ツナシ','アゲマキ','シンドウ','ニチ','シナダ','ワタナベ','ミヤビ','ダイ','カタシロ','シモーヌ','タクミ']
first_names = ['タクト','ワコ','スガタ','ケイト','ベニオ','カナコ','レイジ','タカシ','リョウスケ','アラゴン','タケオ']
residences = ['日本','アメリカ','イギリス','韓国','オーストラリア','スペイン','イタリア','カナダ','ドイツ','フランス','ブラジル']
numbers = [1,2,3,4,5,6,7,8,9,10,11]

def find_or_create_member(last_name, first_name, nick_name, residence, number)
  introduction = "Hello,World!#{nick_name}です。よろしくお願いします。"
  email = "#{number}@example.com"
  password = "password"
  is_deleted = false

  # ランダムな日付を生成
  min_days_ago = 1
  max_days_ago = 365
  random_days_ago = rand(min_days_ago..max_days_ago)
  random_date = Time.now - random_days_ago.days

  member = Member.find_or_create_by!(email: email) do |m|
    m.last_name = last_name
    m.first_name = first_name
    m.nick_name = nick_name
    m.residence = residence
    m.introduction = introduction
    m.password = password
    m.is_deleted = is_deleted
    m.created_at = random_date
    m.updated_at = random_date
  end
  
  if member.persisted?
    puts "member created successfully: #{member.nick_name}"
  else
    puts "Error creating member:"
    puts member.errors.full_messages
  end
end

last_names.zip(first_names,nick_names,residences,numbers) do |last_name,first_name,nick_name,residence,number|
  find_or_create_member(last_name, first_name, nick_name, residence,number)
end

tags = %w(アメリカ 韓国 イギリス オーストラリア スペイン カナダ ドイツ)
tags.each { |tag_name| ActsAsTaggableOn::Tag.find_or_create_by(name: tag_name) }
titles = ['USA','Italy','Germany',"Korea",'Japan','UK','Australia','Brazil','Spain','China','France']
languages = ['日本語','英語','ドイツ語','スペイン語','イタリア語','フランス語','韓国語','中国語','ポルトガル語']

def create_posts(member,count,public_flag_options, tags,titles,languages)
  initial_date = Time.now - (count - 1).days
  random_titles = titles.sample
  random_languages = languages.sample

  count.times do |i|
    title = random_titles
    content = "サンプルの投稿#{i+1}です。"
    language = random_languages
    public_flag = public_flag_options.sample
    tag_list = tags.sample(2)

    post_date = initial_date + i.days

    post_params = {
      member_id: member.id,
      title: title,
      content: content,
      language: language
    }

  post = Post.find_or_create_by!(post_params) do |p|
      p.public_flag = public_flag
      p.created_at = post_date
      p.updated_at = post_date
      p.tag_list.add(tag_list)
    end

    puts "Creating post with title: #{title},member_nick_name: #{member.nick_name}, tag_list: #{tag_list}"
  end
end

Member.where.not(nick_name: 'ゲスト会員').each do |member|
  public_flags = [0] * 7 + [1] * 3 + [2] * 3
  create_posts(member,7, public_flags,tags,titles,languages)
end

members = Member.all
posts = Post.where(public_flag: "public")


members.each do |member|
  favorite_posts = posts.sample(rand(1..3))
  favorite_posts.each do |post|
    Favorite.find_or_create_by!(
      member_id: member.id,
      post_id: post.id
      )
  end
end

member_comments = [
  'すごく楽しそう！！',
  '興味深い情報です。',
  '大変参考になりました',
  'めちゃくちゃいいですね！',
  '面白くて笑っちゃいました！',
  '現地でのおすすめは何ですか？',
  'フォローしました！'
  ]

members.each do |member|
  posts.each do |post|
    num_comments = rand(0..1)
    next if num_comments.zero?

    comment_text = member_comments.sample
    comment = Comment.find_or_create_by!(
      member_id: member.id,
      post_id: post.id
    ) do |c|
      c.comment = comment_text
      end
  end
end

members.each do |member|
  following_members = members - [member]
  following_members.shuffle.take(rand(1..4)).each do |following_member|
    Relationship.find_or_create_by!(
      follower_id: member.id,
      followed_id: following_member.id
      )
  end
end