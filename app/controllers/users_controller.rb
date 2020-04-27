class UsersController < ApplicationController
  before_action :authorize
  def show
    @user = current_user || User.new
    @user_name = params[:id]
    if current_user
      redirect_to users_path
    end
  end

  def index

  end

  def edit
    @user = current_user
  end
end