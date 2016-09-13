class AddLikesDenouncedToProduct < ActiveRecord::Migration
  def change
    add_column :products, :likes, :integer
    add_column :products, :denounced, :integer
  end
end
