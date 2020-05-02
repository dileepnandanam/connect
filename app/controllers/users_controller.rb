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
    
    if params[:gender].present?
      @users = @users.where(gender: params[:gender])
    end

    if params[:query].present?
      query_statements = params[:query].split(' ')
      query = query_statements.map{|s| " LOWER(tags) like '%#{s.downcase}%'"}.join(' and ')
      @users = @users.where(query)
    end
    @users = @users.paginate(per_page: 12, page: params[:page])
    if request.format.html?
      render 'index'
    else
      render partial: 'users', locals: {users: @users}
    end
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