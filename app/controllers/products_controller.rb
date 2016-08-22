require 'rest_client'

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
    if @products.count>0
      render json: {products: @products}
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
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
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
      params.require(:product).permit(:id, :name)
    end
end
