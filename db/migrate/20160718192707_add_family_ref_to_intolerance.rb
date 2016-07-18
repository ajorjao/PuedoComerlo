class AddFamilyRefToIntolerance < ActiveRecord::Migration
  def change
    add_column :intolerances, :family, :reference
  end
end
