class Admin::PostsController < ApplicationController
  def index
    @genres = Genre.all
    if params[:name].present?
      @genre = Genre.find(params[:name])
      @posts = @genre.posts.page(params[:page])
    else
      #全体投稿一覧（最新を上に表示）
      @posts = Post.all.order("created_at DESC").page(params[:page])
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user.id)
    #コメント機能についての定義（最新を上に表示）
    @comments = @post.comments.order(created_at: :desc)
  end

  def destroy
    @user = User.find(params[:id])
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_user_path(@post.user)
  end
  
  private
  #ストロングパラメータ
  def post_params
    #idsは配列のため、genre_ids: []のような記述になる
    params.require(:post).permit(:title, :alcohol, :summary, :ingredient, :cook, :image, :release, genre_ids: [] )
  end
end
