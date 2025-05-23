class PhotosController < ApplicationController
     # only index is public
     skip_before_action(:authenticate_user!, { :only => [:index] })

     def index
       all_photos    = Photo.where({ })   # loads all
       public_photos = []
       all_photos.each do |p|
         owner = User.where({ :id => p.owner_id }).at(0)
         next if owner.private
         public_photos.push(p)
       end

       @list_of_photos = public_photos
       render({ :template => "photos/index" })
     end

     # ... new, edit, update, destroy ...

     def create
       the_photo = Photo.new
       # ← use Devise’s current_user, not session
       the_photo.owner_id       = current_user.id
       the_photo.caption        = params.fetch("caption")
       the_photo.image          = params.fetch("image")
       the_photo.comments_count = 0
       the_photo.likes_count    = 0
       the_photo.save

       return redirect_to(
         "/",
         { :notice => "Photo added successfully." },
       )
     end

     def show
       the_id          = params.fetch("an_id")
       matching        = Photo.where({ :id => the_id })
       @the_photo      = matching.at(0)
       render({ :template => "photos/show" })
     end

     # …
   end
