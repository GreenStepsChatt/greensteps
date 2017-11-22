class CustomFailure < Devise::FailureApp
    def respond
      if User.only_deleted.exists?(email: params[:user][:email])
        flash.keep(:alert)
        flash[:alert] = <<~HTML
          You cannot login because your account has been deleted.
        HTML
        redirect_to root_path
      else
        super
      end
    end
  end
