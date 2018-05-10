class RedemptionsController < ApplicationController
  expose :redemption, scope: -> { current_user.redemptions }

  def new; end

  def create
    redemption.save
    flash[:notice] = t('.success')
    redirect_to dashboard_path
  end
end
