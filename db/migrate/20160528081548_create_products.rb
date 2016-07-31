class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products, id: false do |t|
		# t.bigint :id, limit: 16, null: false, index: {name: "index_products_on_id", unique: true}, primary_key: true
		t.bigint :id, null: false, index: {name: "index_products_on_id", unique: true}, primary_key: true
		t.string :name
      	# t.timestamps null: false
    end    
  end
end
