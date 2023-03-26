class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  #サインイン後の場所指定
  def after_sign_in_path_for(resource)
    public_user_path(current_user.id)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
