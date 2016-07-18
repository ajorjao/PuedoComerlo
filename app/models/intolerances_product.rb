class IntolerancesProduct < ActiveRecord::Base
  belongs_to :intolerance
  belongs_to :product
end
