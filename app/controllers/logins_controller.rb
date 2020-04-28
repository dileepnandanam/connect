class LoginsController < ApplicationController
   skip_before_action :verify_authenticity_token
  def new
    @email = params[:fbid]
  end

  def create
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
      flash[:notice] = 'facebook id or password incorrect'
      render 'new'
    end
  end
end
