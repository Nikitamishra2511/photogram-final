class PagesController < ApplicationController
    # Allow anyone to see the home page
    skip_before_action(:authenticate_user!, { :only => [:home] })

    def home
      render({ :template => "page_templates/home" })
    end
  end
