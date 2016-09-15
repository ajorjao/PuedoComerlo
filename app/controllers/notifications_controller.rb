class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]
  skip_before_action :ask_loged, only: [:create]

  # GET /notifications
  # GET /notifications.json
  def index
    @notifications = Notification.all
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
    respond_to do |format|
      if @notification==nil
        format.json { render json: {error: "Esta notificacion ya no existe"}, status: :not_found }
        format.html {
          redirect_to root_path, notice: "Esta notificacion ya no existe"
        }
      else
        format.json { render json: {notification: @notification}, status: :ok }
        format.html {
          @notification.update(readed: true)
        }
      end
    end
  end

  # GET /notifications/new
  def new
    @notification = Notification.new
  end

  # GET /notifications/1/edit
  def edit
  end

  # POST /notifications
  # POST /notifications.json
  def create
    @recived = {nombre: params[:nombre], email: params[:mail], mensaje: params[:mensaje] }
    user = User.find_by_email(params[:mail])
    if user
      @notification = Notification.new(from_type: "contact", from_id: user.id, message:"#{params[:nombre]}:#{params[:mensaje]}")
      # @notification.readed = false
      # if @Notification.from_type != "contact"
      #   @notification.message = nil
      # end
      respond_to do |format|
        if @notification.save
          format.json { render json: {created: @notification}}
          format.html { redirect_to @notification, notice: 'Email enviado correctamente' }
        else
          format.json { render json: {error: "El email no pudo ser enviado: #{@notification.errors}"}, status: :unprocessable_entity }
          format.html { redirect_to root_path, notice: "El email no pudo ser enviado: #{@notification.errors}" }
        end
      end
    else
      respond_to do |format|
        format.json { render json: {error: "El email que nos has dado no esta registrado en nuestra aplicacion, por favor registrese y vuelva a intentarlo"}, status: 401 }
        format.html { redirect_to root_path, notice: 'El email que nos has dado no esta registrado en nuestra aplicacion, por favor registrese y vuelva a intentarlo' }
      end
    end
  end

  # PATCH/PUT /notifications/1
  # PATCH/PUT /notifications/1.json
  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.json { render :show, status: :ok, location: @notification }
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
      else
        format.json { render json: @notification.errors, status: :unprocessable_entity }
        format.html { render :edit }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_url, notice: 'Notification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notification_params
      params.require(:notification).permit(:from_type, :from_id, :message)
    end

    def ask_loged
      if current_user==nil
        respond_to do |format|
          format.json { render json: {error: 'No estas logeado'}, status: 401 }
          format.html { redirect_to root_path }
        end
      end
    end
end
