class UsersController < ApplicationController
  before_action :authorize, only: [:update]
  def login
    @user = current_user || User.new
    @user_name = params[:id]
    if current_user
      redirect_to users_path and return
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.paginate(per_page: 12, page: params[:page])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update user_params
    redirect_to users_path
  end

  def locate
    binding.pry
    current_user.update params.require(:user).permit(:lat, :lngt)
  end

  protected

  def user_params
    params.require(:user).permit(:img, :question_1, :question_2, :question_3, :gender, :handle_visible, :location_visible, :profile_pic_visible, :lat, :lngt)
  end
end