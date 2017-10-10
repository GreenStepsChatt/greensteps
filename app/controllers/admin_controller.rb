class AdminController < ApplicationController
  before_action :ensure_admin

  private

  def ensure_admin
    return if current_user.has_role? :admin
    flash[:alert] = t('restricted_to_admins')
    redirect_back fallback_location: root_path
  end
end
