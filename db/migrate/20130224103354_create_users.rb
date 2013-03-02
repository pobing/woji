class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :name
      t.string :nick_name
      t.string :email
      t.string :phone
      t.integer :avatat_id
      t.string :hashed_password
      t.string :salt
      t.integer :sex

      t.timestamps
    end
  end
end
