class ApplicationController < ActionController::Base
  before_action :set_https

  def set_https
    if Rails.env != "development"
      unless request.url.starts_with?('https')
        redirect_to request.url.gsub('http', 'https') and return
      end
    end
  end

  def authorize
    unless current_user
      render plain: 'unauthorized' and return
    end
  end
end
