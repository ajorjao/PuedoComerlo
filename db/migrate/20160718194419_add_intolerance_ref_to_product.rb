class AddIntoleranceRefToProduct < ActiveRecord::Migration
  def change
    add_column :products, :intolerance, :integer
  end
end
