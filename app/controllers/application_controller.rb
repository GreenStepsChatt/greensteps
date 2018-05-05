class ApplicationController < ActionController::Base
  before_action :require_login
  skip_before_action :require_login, if: :devise_controller?

  private

  def require_login
    return if user_signed_in?
    flash[:alert] = t('no_visitor_access')
    redirect_to root_path
  end
end
