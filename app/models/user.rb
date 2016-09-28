require 'open_uri_redirections'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/avatar/:style/default_avatar.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :families, dependent: :destroy
  has_many :comments, dependent: :destroy

  before_destroy :delnotify
  
  def avatar_from_url(url)
    self.avatar = open(url, :allow_redirections => :safe)
  end

  private
    def delnotify
      notificaciones = Notification.where(from_id: self.id)
      notificaciones.each do |notificacion|
        notificacion.destroy
      end
    end
end
