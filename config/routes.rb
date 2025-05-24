Rails.application.routes.draw do
   devise_for :users, { :sign_out_via => :get }


     root({ controller: "pages", action: "home" })

     # Photos
     get   "/photos",                 { controller: "photos", action: "index"  }
     get   "/photos/new",             { controller: "photos", action: "new"    }
     post  "/photos/create",          { controller: "photos", action: "create" }
     get   "/photos/:an_id",          { controller: "photos", action: "show"   }
     get   "/photos/:an_id/edit",     { controller: "photos", action: "edit"   }
     post  "/photos/:an_id/update",   { controller: "photos", action: "update" }
     get   "/delete_photo/:an_id",    { controller: "photos", action: "destroy"}

     # Comments
     post  "/comments/create",        { controller: "comments", action: "create" }

     # Likes
     post  "/likes/create",           { controller: "likes", action: "create"  }
     get   "/delete_like/:an_id",     { controller: "likes", action: "destroy" }

     # Follow Requests
     post  "/follow_requests/create",    { controller: "follow_requests", action: "create" }
     get   "/delete_follow_request/:an_id",{ controller: "follow_requests", action: "destroy" }

     # Users
     get   "/users",                   { controller: "users", action: "index" }
     get   "/users/:username",         { controller: "users", action: "show"  }
     get   "/users/:username/feed",        { controller: "users", action: "feed"         }
     get   "/users/:username/liked_photos",{ controller: "users", action: "liked_photos" }
     get   "/users/:username/discover",    { controller: "users", action: "discover"     }
   end
