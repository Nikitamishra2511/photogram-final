class PagesController < ApplicationController
  # Allow anyone to see the home page
  skip_before_action(:authenticate_user!, { :only => [:home] })

  def home
    all_photos    = Photo.where({ })
    public_photos = []

    all_photos.each do |p|
      owner = User.where({ :id => p.owner_id }).at(0)
      next if owner.private
      public_photos.push(p)
    end

    @list_of_photos = public_photos
    render({ :template => "page_templates/home" })
  end
end
