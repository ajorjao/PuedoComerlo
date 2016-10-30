require 'rest_client'
require 'similar_text'
# require 'rtesseract'
require 'will_paginate/array'

class ProductsController < ApplicationController
  before_action :set_product, only: [ :show, :edit, :update, :destroy ]
  before_action :ask_admin, only: [ :add_intolerance, :del_intolerance, :create, :update, :destroy, :denounced_products ]

  # GET /products
  # GET /products.json
  def index
    @products = Product.where.not(ingredients: nil).paginate(page: params[:page])
    respond_to do |format|
      format.json{ render json: @products }
      format.html{}
    end
  end

  # PUT /products
  def search
    @products = Product.all
    @products = @products.where("name ILIKE ?", "%#{params[:product][:name]}%") if params[:product][:name]!=nil
    #ESTA ES LA LINEA DE LOS MILAGROS :OOOOOO
    @products = @products.where("id::text ILIKE ?::text", "%#{params[:product][:id]}%") if params[:product][:id]!=nil
    #@products = @products.where("(id % 10^(length(?)) = ?)", "'#{params[:product][:id]}'","#{params[:product][:id]}") if params[:product][:id]!=nil
    @usable_products = []
    @products.each do |product|
    	if !product.ingredients.blank? # si se conocen los ingredientes del producto
        product.image_file_name = URI.join(request.url, product.image.url).path
    		@usable_products << {product: product, intolerancias: product.intolerances}
    	end
    end
    if @usable_products.count>0
      render json: {products: @usable_products}
    else
      render json: {error: "No hay productos coincidentes con la busqueda"}, status: 404
    end
  end

  # PUT /recommend_product/:id
  def recommend_product
    @product = Product.find_by_id(params[:id])
    if @product
      @product.update(likes: @product.likes+1)
      render json: @product
    else
      render json: {error: "El producto no existe"}, status: :not_found
    end
  end

  #PUT /recomended_products
  def recomended_products 
    user_intolerances = params[:user_intolerances].split(",").map { |id| id.to_i }
    @products = []
    # se buca entre los productos que posean ingredientes
    Product.where.not(ingredients: nil).order(likes: "desc").each do |producto|
      if (producto.intolerances.map{ |i| i.id } & user_intolerances) == []
        producto.image_file_name = URI.join(request.url, producto.image.url).path

        @products.push(producto)
      end
    end
    respond_to do |format|
      format.json { render json: @products.paginate(page: params[:page], per_page: 5) }
      format.html {  }
    end
  end

  # POST /suggest_product
  # se crea la ruta para que un usuario sugiera un producto
  def suggest_product
    # hay q hacer que el usuario pueda sacar una foto
    @suggested_product = Product.new(id: params[:barcode], name: params[:name])
    # para usar el producto sugerido se puede usar eval(@suggested_product)
    @notification = Notification.new(from_type: "suggest", from_id: @suggested_product.id)
    if existe = Product.find_by_id(@suggested_product.id)==nil
      if @suggested_product.save
        @notification.save
        #format.html { }
        render json: {sended: @suggested_product} #sent no sended
      else 
        render json: {error: "El producto no se pudo sugerir correctamente"}, status: :unprocessable_entity
      end
    else
      render json: {error: "El producto ya fue sugerido anteriormente como '#{existe.name}'"}, status: :unprocessable_entity  #modificar(?)
    end
  end

  # GET /suggested_products
  def suggested_products
    @suggested_products = Product.where(ingredients: nil)
    respond_to do |format|
      format.json { render json: @suggested_products }
      format.html {  }
    end
  end

  # POST /product/intolerance    //con parametros= {product_id: ###, intolerance_id: ###}
  def add_intolerance
    @product = Product.find_by_id(params[:product_id])
    @intolerance = Intolerance.find_by_id(params[:intolerance_id])
    respond_to do |format|
      if @product == nil
        format.json { render json: {error: "No existe el producto en nuestra base de datos"}, status: 404 }
        format.html { redirect_to "products/page/1", notice: "No existe el producto en nuestra base de datos" }
      elsif @intolerance == nil
        format.json { render json: {error: "No existe la intolerancia en nuestra base de datos"}, status: 404 }
        format.html { redirect_to "products/page/1", notice: "No existe la intolerancia en nuestra base de datos" }
      elsif @product.intolerances.include?(@intolerance)
        format.json { render json: {error: 'El producto ya posee la intolerancia seleccionada'}, status: 400 }
        format.html { redirect_to :back, notice: "El producto ya posee la intolerancia seleccionada" }
      else
        @product.intolerances << @intolerance
        format.json { render json: {product: producto, intolerances: producto.intolerances} }
        format.html { redirect_to "products/page/1", notice: "Intolerancia agregada correctamente" }
      end
    end
  end

  # DELETE /product/intolerance    //con parametros= {product_id: ###, intolerance_id: ###}
  def del_intolerance
    respond_to do |format|
      format.json{
        if current_user == nil
          render json: {error: 'No estas logeado'}, status: 401
        elsif current_user.admin == true
          @product = Product.find_by_id(params[:product_id])
          if @product == nil
            render json: {error: "No existe el producto en nuestra base de datos"}, status: 404
          # elsif intolerancia == nil
          #   render json: {error: "No existe la intolerancia en nuestra base de datos"}, status: 404
          else
            #si se posee la intlerancia que se quiere borrar
            @intolerance = Intolerance.find_by_id(params[:intolerance_id])
            if @product.intolerances.include?(@intolerance)
              # intolerancia = producto.intolerances.find_by_id(params[:intolerance_id])
              @product.intolerances.delete(params[:intolerance_id])
              render json: {success: "Intolerancia '#{@intolerance.name}' eliminada del producto #{@product.name}"}
            else
              render json: {error: 'No posees esa intolerancia'}, status: 404
            end
          end
        else
          render json: {error: 'No posees permisos para agregar una intolerancia a esta persona'}, status: 401
        end
      }
      format.html{
        @product = Product.find_by_id(params[:product_id])
        @intolerance = Intolerance.find_by_id(params[:intolerance_id])
        if @product.intolerances.include?(@intolerance)
          @product.intolerances.delete(params[:intolerance_id])
        end
        redirect_to "/products/#{@product.id}/edit", notice: "Intolerancia eliminada correctamente"
      }
    end
  end


  # GET /products/1
  # GET /products/1.json
  def show
    respond_to do |format|
      if @product==nil
        format.json { render json: {error: "El producto no se encuentra disponible en nuestra base de datos"}, status: :not_found }
        format.html { redirect_to root_path, notice: "El producto no se encuentra disponible en nuestra base de datos" }
      else
        @comments = @product.comments
        @product.image_file_name = URI.join(request.url, @product.image.url).path
        if @product.ingredients.blank?
          format.json { render json: {error: "El producto fue recientemente sugerido pero no se encuentra disponible"}, status: :not_found }
        else
          format.json { render json: {product: @product, intolerances: @product.intolerances, comments: @comments}, status: :ok }
        end
        format.html {
          notificacion = Notification.find_by(from_type: [1,3], from_id: @product.id)
          notificacion.update(readed: true) if notificacion != nil
        }
      end
    end
  end

  # GET /products/new
  def new

    @product = Product.new
  end

  def denounced_products

    @denounced_products = Product.where("denounced > ?", 0).order(denounced: :desc)
  end

  def denounce_product
    @product = Product.find_by_id(params[:product_id])
    @product.update(denounced: @product.denounced+1)
    render json: { product: @product }
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(name: params[:name], id: params[:id], ingredients: params[:ingredients])
    @product.image_from_url(params[:url])

    if params[:id]!=nil or params[:name]!=nil
      respond_to do |format|
        if @product.save
          format.json { render :show, status: :created, location: @product }
          format.html { redirect_to "/products/"+params[:id].to_s, notice: 'El producto fue creado exitosamente.' }
        else
          format.json { render json: @product.errors, status: :unprocessable_entity }
          format.html { render :new }
        end
      end
    else
      respond_to do |format|
        format.json { render json: {error: "El producto no puede quedar sin id"}, status: :unprocessable_entity }
        format.html { redirect_to "product/new", notice: "El producto no puede quedar sin código de barra." }
      end
    end
  end

  def migrate_new_products
    begin
      readed_file = File.open(params[:filename_path], 'r')
      # doc = readed_file.read
      products = eval(readed_file.read)
      total = products.length
      readed_file.close

      products_added = 0
      products.each do |barcode, product_name|
        #se crea cada producto solo si no existe anteriormente uno con el mismo codigo de barras
        if Product.find_by_id(barcode.to_i)==nil
          Product.create(id: barcode.to_i, name: product_name)
          products_added += 1
        end
      end
      success = true
    rescue Exception => e
      p 'error, el archivo a migrar no está en "PuedoComerlo/'+params[:filename_path]+'", o no posee un formato correcto'
      p e
    end

    respond_to do |format|
      if success
        p "products_added: #{products_added}"
        p "max total: #{total}"
        format.json { render json: {products_added: products_added}, status: :created }
        format.html { redirect_to products, notice: 'Products was successfully created.' }
      else
        format.json { render json: {error: e.to_s}, status: :unprocessable_entity }
        format.html { render :new }
      end
    end
  end

  # POST /migrate_txt_intolerances      //con parametros= {filename_path: [ruta del archivo desde PuedoComerlo/...], empresa: [nombre de empresa]}
  def migrate_txt_intolerances
    begin
      readed_file = File.open(params[:filename_path], 'r')
      # doc = readed_file.read
      products = readed_file.read.split("\n\n")
      total = products.length
      readed_file.close


      products_added = []
      products.each do |product|
        #################################################################################################
        # se intenta hacer coincidir los nombres del txt con los de nuestra base de datos
        #################################################################################################

          product_name, ingredientes, image = product.split("\n")
          if params[:empresa]!="all_companies"
            my_company_products = Product.where("name ILIKE ?", "%#{params[:empresa]}%")
            @mayor = 2
          else
            my_company_products = Product.all
            @mayor = 3
          end
          @posibles_productos = {}

          #@mayor = 2
          #se buscan cada palabra en el nombre del producto
          product_name.split(" ").each do |indicio_de_producto|
            # se salta el indicio de producto si este es el nombre de la empresa q se esta buscando (ya se hizo este filtro por lo q marcaria a todos con +1) o si el indicio es un int (por los kg gr, etc)
            if indicio_de_producto.casecmp(params[:empresa]) == 0 or indicio_de_producto[0].to_i != 0 or indicio_de_producto.casecmp("kg")==0 or indicio_de_producto.casecmp("grs")==0 or indicio_de_producto.casecmp("gr")==0
              next
            end
            #busca entre los productos de la empresa si posee el indicio del producto
            my_company_products.each do |posible_producto|
              #si el producto posee una diferencia de 1 letra con el producto
              p "Producto en BD: "+posible_producto.name
              p "Producto con Ing: "+product_name
              posible_producto.name.split(" ").each do |palabra|
                similitud = palabra.downcase.similar(indicio_de_producto.downcase)
                #p "P1: "+palabra.downcase
                #p "P2: "+indicio_de_producto.downcase
                if similitud >= 80
                  p "similitud es mayor a 80: "+similitud.to_s
                  p "palabra: "+palabra, "indicio_de_producto: "+indicio_de_producto
                  if @posibles_productos[posible_producto.name] == nil
                    @posibles_productos[posible_producto.name] = 1
                  else
                    @posibles_productos[posible_producto.name] = @posibles_productos[posible_producto.name]+1
                    @mayor = @posibles_productos[posible_producto.name] if @posibles_productos[posible_producto.name] > @mayor
                  end
                  p "@posibles_productos[#{posible_producto.name}]: "+@posibles_productos[posible_producto.name].to_s
                end
              end
            end
          end

          ap @posibles_productos
          p "@mayor: "+@mayor.to_s

          @probables_productos = []
          @posibles_productos.each do |nombre,cuenta|
            if cuenta == @mayor
              @probables_productos << nombre
            end
          end

        #################################################################################################
        # en este punto ya se identificaron algunos productos de los txt con los de nuestra base de datos
        #################################################################################################

        #si entre las coincidencas solo hay 1 posible producto que coincide con nuestra base de datos y el nombre del txt:
        if @probables_productos.length == 1
          product = Product.find_by_name(@probables_productos[0].to_s)
          product.image_from_url(image)

          #busqueda de intolerancia en la descripcion
          Intolerance.all.each do |intolerancia|
            #si es una imagen con las descripciones
            if ingredientes.include?("http")
              ####################################
              #aqui usar gema para leer la imagen#
              ####################################
              p ""
              p ""
              p ""
              p ""
              p "aqui usar gema para leer la imagen"
              p ""
              p ""
              p ""
              p ""
            else
              #se recorre cada key compoent desde las intolerancias
              intolerancia.key_components.each do |component|
                #si posee un key_component en los ingredientes, se agrega la intolerancia al producto
                ingredientes.split(" ").each do |palabra_ingrediente|
                  if ingredientes.downcase.similar(component.downcase)
                    product.intolerances << intolerancia if !product.intolerances.include?(intolerancia)
                  end
                end
              end
            end
            products_added << product if !products_added.include?(product)
          end
          product.ingredients = ingredientes
          product.save
          
        end
        #####################
      end
      success = true
    rescue Exception => e
      p ''
      p ''
      p 'error, el archivo a migrar no está en "PuedoComerlo/'+params[:filename_path]+'", o no posee un formato correcto'
      p e
      p ''
      p ''
    end

    if success
      render json: {num_productos: products_added.length, productos_añadidos: products_added}, status: :ok
    else
      render json: {error: e.to_s}, status: :unprocessable_entity
    end
    # end
  end

  def testing
    image = open(params[:image_url], :allow_redirections => :safe)
    # ej params[:proporciones] = 247x36+36+297
    width = params[:proporciones].split("x")[0].to_i
    height = params[:proporciones].split("x")[1].split("+")[0].to_i
    posx = params[:proporciones].split("x")[1].split("+")[1].to_i
    posy = params[:proporciones].split("x")[1].split("+")[2].to_i

    imagen = RTesseract::Mixed.new(image ,{:areas => [
      {:x => posx, :y=>posy, :w=>width, :h=>height }
    ]})

    # imagen = RTesseract.new(image, :lang => "spa")
    
    # imagen = RTesseract.new(image)

    result = imagen.to_s.gsub("V","Y")
    render json: {string: result}, status: :ok
  end

  # GET /products/1/edit
  def edit
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @product = Product.find_by(id: params[:product][:id])
    respond_to do |format|
      if @product.update(name: params[:product][:name], id: params[:product][:id], ingredients: params[:product][:ingredients], denounced: params[:product][:denounced])
        @product.image_from_url(params[:url]) if !params[:url].blank?
        @product.save
        format.json { render json: {updated: @product}, status: :ok, location: @product }
        format.html { redirect_to "/products/"+params[:id].to_s, notice: 'Producto modificado correctamente' }
      else
        format.json { render json: @product.errors, status: :unprocessable_entity }
        format.html { render :edit }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to '/products/page/1', notice: 'Producto eliminado correctamente' }
      format.json { head :no_content }
    end
  end


  def ask_database
    user_intolerances = params[:user_intolerances].split(",").map { |id| id.to_i }

    # la variable esta en KB. Se empieza con 2 por el inicio y cierre de corchetes []
    # size_products = 2*2.0/1024
    size_products = 2

    Product.where.not(ingredients: nil).each do |producto|
      product_intolerances = producto.intolerances.map{ |i| i.id }
      if (producto.intolerances.map{ |i| i.id } & user_intolerances) != []
        this_product = {id: producto.id, name: producto.name, ingredients: producto.ingredients, intolerances: product_intolerances}.to_s
        # se resta 4 porque los "algo:" se combierten en "algo=>" al usar .to_s
        # y se suma 1 ya que con cada producto agregado se agrega una coma
        # size_products += (this_product.length - 4 + 1)*2.0/1024
        size_products += (this_product.length - 4 + 1)
      end
    end
    render json: {size_products: size_products}
  end


  def download_database
    user_intolerances = params[:user_intolerances].split(",").map { |id| id.to_i }
    @products = []
    # se buca entre los productos que posean ingredientes
    Product.where.not(ingredients: nil).each do |producto|
      product_intolerances = producto.intolerances.map{ |i| i.id }
      # si el producto posee alguna de las intolerancias
      if (product_intolerances & user_intolerances) != []
        hash_product = {id: producto.id, name: producto.name, ingredients: producto.ingredients, intolerances: product_intolerances}
        @products.push(hash_product)
      end
    end
    # @products.map {|product| {id: product.id, name: product.name, ingredients: product.ingredients}}
    render json: @products
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:id, :name, :image, :likes, :denounced)
    end
end
