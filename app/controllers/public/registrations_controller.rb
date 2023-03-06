# frozen_string_literal: true

class Public::RegistrationsController < Devise::RegistrationsController
  #public/sessions_controllerのcreateアクションが実行される前に確認を行う
  before_action :user_state, only: [:create]
  
  #サインイン後の移動画面を指定
  def after_sign_in_path_for(resource)
    public_posts_path
  end
  
  def after_sign_out_path_for(resource)
    public_path # ログアウト後に遷移するpathを設定
  end
  
  protected
  # 退会しているかを判断するメソッド
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
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
