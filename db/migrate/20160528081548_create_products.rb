class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products, id: false do |t|
			t.integer :id, limit: 16
			t.string :name

      # t.timestamps null: false
    end
  end
end
