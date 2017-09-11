class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  skip_before_action :require_login, if: :devise_controller?

  private

  def require_login
    return if user_signed_in?
    flash[:notice] = t('not_logged_in')
    redirect_to root_path
  end
end
