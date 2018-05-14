class RedemptionsController < ApplicationController
  expose :redemption, scope: -> { current_user.redemptions }

  def create
    if redemption.save
      flash.now[:notice] = t('.success')
    else
      flash.now[:alert] = t('.failure')
    end
    render 'shared/update_flash'
  end

  private

  def redemption_params
    params.require(:redemption).permit(:prize_id)
  end
end
