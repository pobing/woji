class AddColumnStatusToUser < ActiveRecord::Migration
  def change
    add_column :users, :status, :integer,:default => 0
    add_column :users, :is_admin, :integer,:default => 0
    add_column :users, :website, :string
    add_column :users, :active_token, :string
  end
end
