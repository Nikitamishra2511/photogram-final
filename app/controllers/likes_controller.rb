   class LikesController < ApplicationController
     before_action(:ensure_signed_in)

     def create
       new_like = Like.new
       new_like.photo_id = params.fetch("photo_id")
       new_like.fan_id   = params.fetch("fan_id")
       new_like.save

       flash[:notice] = "Like created successfully"
       redirect_to("/")
     end

     def destroy
       like = Like.where({ :id => params.fetch("id") }).at(0)
       like.destroy

       flash[:alert] = "Like deleted successfully"
       redirect_to("/")
     end

     private

     def ensure_signed_in
       unless user_signed_in?
         flash[:alert] = "You need to sign in or sign up before continuing."
         redirect_to("/users/sign_in")
       end
     end
   end
