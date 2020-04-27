class ApplicationController < ActionController::Base
  def authorize
    unless current_user
      render 'noaccess' and return
    end
  end
end
