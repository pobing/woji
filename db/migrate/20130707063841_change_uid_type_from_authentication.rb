class ChangeUidTypeFromAuthentication < ActiveRecord::Migration
  # def up
  # 	change_column :authentications,:uid,:bigint # for pg
  # end

 def up
    execute <<-SQL
      ALTER TABLE authentications  ALTER COLUMN uid TYPE bigint USING uid::bigint
    SQL
  end
  def down
    change_column :users, :uid, :string
  end
end
