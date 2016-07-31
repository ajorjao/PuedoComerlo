class CreateIntolerancesProducts < ActiveRecord::Migration
  def change
    create_table :intolerances_products do |t|
      t.references :intolerance, index: true, foreign_key: true
      # t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end

    # add_reference :product, :barcode, type: :float, foreign_key: true
    add_column :intolerances_products, :product_id, :float, limit: 16
    # add_column :intolerances_products, :product_id, :float, index: true
    add_foreign_key :intolerances_products, :products, column: :product_id, primary_key: "barcode"
    # add_reference :intolerances_products, :product, type: :float, foreign_key: true

  end
end
