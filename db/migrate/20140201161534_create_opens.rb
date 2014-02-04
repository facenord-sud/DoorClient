class CreateOpens < ActiveRecord::Migration
  def change
    create_table :opens do |t|
      t.integer :position
      t.string :state
      t.belongs_to :door, index: true

      t.timestamps
    end
  end
end
