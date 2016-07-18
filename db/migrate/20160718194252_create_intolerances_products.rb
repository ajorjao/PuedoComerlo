class CreateIntolerancesProducts < ActiveRecord::Migration
  def change
    create_table :intolerances_products do |t|
      t.references :intolerance, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
