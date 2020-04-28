class ChatsController < ApplicationController
  before_action :authorize
  def create
    @chat = Chat.create chat_params.merge(user_id: current_user.id)
    render partial: 'chat', locals: {chat: @chat}, layout: false
    message = ApplicationController.render(
      partial: 'chats/chat',
      locals: { chat: @chat, current_user: current_user }
    )
    ApplicationCable::ChatNotificationsChannel.broadcast_to(
      current_user.spouse,
      message: message
    )
  end

  def index
    @chats = Chat.where(user_id: [current_user.spouse_id, current_user.id]).order('created_at ASC')
  end

  protected

  def chat_params
    params.require(:chat).permit(:text)
  end
end