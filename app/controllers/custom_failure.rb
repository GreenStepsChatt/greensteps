class CustomFailure < Devise::FailureApp
  def respond
    if User.only_deleted.exists?(email: params[:user][:email])
      flash.keep(:alert)
      flash[:alert] = I18n.t('devise.sessions.account_deleted')
      redirect_to root_path
    else
      super
    end
  end
end
