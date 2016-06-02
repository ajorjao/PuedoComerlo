require 'rest_client'

class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    respond_to do |format|
      if @product==nil
        format.json { render json: {error: "El producto no se encuentra disponible en nuestra base de datos"}, status: :not_found }
      else
        format.json { render json: @product, status: :ok }
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
