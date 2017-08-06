class BaseController < ApplicationController
  before_action :require_user

  def require_user
    return if current_user

    flash[:alert] = 'You must be logged in to access this page.'
    redirect_to root_path
  end
end
