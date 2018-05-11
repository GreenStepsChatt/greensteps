module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      super do
        if resource.new_record? &&
           User.soft_deleted.exists?(email: sign_up_params[:email])
          flash[:alert] = t('.account_deleted')
          redirect_back(fallback_location: root_path) && return
        end
      end
    end

    def destroy
      resource.soft_delete
      Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
      set_flash_message! :notice, :destroyed
      respond_with_navigational(resource) do
        redirect_to after_sign_out_path_for(resource_name)
      end
    end
  end
end
