class RedemptionsController < ApplicationController
  expose :redemption

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
    { user_id: current_user.id, value: current_user.available_points }
  end
end
