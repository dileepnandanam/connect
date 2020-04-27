class ResponsesController < ApplicationController
  def create
    @esponse = = Response.create response_params
  end

  protected

  def response_params
    params.require(:response).permit(:answer_1, :answer_2, :answer_3, :to)
  end
end