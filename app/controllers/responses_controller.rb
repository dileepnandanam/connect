class ResponsesController < ApplicationController
  def create
    @esponse = Response.create response_params.merge(from_user_id: current_user.id)
  end

  def index
    @responses = Response.where(to_user_id: current_user.id).all
  end

  protected

  def response_params
    params.require(:response).permit(:answer_1, :answer_2, :answer_3, :to_user_id)
  end

  
end