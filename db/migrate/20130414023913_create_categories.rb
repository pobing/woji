class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :category_id
      # t.integer :item_id
      # t.string :item_type
      t.string :name
      t.timestamps
    end
  end
end
