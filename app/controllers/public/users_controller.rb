class Public::UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(current_user.id)
    render:edit
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
    #user情報更新成功のflash message
      flash[:notice] = "You have updated user successfully."
      redirect_to public_user_path(current_user.id)
    else
      render:edit
    end
  end

  def unsubscribe
  end

  def withdraw
  end
  
  private
  # ストロングパラメータ
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
