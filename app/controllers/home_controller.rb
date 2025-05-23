def index
  @photos = Photo
    .joins(:owner)
    .where({ :users => { :private => false } })
    .order({ :created_at => :desc })

  render({ :template => "home/index" })
end
