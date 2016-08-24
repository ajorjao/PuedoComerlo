class AddIngredientsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :ingredients, :text
  end
end
