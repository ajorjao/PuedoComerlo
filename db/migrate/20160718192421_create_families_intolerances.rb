class CreateFamiliesIntolerances < ActiveRecord::Migration
  def change
    create_table :families_intolerances do |t|
      t.references :family
      t.references :intolerance

      t.timestamps null: false
    end
  end
end
