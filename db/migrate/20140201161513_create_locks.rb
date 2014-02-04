class CreateLocks < ActiveRecord::Migration
  def change
    create_table :locks do |t|
      t.string :state
      t.belongs_to :door, index: true

      t.timestamps
    end
  end
end
