module Admins
  class BaseController < ApplicationController
    before_action :ensure_admin

    private

    def ensure_admin
      return if current_user.has_role? :admin

      respond_to do |format|
        format.html do
          redirect_back fallback_location: root_path, alert: t('admins_only')
        end

        format.js do
          flash.now.alert = t('admins_only')
          render 'shared/update_flash', status: :unauthorized
        end
      end
    end
  end
end
