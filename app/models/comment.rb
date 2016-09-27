class Comment < ActiveRecord::Base
	validate :is_critical, on: :update
	
	belongs_to :user
	belongs_to :product

	before_destroy :delnot

	def prom_likes
		self.likes - self.dislikes
	end
		
	private
		def is_critical
			if self.prom_likes<-14
				notificacion = Notification.find_by(from_type: 0, from_id: self.id)
				if notificacion==nil
					Notification.create(from_type: 0, from_id: self.id)
				else
					notificacion.readed = false
					notificacion.save
				end
			end
		end

		def delnot
			notificacion = Notification.find_by(from_id: self.id)
			notificacion.delete
		end
end
