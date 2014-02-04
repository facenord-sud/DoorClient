class CreateDoors < ActiveRecord::Migration
  def change
    create_table :doors do |t|
      t.string :uri
      t.string :lock_uri
      t.string :open_uri
      t.timestamps
    end
  end
end
