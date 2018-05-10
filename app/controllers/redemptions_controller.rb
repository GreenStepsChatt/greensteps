class RedemptionsController < ApplicationController
  expose :redemption, scope: -> { current_user.redemptions }

  def new; end

  def create
    redemption.title = params[:title]
    redemption.cost = params[:cost]
    if redemption.save
      flash[:notice] = t('.success')
      redirect_to dashboard_path
    else
      flash[:notice] = t('.failure')
      redirect_to new_prize_redemption_path
    end
  end
end
