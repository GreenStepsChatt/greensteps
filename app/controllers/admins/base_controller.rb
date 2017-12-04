module Admins
  class BaseController < ApplicationController
    before_action :ensure_admin

    private

    def ensure_admin
      return if current_user.has_role? :admin
      redirect_back(
        fallback_location: root_path,
        alert: t('restricted_to_admins')
      )
    end
  end
end
