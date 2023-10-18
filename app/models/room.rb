class Room < ApplicationRecord
  has_many :member_rooms
  has_many :chats
end