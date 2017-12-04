module Admins
  class AdminsController < BaseController
    expose :admins, -> { User.with_role(:admin) }
    expose :admin

    def index; end

    def new; end

    def create
      if admin.save
        redirect_to admins_admins_path, notice: t('.success')
      else
        render :new
      end
    end

    def destroy
      admin.demote
      flash.now.notice = t('.success')
    end

    private

    def admin_params
      params.require(:admin).permit(:email)
    end
  end
end
