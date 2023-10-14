class Chat < ApplicationRecord
  belongs_to :member
  belongs_to :room
  
  validates :message, presence: true, length: {maximum: 200}
end