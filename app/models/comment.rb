class Comment < ActiveRecord::Base
	validate :is_critical, on: :update
	
	#begin of Fabo edit#
	belongs_to:user
	belongs_to:product
	#end of Fabo edit#
	
	def prom_likes
		self.likes - self.dislikes
	end
		
	private
		def is_critical
			if self.prom_likes<0 and self.prom_likes%5==0
				notificacion = Notification.find_by(from_type: 0, from_id: self.id)
				if notificacion==nil
					Notification.create(from_type: 0, from_id: self.id)
				else
					notificacion.readed = false
					notificacion.save
				end
			end
		end
end
