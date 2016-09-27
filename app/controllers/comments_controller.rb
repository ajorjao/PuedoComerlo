class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
    respond_to do |format|
      format.json{ render json: @comments }
      format.html{}
    end
  end

  #GET comments/id
  def getcomm
    @comment = Comment.find_by_id(params[:id])
    if @comment==nil
      format.json { render json: {error: "Este comentario ya no existe"}, status: :not_found }
      format.html {
        redirect_to root_path, notice: "Este comentario ya no existe"
      }
    else
    #mostrar comentario; Formato API  
      format.json { render json: {comment: @comment}, status: :ok }
      format.html {
        notificacion = Notification.find_by(from_type: 0, from_id: @comment.id)
        if notificacion!=nil
          notificacion.update(readed: true)
        end
      }
    end
  end


  def productcomments
    @product = Product.find_by_id(params[:id])
    respond_to do |format|
      if @product==nil
        format.json { render json: {error: "Este producto no existe"}, status: :not_found }
        format.html {
          redirect_to root_path, notice: "Este producto no existe"
        }
      else
        @comments = []
        # @product.comments.order(likes: :desc).each do |comment|
        @product.comments.order(:created_at).each do |comment|
          comment_hash = comment.attributes
          comment_hash.delete("user_id")
          comment_hash.delete("product_id")
          comment_hash[:prom_likes] = comment.prom_likes
          comment_hash[:user] = comment.user
          @comments.push(comment_hash)
        end
        format.json { render json: {comments: @comments}, status: :ok }
        format.html {

        }
      end
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    respond_to do |format|
      #comentario borrado
      if @comment==nil
        format.json { render json: {error: "Este comentario ya no existe"}, status: :not_found }
        format.html {
          redirect_to root_path, notice: "Este comentario ya no existe"
        }
      else
      #mostrar comentario; Formato API  
        format.json { render json: {comment: @comment}, status: :ok }
        format.html {
          notificacion = Notification.find_by(from_type: 0, from_id: @comment.id)
          if notificacion!=nil
            notificacion.update(readed: true)
          end
        }
      end
    end
  end

  # GET /comments/new
  def new
    @product = Product.find(params[:product_id])
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    @product = Product.find(params[:product_id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.create(title: params[:title], description: params[:description], product_id: params[:product_id])
    @comment.likes = 0
    @comment.dislikes = 0
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.json { render json: {comment: @comment}, status: :ok }
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    #fabo edit
    #recover?
    #if current_user.id == @comment.user_id  #not sure if this goes here
      #@Product = Product.find(params[:product_id])
    @comment = current_user.comments.find_by_id(params[:id])
    # @comment = Comment.where(user_id: current_user.id).find_by_id(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        #código#
        format.json { render :show, status: :ok, location: @comment }
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
        format.html { render :edit }
      end
    end
    #end fabo edit
    #end
  end

  def like_dislike
    @comment = Comment.find_by_id(params[:id])
    if @comment
      @comment.update(likes: @comment.likes+1) if params[:like]
      @comment.update(dislikes: @comment.dislikes+1) if params[:dislike]
      @comment.update(likes: @comment.likes-1) if params[:like_cancel]
      @comment.update(dislikes: @comment.dislikes-1) if params[:dislike_cancel]

      # respond_to do |format|
      render json: @comment, status: :ok
        # format.html { redirect_to "@comment", notice: 'Comment was successfully updated.' }
      # end
    else
      # respond_to do |format|
      render json: {error: "El comentario ya no existe"}, status: 404
        # format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
      # end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    #check comment is from current user
    #fabo edit
    @comment = Comment.where(user_id: current_user.id).find_by_id(params[:id])
    #@product = Product.find_by_id(params[:product_id])
    #if current_user.id == @comment.user_id  #not sure if this goes here
      #@product = Product.find(params[:product_id])
      #@comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      #replace text with [Deleted]#
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' } #debería ser /producto#comentarios??
      format.json { head :no_content }
    end
    #end
    #end of fabo edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      #agregar los parámetros que modifiqué en el modelo.
      params.require(:comment).permit(:title, :description, :likes, :dislikes, :user_id, :product_id)
      #params.require(:comment).permit(:title, :description, :likes, :dislikes, :parent_comment)
    end
end
