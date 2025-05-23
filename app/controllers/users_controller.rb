class UsersController < ApplicationController
   # allow non-signed-in visitors to see index only; show remains behind auth
   skip_before_action(:authenticate_user!, { :only => [:index] })

   def index
     @list_of_users = User.all
     render({ :template => "users/index" })
   end

   def show
     the_username   = params.fetch("an_id")
     matching_users = User.where({ :username => the_username })
     @the_user      = matching_users.at(0)

     render({ :template => "users/show" })
   end
 end
