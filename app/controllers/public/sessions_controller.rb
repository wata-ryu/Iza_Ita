# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  #public/sessions_controllerのcreateアクションが実行される前に確認を行う
  before_action :user_state, only: [:create]
  
  #サインイン後の移動画面を指定
  def after_sign_in_path_for(resource)
    public_posts_path
  end
  #ログアウト後に遷移するpathを設定
  def after_sign_out_path_for(resource)
    new_user_session_path
  end
  
  protected
  #退会しているかを判断するメソッド
  def user_state
    ## 【処理内容1】 入力されたemailからアカウントを1件取得
    @user = User.find_by(email: params[:user][:email])
    ## アカウントを取得できなかった場合、このメソッドを終了する
    return if !@user
    ## 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @user.valid_password?(params[:user][:password]) && @user.is_deleted == true
    ## 【処理内容3】
    #「1」と「2」の処理が真(true)だった場合、そのアカウントのis_deletedカラムに格納されている値を確認しtrueだった場合、退会しているのでサインアップ画面に遷移する
    redirect_to new_user_registration_path
    end
    #falseだった場合、退会していないのでそのままcreateアクションを実行させる処理を実行する
    
  end
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
