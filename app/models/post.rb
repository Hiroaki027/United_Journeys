class Post < ApplicationRecord
  belongs_to :member
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_many_attached :post_images
  
  enum public_flag: {public: 0, draft: 1,private: 2},_prefix: true
  
  def favorited_by?(member) #特定のmemberがいいね(favorite)しているか
    favorites.exists?(member_id: member.id) #recordにmember_idと引数として渡されているmember.idが合致のものが存在しているか
  end
end