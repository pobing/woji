class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.string :commenter
      t.text :body
      t.references :post

      t.timestamps
    end
    add_index :likes, :post_id
  end
end
