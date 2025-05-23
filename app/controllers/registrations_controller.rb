 class RegistrationsController < Devise::RegistrationsController
    def update
      current_user.username = params.fetch("username")
      current_user.save

      flash[:notice] = "Your profile has been updated"
      redirect_to("/")
    end
  end
