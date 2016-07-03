class FamiliesController < ApplicationController
  before_action :set_family, only: [:show, :edit, :update, :destroy]

  # GET /families
  # GET /families.json
  def index
    @families = Family.all.paginate(page: params[:page])
    render json: @families
  end

  # GET /families/1
  # GET /families/1.json
  def show
    respond_to do |format|
      if @family==nil
        format.json { render json: {error: "El familiar no existe"}, status: :not_found }
      else
        format.json { render json: @family, status: :ok }
      end
      format.html {}
    end
  end

  # GET /families/new
  def new
    @family = Family.new
  end

  # GET /families/1/edit
  def edit
  end

  # POST /families
  # POST /families.json
  def create
    params[:family][:user_id] = current_user.id if params[:family][:user_id]==nil
    @family = Family.new(family_params)
    # if current_user.families.count == 0
    #   @family.default = true
    # end

    respond_to do |format|
      if @family.save
        format.json { render json: {created: @family} }
        format.html { redirect_to @family, notice: 'Family was successfully created.' }
      else
        format.json { render json: @family.errors, status: :unprocessable_entity }
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /families/1
  # PATCH/PUT /families/1.json
  def update
    respond_to do |format|
      if @family.update(family_params)
        format.json { render :show, status: :ok, location: @family }
        format.html { redirect_to @family, notice: 'Family was successfully updated.' }
      else
        format.json { render json: @family.errors, status: :unprocessable_entity }
        format.html { render :edit }
      end
    end
  end

  # DELETE /families/1
  # DELETE /families/1.json
  def destroy
    name = @family.name
    @family.destroy
    respond_to do |format|
      # format.json { head :no_content }
      format.json { render json: {destroyed: "Familiar '#{name}' eliminado correctamente"}, status: :ok }
      format.html { redirect_to families_url, notice: 'Family was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_family
      @family = Family.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def family_params
      params.require(:family).permit(:name, :user_id)
    end
end
