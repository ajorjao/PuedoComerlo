class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies, id: false do |t|
			t.integer :id, limit: 10
			t.string :name

      # t.timestamps null: false
    end
  end
end
