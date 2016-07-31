class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products, id: false do |t|
    # create_table :products, {:id => false, :primary_key => :id} do |t|
			# t.integer :id, limit: 16, primary_key: true
			# t.float :id, limit: 16, primary_key: true
			# t.float :barcode_id, limit: 16, null: false, index: {name: "index_products_on_barcode_id", unique: true}
			t.float :barcode, limit: 16, null: false, index: {name: "index_products_on_barcode_id", unique: true}, primary_key: true
			# t.float :barcode, limit: 16, primary_key: true
			# t.float :id, limit: 16
			t.string :name
      # t.timestamps null: false
    end    
  end
end
