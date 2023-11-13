class Group < ApplicationRecord
  has_many :group_members
  has_many :members, through: :group_members
  
  validates :name, presence: true
  validates :introduction, presence: true
  has_one_attached :group_image
end
