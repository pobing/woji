class AddAvatarUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :auth_avatar, :string
    # remove_column :users, :avatat_id, :integer
    # remove_column :users, :hashed_password,:string
    # remove_column :users, :salt,:string
  end
end
