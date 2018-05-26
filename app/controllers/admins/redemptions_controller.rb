module Admins
  class RedemptionsController < BaseController
    expose :redemption
    expose :redemptions, -> { Redemption.unfulfilled.includes(:user) }

    def index; end

    def update
      respond_to :js
      redemption.update!(redemption_params)
      flash.now[:notice] = t('.success')
      render 'create'
    end

    private

    def redemption_params
      params.require(:redemption).permit(:confirmation_number)
    end
  end
end
