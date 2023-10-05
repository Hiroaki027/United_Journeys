class Post < ApplicationRecord
  belongs_to :member
  has_many :favorites, dependent: :nullify
  has_many :post_comments, dependent: :destroy

  has_many_attached :post_images
end
