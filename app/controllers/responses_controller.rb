class ResponsesController < ApplicationController
  def create
    if Response.where(to_user_id: response_params[:to_user_id], from_user_id: response_params[:from_user_id]).first.present?
      render plain: 'no more', layout: false and return
    end
    @esponse = Response.create response_params.merge(from_user_id: current_user.id)
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
  end

  def reject
    @response = Response.where(to_user_id: current_user.id, id: params[:id]).first
    @response.update accepted: false
    render plain: 'rejected', status: 422
  end

  protected

  def response_params
    params.require(:response).permit(:answer_1, :answer_2, :answer_3, :to_user_id)
  end
end