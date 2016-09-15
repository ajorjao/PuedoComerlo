class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.text :description
      t.integer :likes
      t.integer :dislikes

      t.timestamps null: false
    end
  end
end
