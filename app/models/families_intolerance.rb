class FamiliesIntolerance < ActiveRecord::Base
	belongs_to:intolerance
	belongs_to:family
end
