class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.integer :item_type
      t.text :content

      t.timestamps
    end
  end
end
