class UsersController < ApplicationController
  before_action :authorize, only: [:update]

  def show
    @user = User.find(params[:id])
  end

  def index
    my_proposals = Response.where(from_user_id: current_user.id).select('responses.to_user_id')
    @users = User.where('id not in (?)', my_proposals)
  end

  def search
    my_proposals = Response.where(from_user_id: current_user.id).select('responses.to_user_id')
    gender = params[:gender]
    query = params[:query]
    @users = User.where('spouse_id is NULL and gender = ?', gender)
                 .where("#{query} = '%tags%'")
                 .where('users.id not in (?)', my_proposals)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update user_params
      @user.set_tags
      redirect_to users_path
    else
      render 'edit'
    end
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
    params.require(:user).permit(:img, :gender, :age, :question_1, :question_2, :question_3, :city, :handle_visible, :profile_pic_visible, :location_visible)
  end
end