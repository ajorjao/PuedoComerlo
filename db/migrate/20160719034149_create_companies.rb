class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
		# t.bigint :id, limit: 12, null: false, index: {name: "index_companies_on_id", unique: true}, primary_key: true
		# t.bigint :id, null: false, index: {name: "index_companies_on_id", unique: true}, primary_key: true
		t.string :name
		t.string :url
	    t.timestamps null: false
    end
  end
end
