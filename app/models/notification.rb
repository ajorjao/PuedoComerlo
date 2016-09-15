class Notification < ActiveRecord::Base
	enum from_type: [ :comment, :product, :contact ]

	# before_save :not_readed
	validate :not_readed, on: :create

	private
		def not_readed
			self.readed = false
			if self.from_type != "contact"
				self.message = nil
			end
		end
end
