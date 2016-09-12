class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :from_type
      t.integer :from_id
      t.text :message

      t.timestamps null: false
    end
  end
end
