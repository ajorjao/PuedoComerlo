class Comment < ActiveRecord::Base
	validate :is_critical, on: :update
	
	belongs_to :user
	belongs_to :product

	before_destroy :delnotify

	def prom_likes
		self.likes - self.dislikes
	end
		
	private
		def is_critical
			if self.prom_likes<-14
				notification = Notification.find_by(from_type: 0, from_id: self.id)
				if notification==nil
					Notification.create(from_type: 0, from_id: self.id)
				else
					notification.readed = false
					notification.save
				end
			elsif self.prom_likes >= -14
				notification = Notification.find_by(from_type: 0, from_id: self.id)
				ap notification
				if notification != nil
					notification.destroy 
				end
			end
		end

		def delnotify
			notification = Notification.find_by(from_id: self.id)
			notification.delete if notification
		end
end
