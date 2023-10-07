class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :member_id
      t.string :title, null: false
      t.text :content, null: false
      t.string :language, null: false
      t.integer :public_flag
      t.timestamps
    end
  end
end
