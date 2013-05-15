class CreateDiskFiles < ActiveRecord::Migration
  def change
    create_table :disk_files do |t|
      t.string :file_name
      t.string :digest
      t.integer :user_id
      t.string :mime_type
      t.integer :file_size
      t.string :container_type
      t.integer :container_id
      t.timestamps
    end
  end
end
