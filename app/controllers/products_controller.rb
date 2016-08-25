require 'rest_client'
require 'similar_text'
# require 'rtesseract'

class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all.paginate(page: params[:page])
    render json: @products
    #will_paginate @products        #en las vistas se usa para tener una barra con las paginas disponibles
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
    	if product.intolerances.count != 0
    		@usable_products << product
    	end
    end
    if @usable_products.count>0
      render json: {products: @usable_products}
    else
      render json: {error: "No hay productos coincidentes con la busqueda"}, status: 404
    end
  end


  # POST /product/intolerance    //con parametros= {product_id: ###, intolerance_id: ###}
  def add_intolerance
    if current_user == nil
      render json: {error: 'No estas logeado'}, status: 401
    elsif current_user.admin == true
      producto = Product.find_by_id(params[:product_id])
      intolerancia = Intolerance.find_by_id(params[:intolerance_id])
      if producto == nil
        render json: {error: "No existe el producto en nuestra base de datos"}, status: 404
      elsif intolerancia == nil
        render json: {error: "No existe la intolerancia en nuestra base de datos"}, status: 404
      elsif producto.intolerances.include?(intolerancia)
          render json: {error: 'Ya posees las intolerancias seleccionadas'}, status: 400
      else
        producto.intolerances << intolerancia
        render json: {product: producto, intolerances: producto.intolerances}
      end
    else
      render json: {error: 'No posees permisos para agregar una intolerancia a esta persona'}, status: 401
    end
  end

  # DELETE /product/intolerance    //con parametros= {product_id: ###, intolerance_id: ###}
  def del_intolerance
    respond_to do |format|
      format.json{
        if current_user == nil
          render json: {error: 'No estas logeado'}, status: 401
        elsif current_user.admin == true
          producto = Product.find_by_id(params[:product_id])
          if producto == nil
            render json: {error: "No existe el producto en nuestra base de datos"}, status: 404
          # elsif intolerancia == nil
          #   render json: {error: "No existe la intolerancia en nuestra base de datos"}, status: 404
          else
            #si se posee la intlerancia que se quiere borrar
            intolerancia = Intolerance.find_by_id(params[:intolerance_id])
            if producto.intolerances.include?(intolerancia)
              # intolerancia = producto.intolerances.find_by_id(params[:intolerance_id])
              producto.intolerances.delete(params[:intolerance_id])
              render json: {success: "Intolerancia '#{intolerancia.name}' eliminada del producto #{producto.name}"}
            else
              render json: {error: 'No posees esa intolerancia'}, status: 404
            end
          end
        else
          render json: {error: 'No posees permisos para agregar una intolerancia a esta persona'}, status: 401
        end
      }
      format.html{
        producto = Product.find_by_id(params[:product_id])
        intolerancia = Intolerance.find_by_id(params[:intolerance_id])
        if producto.intolerances.include?(intolerancia)
          producto.intolerances.delete(params[:intolerance_id])
        end
        redirect_to "/products/#{producto.id.to_s}/edit"
      }
    end
  end


  # GET /products/1
  # GET /products/1.json
  def show
    respond_to do |format|
      if @product==nil
        format.json { render json: {error: "El producto no se encuentra disponible en nuestra base de datos"}, status: :not_found }
      else
        format.json { render json: {product: @product, intolerances: @product.intolerances}, status: :ok }
      end
      format.html {}
    end
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  def denounced_products
    if current_user.admin == true
      @products = Product.where(denounced: true)
    else
      redirect_to root_path
    end
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    if params[:id]!=nil
      respond_to do |format|
        if @product.save
          format.html { redirect_to @product, notice: 'Product was successfully created.' }
          format.json { render :show, status: :created, location: @product }
        else
          format.html { render :new }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.json { render json: {error: "product dont have an id defined"}, status: :unprocessable_entity }
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

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to 'denounced_products', notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
      end
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
