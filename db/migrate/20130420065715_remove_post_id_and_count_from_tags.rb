class RemovePostIdAndCountFromTags < ActiveRecord::Migration
  def up
    remove_column :tags, :post_id
    remove_column :tags, :count
  end

  def down
    add_column :tags, :count, :integer
    add_column :tags, :post_id, :integer
  end
end
