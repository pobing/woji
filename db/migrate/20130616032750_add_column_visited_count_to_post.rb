class AddColumnVisitedCountToPost < ActiveRecord::Migration
  def change
    add_column :posts, :visited_count, :integer,:default => 0
  end
end
