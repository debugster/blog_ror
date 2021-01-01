class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :handle, :email, :password, :password_confirmation)}
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:login, :password)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :handle, :email, :password, :current_password)}
  end
end
