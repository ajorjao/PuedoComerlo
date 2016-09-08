class BannedUsersController < ApplicationController
  before_action :set_banned_user, only: [:show, :edit, :update]

  # GET /banned_users
  # GET /banned_users.json
  def index
    @banned_users = BannedUser.all
    render json: @banned_users
  end

  # GET /banned_users/1
  # GET /banned_users/1.json
  def show
  end

  # GET /banned_users/new
  def new
    @banned_user = BannedUser.new
  end

  # GET /banned_users/1/edit
  def edit
  end

  # POST /banned_users
  # POST /banned_users.json
  def create
    if current_user==nil
        render json: {error: 'No estas logeado'}, status: 401
    elsif current_user.admin == true
      if BannedUser.find_by_email(params[:banned_user][:email])!=nil
        render json: {error: "El usuario #{params[:banned_user][:email]} ya estaba baneado"}
      else
        @banned_user = BannedUser.new(banned_user_params)
        respond_to do |format|
          if @banned_user.save
            format.json { render json: @banned_user, status: :created }
            format.html { redirect_to @banned_user, notice: 'Banned user was successfully created.' }
          else
            format.json { render json: @banned_user.errors, status: :unprocessable_entity }
            format.html { render :new }
          end
        end
      end
    else
      render json: {error: "No posees los permisos para banear un usuario"}
    end
  end

  # PATCH/PUT /banned_users/1
  # PATCH/PUT /banned_users/1.json
  def update
    respond_to do |format|
      if @banned_user.update(banned_user_params)
        format.html { redirect_to @banned_user, notice: 'Banned user was successfully updated.' }
        format.json { render :show, status: :ok, location: @banned_user }
      else
        format.html { render :edit }
        format.json { render json: @banned_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /banned_users/1
  # DELETE /banned_users/1.json
  def destroy
    if current_user==nil
        render json: {error: 'No estas logeado'}, status: 401
    elsif current_user.admin == true
      @banned_user = BannedUser.find_by_email(params[:banned_user][:email])
      if @banned_user == nil
        render json: {error: "El usuario '#{params[:banned_user][:email]}' no estaba baneado"}, status: 404
      else
        @banned_user.destroy
        respond_to do |format|
          format.json { render json: {destroyed: "Usuario '#{@banned_user.email}' desbaneado correctamente"} }
          format.html { redirect_to banned_users_url, notice: 'Banned user was successfully destroyed.' }
        end
      end
    else
      render json: {error: "No posees los permisos para banear un usuario"}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_banned_user
      @banned_user = BannedUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def banned_user_params
      params.require(:banned_user).permit(:email)
    end
end