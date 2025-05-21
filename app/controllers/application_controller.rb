class ApplicationController < ActionController::Base
  # Require login on all pages unless explicitly skipped
  before_action :authenticate_user!

  # Allow additional Devise params (like username, private flag)
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # Allow custom fields on sign up and account update
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :private])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :private])
  end
end

