Rails.application.routes.draw do
  devise_for :users

  # Photos
  get("/photos",                        { :controller => "photos",            :action => "index" })
  get("/photos/new",                    { :controller => "photos",            :action => "new"   })
  post("/photos/create",                { :controller => "photos",            :action => "create"})
  get("/photos/:an_id",                 { :controller => "photos",            :action => "show"  })
  get("/photos/:an_id/edit",            { :controller => "photos",            :action => "edit"  })
  post("/photos/:an_id/update",         { :controller => "photos",            :action => "update"})
  get("/delete_photo/:an_id",           { :controller => "photos",            :action => "destroy"})

  # Comments
  get("/comments",                      { :controller => "comments",          :action => "index" })
  get("/comments/new",                  { :controller => "comments",          :action => "new"   })
  post("/comments/create",              { :controller => "comments",          :action => "create"})
  get("/comments/:an_id",               { :controller => "comments",          :action => "show"  })
  get("/comments/:an_id/edit",          { :controller => "comments",          :action => "edit"  })
  post("/comments/:an_id/update",       { :controller => "comments",          :action => "update"})
  get("/delete_comment/:an_id",         { :controller => "comments",          :action => "destroy"})

  # Likes
  get("/likes",                         { :controller => "likes",             :action => "index" })
  get("/likes/new",                     { :controller => "likes",             :action => "new"   })
  post("/likes/create",                 { :controller => "likes",             :action => "create"})
  get("/likes/:an_id",                  { :controller => "likes",             :action => "show"  })
  get("/likes/:an_id/edit",             { :controller => "likes",             :action => "edit"  })
  post("/likes/:an_id/update",          { :controller => "likes",             :action => "update"})
  get("/delete_like/:an_id",            { :controller => "likes",             :action => "destroy"})

  # FollowRequests
  get("/follow_requests",               { :controller => "follow_requests",   :action => "index" })
  get("/follow_requests/new",           { :controller => "follow_requests",   :action => "new"   })
  post("/follow_requests/create",       { :controller => "follow_requests",   :action => "create"})
  get("/follow_requests/:an_id",        { :controller => "follow_requests",   :action => "show"  })
  get("/follow_requests/:an_id/edit",   { :controller => "follow_requests",   :action => "edit"  })
  post("/follow_requests/:an_id/update",{ :controller => "follow_requests",   :action => "update"})
  get("/delete_follow_request/:an_id",  { :controller => "follow_requests",   :action => "destroy"})

  # Users (public index & show)
  get("/users",                         { :controller => "users",             :action => "index" })
  get("/users/:an_id",                  { :controller => "users",             :action => "show"  })
end
