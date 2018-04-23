class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  skip_before_action :require_login, if: :devise_controller?
  before_action :authorize_mini_profiler

  private

  def require_login
    return if user_signed_in?
    flash[:alert] = t('no_visitor_access')
    redirect_to root_path
  end

  def authorize_mini_profiler
    return unless user_signed_in? && current_user.has_role?(:developer)
    Rack::MiniProfiler.authorize_request
  end
end
