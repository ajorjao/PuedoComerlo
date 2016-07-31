class CreateIntolerancesProducts < ActiveRecord::Migration
  def change
    create_table :intolerances_products do |t|
      t.references :intolerance, index: true, foreign_key: true
      # t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end

    # add_column :intolerances_products, :product_id, :bigint, limit: 16
    add_column :intolerances_products, :product_id, :bigint
    add_foreign_key :intolerances_products, :products, column: :product_id, primary_key: "id", on_delete: :cascade

  end
end
