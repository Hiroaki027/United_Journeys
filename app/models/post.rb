class Post < ApplicationRecord
  belongs_to :member
  has_many :favorites, dependent: :destroy #dependentオプションで関連付けされたものも道連れでdestroy
  has_many :comments, dependent: :destroy
  
  validates :title,presence: true
  validates :content,presence: true
  validates :language,presence: true
  
  has_many_attached :post_images #Avtive storageの導入により使用できる
  acts_as_taggable_on :tags # gem:acts_as_taggableの使用
  enum public_flag: {public: 0, draft: 1,private: 2},_prefix: true
  
  def favorited_by?(member) #特定のmemberがいいね(favorite)しているか
    favorites.exists?(member_id: member.id) #recordにmember_idと引数として渡されているmember.idが合致のものが存在しているか
  end
  
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      @post = Post.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      @post = Post.where("title LIKE?", "%#{word}")
    elsif search == "partial_match"
      @post = Post.where("title LIKE?", "%#{word}%")
    else
      @post = Post.all
    end
  end
end