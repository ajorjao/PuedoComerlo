class Notification < ActiveRecord::Base
	enum from_type: [ :comment, :product, :contact ]
end
