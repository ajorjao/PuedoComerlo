class Intolerance < ActiveRecord::Base
	has_and_belongs_to_many :families
	has_and_belongs_to_many :products
	serialize :key_components, Array
end
