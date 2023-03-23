class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    #.order("id DESC") = 最新が一番上に来るように + kaminariページネーション
    @posts = @user.posts.order("id DESC").page(params[:page])
  end
  
  def favorite
    #お気に入り一覧
    @user = User.find(current_user.id)
    bookmarks = Bookmark.where(user_id: current_user.id).pluck(:post_id)
    @bookmark_list = Post.find(bookmarks)
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
