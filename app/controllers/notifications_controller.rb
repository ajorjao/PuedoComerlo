class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]
  skip_before_action :ask_loged, only: [:create]

  # GET /notifications
  # GET /notifications.json
  def index
    @all_notifications = Notification.order(from_type: "asc", readed: "asc")
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

  def getmsg
    # ap @message
    if current_user.admin == true
      @message = Notification.where(from_type: 2)
    else
      redirect_to root_path
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
  # crear un mensaje de contactanos
  def create
    # @recived = {nombre: params[:nombre], email: params[:mail], mensaje: params[:mensaje] }
    user = User.find_by_email(params[:mail])
    if user
      @notification = Notification.new(from_type: "contact", from_id: user.id, message:"#{params[:nombre]}:#{params[:mensaje]}")
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
    if @notification.from_type == "product"
      @notification.destroy
      respond_to do |format|
        format.json { head :no_content }
        format.html { redirect_to denounced_products_path, notice: 'Notificacion eliminada correctamente' }
      end
    elsif @notification.from_type == "comment"
      @notification.destroy
      respond_to do |format|
        format.json { head :no_content }
        format.html { redirect_to denounced_comments_path, notice: 'Notificacion eliminada correctamente' }
      end
    
    elsif @notification.from_type == "contact"
      @notification.destroy
      respond_to do |format|
        format.json { head :no_content }
        format.html { redirect_to messages_path, notice: 'Notificacion eliminada correctamente' }
      end
    elsif @notification.from_type == "suggest"
      @notification.destroy
      respond_to do |format|
        format.json { head :no_content }
        format.html {redirect_to suggested_products_path, notice: 'Notificacion eliminada correctamente'}
      end
    else
      @notification.destroy
      respond_to do |format|
        format.json { head :no_content }
        format.html { redirect_to notifications_path, notice: 'Notificacion eliminada correctamente' }
      end
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
