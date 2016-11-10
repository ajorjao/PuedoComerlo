require 'open_uri_redirections'

class Product < ActiveRecord::Base
	has_and_belongs_to_many :intolerances
	has_many :comments, dependent: :destroy

	self.per_page = 10

	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/productimage/:style/producto_default"
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

	validate :add_intolerances, on: :create
	validate :is_critical, on: :update

	before_destroy :delnotify

	def image_from_url(url)
		self.image = open(url, :allow_redirections => :safe)
	end

	def update_intolerances(new_ingredients)
		#borrar las antiguas intolerancias
		self.intolerances.delete_all

		Intolerance.all.each do |intolerancia|
			#se recorre cada key compoent desde las intolerancias
			intolerancia.key_components.each do |component|
				#si posee un key_component en los ingredientes, se agrega la intolerancia al producto
				new_ingredients.split(" ").each do |palabra_ingrediente|
					if palabra_ingrediente.downcase.similar(component.downcase) > 80
						self.intolerances << intolerancia if !self.intolerances.include?(intolerancia)
					end
				end
			end
		end
	end

	private
		def add_intolerances
			self.likes = 0
			self.denounced = 0
			if self.ingredients != nil
				#raise ActiveRecord::Rollback, "El producto debe ser distinto de nil"
			
				Intolerance.all.each do |intolerancia|
					#se recorre cada key compoent desde las intolerancias
					intolerancia.key_components.each do |component|
						#si posee un key_component en los ingredientes, se agrega la intolerancia al producto
						self.ingredients.split(" ").each do |palabra_ingrediente|
							if palabra_ingrediente.downcase.similar(component.downcase) > 80
								self.intolerances << intolerancia if !self.intolerances.include?(intolerancia)
							end
						end
					end
				end
			end
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

		def delnotify
			notificacion = Notification.find_by(from_id: self.id)
			notificacion.delete if notificacion
		end
end
