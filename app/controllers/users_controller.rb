class UsersController < ApplicationController
  before_action :authorize, only: [:update]

  def show
    @user = User.find(params[:id])
  end

  def index
    if current_user
      my_proposals = Response.where(from_user_id: current_user.id).select('responses.to_user_id')
      @users = User.where('id not in (?)', my_proposals)
    else
      @users = User.where(spouse_id: nil)
    end
    @users = @users.paginate(per_page: 12, page: params[:page])
  end

  def search
    gender = params[:gender]
    query = params[:query].to_s
    @users = User.where('spouse_id is NULL')
                 .where(gender: gender) 
                 .where(" tags like '%#{query}%'")
    if current_user
      my_proposals = Response.where(from_user_id: current_user.id).select('responses.to_user_id')
      @users = @users.where('users.id not in (?)', my_proposals)
    end
    @users = @users.paginate(per_page: 12, page: params[:page])
    render partial: 'users', locals: {users: @users}, layout: false, status: 200
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
    params.require(:user).permit(:img, :gender, :age, :question_1, :question_2, :question_3, :city, :handle, :handle_visible, :profile_pic_visible, :location_visible, :facebook_link)
  end
end