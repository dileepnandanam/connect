class ResponsesController < ApplicationController
  before_action :authorize, only: [:create, :accept, :reject]
  def create
    @target = User.find(response_params[:to_user_id])

    if Response.where(to_user_id: response_params[:to_user_id], from_user_id: current_user.id).first.present?
      render plain: 'You have Already Proposed', layout: false, status: 422 and return
    end
    @esponse = Response.create response_params.merge(from_user_id: current_user.id)
    ApplicationCable::CreateNotificationsChannel.broadcast_to(
      @target,
      message: 'new_response'
    )
    render plain: "you have proposed. wait for a response.", layout: false
  end

  def index
    @responses = Response.where(to_user_id: current_user.id).all
  end

  def accept
    @response = Response.where(to_user_id: current_user.id, id: params[:id]).first
    @response.update accepted: true
    current_user.update spouse_id: @response.from_user_id
    Response.where(from_user_id: current_user).delete_all
    Response.where(from_user_id: @response.from_user_id).delete_all
    User.where(id: current_user.spouse_id).first.update spouse_id: current_user.id
  
    Chat.where('user_id in (?)', [current_user.id, current_user.spouse_id]).delete_all
    message = ApplicationController.render(
      partial: 'chats/chat_bar',
      locals: { user: current_user }
    )
    ApplicationCable::AcceptNotificationsChannel.broadcast_to(
      current_user.spouse,
      message: message
    )
    ApplicationCable::AcceptNotificationsChannel.broadcast_to(
      current_user,
      message: message
    )
    render plain: "You have found your spouse. start chating <a href='/chats'> here </a>"
  end

  def reject
    @response = Response.where(to_user_id: current_user.id, id: params[:id]).first
    @response.delete
    render plain: 'rejected'
  end

  def escape
    current_user.spouse.update spouse_id: nil
    current_user.update spouse_id: nil
    redirect_to users_path
  end

  protected

  def response_params
    params.require(:response).permit(:answer_1, :answer_2, :answer_3, :to_user_id)
  end
end