class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    
    if @user == current_user
      #本人が見る非公開を含む投稿一覧（最新を上に表示 + kaminariでのページネーション）
      @posts = @user.posts.order("id DESC").page(params[:page])
    else
      #他人が見る個人の投稿一覧（公開設定した投稿のみ表示 + 最新を上に表示 + kaminariでのページネーション）
      @posts = @user.posts.released.order("id DESC").page(params[:page])
    end
  end
  
  def favorite
    #お気に入り一覧
    @user = User.find(current_user.id)
    bookmarks = Bookmark.where(user_id: current_user.id).pluck(:post_id)
    #ページネーション、並べ替えは取得するのが単数では動かない！！
    @bookmark_list = Post.where(id: bookmarks).order("id DESC").page(params[:page])
    @posts = @bookmark_list
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    #user情報更新成功のflash message
      flash[:notice] = "プロフィールが更新されました！"
      redirect_to public_user_path(current_user.id)
    else
      render:edit
    end
  end

  def unsubscribe
  end

  def withdraw
    #退会機能
    @user = User.find(current_user.id)
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    #論理削除は、アソシエーションでは消えないので、消したいものにdestroy_allをやる！
    @user.posts.destroy_all
    @user.comments.destroy_all
    @user.bookmarks.destroy_all
    #すべてのセッション情報を削除
    reset_session
    redirect_to public_root_path
  end
  
  private
  # ストロングパラメータ
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
