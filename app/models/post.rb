class Post < ApplicationRecord
  belongs_to :member
  has_many :favorites, dependent: :nullify
  has_many :comments, dependent: :destroy
  
  has_many_attached :post_images
  
  enum public_flag: {public: 0, draft: 1,private: 2},_prefix: true
  
  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end
end