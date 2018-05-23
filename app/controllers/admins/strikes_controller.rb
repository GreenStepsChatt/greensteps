module Admins
  class StrikesController < BaseController
    expose :strike

    def create
      strike.save!
      flash[:notice] = t('.success', user_email: strike.user.email)
      redirect_to admins_users_path
    end

    private

    def strike_params
      { user_id: params[:user_id] }
    end
  end
end
