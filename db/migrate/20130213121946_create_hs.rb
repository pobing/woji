class CreateHs < ActiveRecord::Migration
  def change
    create_table :hs do |t|
      t.String :name

      t.timestamps
    end
  end
end
