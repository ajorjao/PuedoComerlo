require 'open_uri_redirections'

class Product < ActiveRecord::Base
	has_and_belongs_to_many :intolerances
	has_many :comments, dependent: :destroy

	self.per_page = 10

	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/productimage/:style/producto_default.png"
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/


	validate :unliked_undenounced, on: :create
	validate :is_critical, on: :update

	def image_from_url(url)
		self.image = open(url, :allow_redirections => :safe)
	end

	private
		def unliked_undenounced
			self.likes = 0
			self.denounced = 0
		end

		def is_critical
			if self.denounced!=0 and self.denounced%5==0
				notificacion = Notification.find_by(from_type: 1, from_id: self.id)
				if notificacion==nil
					Notification.create(from_type: 1, from_id: self.id)
				else
					notificacion.readed = false
					notificacion.save
				end
			end
		end
end
