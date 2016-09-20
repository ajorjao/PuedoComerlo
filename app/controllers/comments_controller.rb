class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
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
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:product_id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    #fabo was here
    @product = Product.find_by_id(params[:product_id])
    @comment = @product.comments.create(comment_params)
    @comment.user_id = current_user.id
    #end fabo was here
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    #fabo edit
    #recover?
    if current_user.id == @comment.user_id  #not sure if this goes here
      respond_to do |format|
        if @comment.update(comment_params)
          #código#
          format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
          format.json { render :show, status: :ok, location: @comment }
        else
          format.html { render :edit }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
      #end fabo edit
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    #check comment is from current user
    #fabo edit
    if current_user.id == @comment.user_id  #not sure if this goes here
      @comment.destroy
      respond_to do |format|
        #replace text with [Deleted]#
        format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
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
