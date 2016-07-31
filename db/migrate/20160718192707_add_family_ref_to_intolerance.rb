class AddFamilyRefToIntolerance < ActiveRecord::Migration
  def change
    add_column :intolerances, :family, :integer
  end
end
