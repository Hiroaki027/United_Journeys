class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :member_id
      t.string :title
      t.text :content
      t.integer :public_flag
      t.timestamps
    end
  end
end
