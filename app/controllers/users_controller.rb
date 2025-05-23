class UsersController < ApplicationController
  skip_before_action(:authenticate_user!, { :only => [:index] })

  def index
    @list_of_users = User.all
    render({ :template => "users/index" })
  end

  def show
    the_id       = params.fetch("an_id")
    @the_user    = User.where({ :id => the_id }).at(0)
    render({ :template => "users/show" })
  end
end
