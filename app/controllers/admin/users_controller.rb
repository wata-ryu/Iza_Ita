class Admin::UsersController < ApplicationController
  
  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
  end

  def update
  end

  def withdraw
    #退会機能
    @user = User.find(user.id)
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "強制退会させました( ´Д`)y━･~~"
    redirect_to admin_root_path
  end
  
  private
  # ストロングパラメータ 基本削ることはない
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
