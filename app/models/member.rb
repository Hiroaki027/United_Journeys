class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :nullify #該当のmemberが退会しても投稿に対してのいいねを残す為 nullifyでmemberがnullでもrecordとしてfavoritesは残る
  has_many :comments, dependent: :destroy
  #active側は外部キーのfollower_idと結びつく、フォローする関係 teacherやboxer,tiktoker等のする側をfollower_idとしている
  has_many :active_relationships, class_name: "Relationship",foreign_key: "follower_id", dependent: :destroy
  #passive側は外部キーのfollowed_idと結びつく,フォローされる関係　be used等の される関係をfollowed_idとしている
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # フォローしているユーザーを取得
  has_many :followings, through: :active_relationships, source: :followed
  # フォロワーを取得
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :member_rooms
  has_many :chats
  has_many :rooms, through: :member_rooms #member_rooms(中間テーブル)を経由してroomへ

  validates :last_name, presence: true, length: { minimum: 1, maximum: 20 }
  validates :first_name, presence: true, length: { minimum: 1, maximum: 20 }
  validates :nick_name, presence: true, uniqueness: true
  validates :residence, presence: true

  has_one_attached :profile_image
  acts_as_taggable_on :tags # gem:acts_as_taggableの使用

  GUEST_MEMBER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_MEMBER_EMAIL) do |member|
      member.password = SecureRandom.urlsafe_base64
      member.last_name = "ゲスト"
      member.first_name = "会員"
      member.nick_name = "ゲスト会員"
      member.residence = "地球"
    end
  end

  def guest_member?
    email == GUEST_MEMBER_EMAIL
  end

  def get_profile_image
    (profile_image.attached?) ? profile_image : "no_image.jpg"
  end
  
  # 指定したメンバーをフォローする
  def follow(member)
    active_relationships.create(followed_id: member.id)
  end
  
  # 指定したメンバーのフォローを解除する
  def unfollow(member)
    active_relationships.find_by(followed_id: member.id).destroy
  end
  
  # 指定したユーザーをフォローしているかどうかを判定
  def following?(member)
    followings.include?(member)
  end
end