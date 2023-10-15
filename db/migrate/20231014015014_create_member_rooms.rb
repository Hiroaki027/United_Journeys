class CreateMemberRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :member_rooms do |t|
      t.integer :member_id
      t.integer :room_id

      t.timestamps
    end
  end
end
