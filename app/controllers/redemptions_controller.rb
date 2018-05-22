class RedemptionsController < ApplicationController
  expose :redemption_form

  def create
    respond_to :js
    if redemption_form.save
      flash.now[:notice] = t('.success')
      render 'create'
    else
      flash.now[:alert] = redemption_form.errors.full_messages.to_sentence
      render 'shared/update_flash'
    end
  end

  private

  def redemption_form_params
    params.require(:redemption).permit(:prize_id).merge(user: current_user)
  end
end
