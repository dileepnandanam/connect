class ApplicationController < ActionController::Base
  def authorize
    unless current_user
      render plain: 'unauthorized' and return
    end
  end
end
