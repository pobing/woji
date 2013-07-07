class ChangeUidTypeFromAuthentication < ActiveRecord::Migration
  def up
  	change_column :authentications,:uid,:bigint # for pg
  end

  def down
  end
end
