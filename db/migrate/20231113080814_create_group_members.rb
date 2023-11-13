class CreateGroupMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :group_members do |t|

      t.timestamps
      t.references :member, foreign_key: true
      t.references :group, foreign_key: true
    end
  end
end
