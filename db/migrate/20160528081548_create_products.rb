class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products, id: false do |t|
		# t.bigint :id, limit: 16, null: false, index: {name: "index_products_on_id", unique: true}, primary_key: true
		t.bigint :id, null: false, index: {name: "index_products_on_id", unique: true}, primary_key: true
		t.string :name
		t.bigint :intlikes, array: true, default: [0,0,0,0,0,0,0,0,0,0,0,0,0,0]		#["la lactosa","el gluten","el maní","las nueces","el apio","la mostaza","el huevo","el sesamo","el pescado","los crustaceos","los mariscos","la soya","los sulfitos","el lupino"]
      	# t.timestamps null: false
    end
    add_index :products, :intlikes, using: 'gin'    
  end
end
