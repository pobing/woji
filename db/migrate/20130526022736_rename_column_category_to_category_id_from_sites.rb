class RenameColumnCategoryToCategoryIdFromSites < ActiveRecord::Migration
  def up
  	rename_column :sites, :category,:category_id
  end

  def down
  end
end
