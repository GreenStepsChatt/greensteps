class RedemptionsController < ApplicationController
  expose :redemption, scope: -> { current_user.redemptions }

  def create
    if redemption.save
      flash[:notice] = p(t('.success'))
      redirect_to dashboard_path
    else
      render 'dashboards/show'
    end
  end

  private

  def redemption_params
    params.require(:redemption).permit(:prize_id)
  end
end
