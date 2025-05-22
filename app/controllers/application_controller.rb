class ApplicationController < ActionController::Base

  before_action :authenticate_user!, unless: :devise_or_home_controller?

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :private])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :private])
  end

 
  def after_sign_in_path_for(resource)
    root_path
  end

  
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  
  def devise_or_home_controller?
    devise_controller? || controller_name == "home"
  end
end
