require 'net/http'

class IntolerancesController < ApplicationController
  before_action :set_intolerance, only: [:show, :edit, :update, :destroy]

  # GET /intolerances
  # GET /intolerances.json
  def index
    @intolerances = Intolerance.all
  end

  # GET /intolerances/1
  # GET /intolerances/1.json
  def show
  end

  # GET /intolerances/new
  def new
    @intolerance = Intolerance.new
  end

  # GET /intolerances/1/edit
  def edit
  end

  # POST /intolerances
  # POST /intolerances.json
  def create
    @intolerance = Intolerance.new(intolerance_params)

    respond_to do |format|
      if @intolerance.save
        format.html { redirect_to @intolerance, notice: 'Intolerance was successfully created.' }
        format.json { render :show, status: :created, location: @intolerance }
      else
        format.html { render :new }
        format.json { render json: @intolerance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /intolerances/1
  # PATCH/PUT /intolerances/1.json
  def update
    respond_to do |format|
      if @intolerance.update(intolerance_params)
        format.html { redirect_to @intolerance, notice: 'Intolerance was successfully updated.' }
        format.json { render :show, status: :ok, location: @intolerance }
      else
        format.html { render :edit }
        format.json { render json: @intolerance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /intolerances/1
  # DELETE /intolerances/1.json
  def destroy
    @intolerance.destroy
    respond_to do |format|
      format.html { redirect_to intolerances_url, notice: 'Intolerance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  # def google_search(product_name)
  def google_search #solo para hacer pruebas
    product_name = params[:product_name] #solo para hacer pruebas
    product_name = product_name.gsub(" ", "+")
    url = 'https://www.google.cl/?gws_rd=ssl#q=ingredientes+'+product_name+'&nfpr=1'
    # req = Net::HTTP::Get.new(url.to_s)
    # res = Net::HTTP.start(url.host, url.port) {|http|
    #   http.request(req)
    # }
    # p res.body
    render json: { url_busqueda: url.to_s}
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_intolerance
      @intolerance = Intolerance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def intolerance_params
      params.require(:intolerance).permit(:name, :minor_symptom, :medium_symptom, :major_symptom, :key_component)
    end
end
