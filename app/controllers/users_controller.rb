class UsersController < ApplicationController
  before_action :authorize, only: [:update]

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
    current_user.update params.require(:user).permit(:lat, :lngt)
  end

  def switch
    sign_in(:user, User.find(params[:id]))
    redirect_to root_path
  end

  protected

  def exists(email)
    User.where(email: email).first
  end

  def user_params
    params.require(:user).permit(:img, :question_1, :question_2, :question_3, :gender, :handle_visible, :location_visible, :profile_pic_visible, :lat, :lngt)
  end
end