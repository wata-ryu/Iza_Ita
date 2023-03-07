class Public::PostsController < ApplicationController
  #Bootstrap の flash messageを使えるようにキーを許可する
  add_flash_types :success, :info, :warning, :danger
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "You have created book successfully."
      redirect_to public_post_path(@post.user_id)
    else
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user.id)
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private
  #ストロングパラメータ
  def post_params
    params.require(:post).permit(:title, :alcohol, :summary, :ingredient, :cook, :image, :release)
  end
end
