class Group < ApplicationRecord
  has_many :group_members, dependent: :destroy
  belongs_to :owner, class_name: 'Member'
  has_many :members, through: :group_members, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :introduction, presence: true
  has_one_attached :group_image

  def is_owned_by?(member)
    owner.id == member.id
  end
end