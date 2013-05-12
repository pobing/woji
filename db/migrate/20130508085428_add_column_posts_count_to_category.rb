class AddColumnPostsCountToCategory < ActiveRecord::Migration
  def change
  	add_column :categories, :posts_count, :integer,:default => 0
  	add_column :categories, :type, :string
  end
end
