Rails.application.routes.draw do
  # home page
  root to: "home#index"

  # Devise with a custom registrations controller
  devise_for :users, { :controllers => { :registrations => "registrations" } }

  # photos
  get  "/photos"            , { :controller => "photos", :action => "index" }
  get  "/photos/new"        , { :controller => "photos", :action => "new"   }
  post "/create_photo"      , { :controller => "photos", :action => "create"}
  get  "/photos/:id"        , { :controller => "photos", :action => "show"  }
  get  "/photos/:id/edit"   , { :controller => "photos", :action => "edit"  }
  post "/update_photo/:id"  , { :controller => "photos", :action => "update"}
  post "/delete_photo/:id"  , { :controller => "photos", :action => "destroy"}

  # comments
  post "/create_comment"      , { :controller => "comments", :action => "create" }
  post "/delete_comment/:id"  , { :controller => "comments", :action => "destroy"}

  # likes
  post "/create_like"         , { :controller => "likes", :action => "create" }
  post "/delete_like/:id"     , { :controller => "likes", :action => "destroy"}

  # follow requests
  post "/create_follow_request"     , { :controller => "follow_requests", :action => "create" }
  post "/update_follow_request/:id" , { :controller => "follow_requests", :action => "update" }
  post "/delete_follow_request/:id" , { :controller => "follow_requests", :action => "destroy"}

  # users
  get "/users"                          , { :controller => "users", :action => "index"          }
  get "/users/:username"                , { :controller => "users", :action => "show"           }
  get "/users/:username/feed"           , { :controller => "users", :action => "feed"           }
  get "/users/:username/liked_photos"   , { :controller => "users", :action => "liked_photos"  }
  get "/users/:username/discover"       , { :controller => "users", :action => "discover"       }
end
