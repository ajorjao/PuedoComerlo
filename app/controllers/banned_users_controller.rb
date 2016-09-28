class BannedUsersController < ApplicationController
	before_action :set_banned_user, only: [:show, :edit, :update]
	before_action :ask_admin

	# GET /banned_users
	# GET /banned_users.json
	def index
		@banned_users = BannedUser.all
		respond_to do |format|
			format.json{ render json: @banned_users }
			format.html{}
		end
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
		if BannedUser.find_by_email(params[:banned_user][:email])!=nil
			respond_to do |format|
				format.json { render json: {error: "El usuario #{params[:banned_user][:email]} ya estaba baneado"} }
				format.html { redirect_to "/banned_users", notice: "El usuario #{params[:banned_user][:email]} ya estaba baneado" }
			end
		else
			begin
				@banned_user = BannedUser.new(banned_user_params)
				user = User.find_by_email(params[:banned_user][:email])
				if user != nil
					if user.admin != true
						user.destroy
					end
				end
				@banned_user.save
				respond_to do |format|
					format.json { render json: @banned_user, status: :created }
					format.html { redirect_to "/banned_users", notice: 'Email baneado correctamente' }
				end
			rescue Exception => e
				respond_to do |format|
					format.json { render json: {error: "No se pudo banear el email, #{e}"}, status: 400 }
					format.html { redirect_to "/banned_users", notice: "No se pudo banear el email, #{e}" }
				end
			end
		end
	end

	# PATCH/PUT /banned_users/1
	# PATCH/PUT /banned_users/1.json
	def update
		respond_to do |format|
			if @banned_user.update(banned_user_params)
				format.json { render :show, status: :ok, location: @banned_user }
				format.html { redirect_to @banned_user, notice: 'Banned user was successfully updated.' }
			else
				format.json { render json: @banned_user.errors, status: :unprocessable_entity }
				format.html { render :edit }
			end
		end
	end

	# DELETE /banned_users/1
	# DELETE /banned_users/1.json
	def destroy
		@banned_user = BannedUser.find_by_id(params[:id])
		if @banned_user == nil
			respond_to do |format|
				format.json { render json: {error: "El usuario no estaba baneado"}, status: 404 }
				format.html { redirect_to "/banned_users" }
			end
		else
			@banned_user.destroy
			respond_to do |format|
				format.json { render json: {destroyed: "Email '#{@banned_user.email}' desbaneado correctamente"} }
				format.html { redirect_to "/banned_users", notice: "Email '#{@banned_user.email}' desbaneado correctamente" }
			end
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
