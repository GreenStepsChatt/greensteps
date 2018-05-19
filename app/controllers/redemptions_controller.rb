class RedemptionsController < ApplicationController
  expose :redemption, scope: -> { current_user.redemptions }

  def create
    respond_to :js
    if redemption.save
      flash.now[:notice] = t('.success')
      render 'create'
    else
      flash.now[:alert] = redemption.errors.full_messages.to_sentence
      render 'shared/update_flash'
    end
  end

  private

  def redemption_params
    params.require(:redemption).permit(:prize_id)
  end
end
