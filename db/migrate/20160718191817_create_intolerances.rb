class CreateIntolerances < ActiveRecord::Migration
  def change
    create_table :intolerances do |t|
      t.string :name
      t.text :minor_symptom
      t.text :medium_symptom
      t.text :major_symptom
      t.string :key_component

      t.timestamps null: false
    end
  end
end
