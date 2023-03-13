class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
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
    reset_session
    flash[:notice] = "退会しました_:(´ཀ`」 ∠):"
    redirect_to public_root_path
  end
  
  private
  # ストロングパラメータ
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
