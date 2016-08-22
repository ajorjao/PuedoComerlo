require 'open_uri_redirections'

class Product < ActiveRecord::Base
	has_and_belongs_to_many :intolerances

	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
	def image_from_url(url)
		self.image = open(url, :allow_redirections => :safe)
	end
end
