class LoginsController < ApplicationController
   skip_before_action :verify_authenticity_token
  def new
    @email = params[:fbid]
  end

  def create
    if params[:user][:password].blank? || params[:user][:email].blank?
      render 'new' and return
    end
    @user = User.find_by_email(params[:user][:email])
    if @user.blank?
      @user = User.new(params.require(:user).permit(:email, :password))
      @user.save(validate: false)
      sign_in(:user, @user)
      redirect_to edit_user_path(@user)
    elsif @user.valid_password?(params[:user][:password])
      sign_in :user, @user
      redirect_to users_path
    else
      flash[:notice] = 'password incorrect'
      render 'new'
    end
  end
end
