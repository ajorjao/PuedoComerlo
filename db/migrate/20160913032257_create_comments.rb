class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title	#?????? título para comentarios?? ala google play???
      t.text :description	#esto debería ser el contenido del comentario??
      t.integer :likes
      t.integer :dislikes
      #begin fabo edit#
      t.integer :user_id    #id de quien lo crea
      t.integer :product_id  #id del producto comentado
      #end fabo edit#

      t.timestamps null: false
    end
  end
end
