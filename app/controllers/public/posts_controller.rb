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
      flash[:notice] = "投稿が成功しました！"
      redirect_to public_post_path(@post)
    else
      render :new
    end
  end

  def index
    #@posts = Post.all
    @genres = Genre.all
    @posts = params[:name].present? ? Genre.find(params[:name]).posts : Post.all.order("created_at DESC")
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user.id)
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
     if @post.update(post_params)
      #更新成功のflash message
      flash[:notice] = "更新が成功しました！"
      redirect_to public_post_path(@post)
     else
        render:edit
     end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to public_posts_path
  end
  
  private
  #ストロングパラメータ
  def post_params
    params.require(:post).permit(:title, :alcohol, :summary, :ingredient, :cook, :image, :release, :genre_id )
  end
end
