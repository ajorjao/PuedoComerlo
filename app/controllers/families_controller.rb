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
      if current_user==nil
        render json: {error: 'No estas logeado'}, status: 401
      elsif @family==nil
        format.json { render json: {error: "El familiar no existe"}, status: :not_found }
      elsif current_user.families.include?(@family)==false
        format.json { render json: {error: 'No posees permisos para ver a esta persona'}, status: 401 }
      else
        format.json { render json: {family: @family, intolerances: @family.intolerances} }
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

  # POST /family/intolerance    //con parametros= {family_id: ###, intolerances_ids: ###}
  def add_intolerance
    if current_user!=nil
      familiar = Family.find_by_id(params[:family_id])
      if current_user.families.include?(familiar)==false
        render json: {error: 'No posees permisos para agregar una intolerancia a esta persona', families: current_user.families}, status: 401
      else
        agregado = false
        intolerancias = Intolerance.where(id: params[:intolerances_ids].split(","))
        ap intolerancias
        intolerancias.each do |intolerancia|
          if familiar.intolerances.include?(intolerancia)==false
            familiar.intolerances << intolerancia
            agregado = true
          end
        end
        if agregado
          render json: {family: familiar, intolerances: familiar.intolerances}
        else
          render json: {error: 'Ya posees las intolerancias seleccionadas'}, status: 400
        end
      end
    else
      render json: {error: 'No estas logeado'}, status: 401
    end
  end

  # DELETE /family/intolerance    //con parametros= {family_id: ###, intolerance_id: ###}
  def del_intolerance
    if current_user!=nil
      familiar = Family.find_by_id(params[:family_id])
      if current_user.families.include?(familiar)==false #si el familiar no pertenece al usuario actual
        render json: {error: 'No posees permisos para eliminar una intolerancia de esta persona', families: current_user.families}, status: 401
      else #si el familiar pertenece al usuario actual
        intolerance = Intolerance.find_by_id(params[:intolerance_id])
        # si se posee la intlerancia que se quiere borrar
        if familiar.intolerances.include?(intolerance)
          familiar.intolerances.delete(params[:intolerance_id])
          render json: {success: "Intolerancia '#{intolerance.name}' eliminada"}
        else
          render json: {error: 'No posees esa intolerancia'}, status: 404
        end
      end
    else
      render json: {error: 'No estas logeado'}, status: 401
    end
  end

  # POST /families
  # POST /families.json
  def create
    params[:family][:user_id] = current_user.id if params[:family][:user_id]==nil
    @family = Family.new(family_params)
    if current_user.families.count == 0
      current_user.username = @family.name
      current_user.save
    end

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
    respond_to do |format|
      if current_user.families.include?(@family)
        @family.destroy
        format.json { render json: {destroyed: "Familiar '#{@family.name}' eliminado correctamente"}, status: :ok }
      else
        format.json { render json: {error: "No posees los permisos para eliminar a esta persona", families: current_user.families}, status: 401 }
        # format.json { head :no_content }
      end
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
