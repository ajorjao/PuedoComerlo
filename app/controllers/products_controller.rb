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

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def migrate_new_products
    begin
      readed_file = File.open(params[:filename], 'r')
      # doc = readed_file.read
      hash = eval(readed_file.read)
      readed_file.close

      hash.each do |barcode, product_name|
        #se crea cada producto solo si no existe anteriormente uno con el mismo codigo de barras
        Product.create(id: barcode.to_i, name: product_name) if Product.find_by_id(barcode.to_i)==nil
      end
      success = true
    rescue Exception => e
      p 'error, el archivo a migrar no está en PuedoComerlo/app/controllers/'+params[:filename]+', o no posee un formato correcto'
      p e
    end

    respond_to do |format|
      if success
        format.json { render json: {created: @product}, status: :created }
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
      else
        format.json { render json: @product.errors, status: :unprocessable_entity }
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
