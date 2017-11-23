module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      super do
        if resource.new_record? &&
           User.only_deleted.exists?(email: sign_up_params[:email])
          flash[:alert] = t('.account_deleted')
          redirect_back(fallback_location: root_path) && return
        end
      end
    end
  end
end
