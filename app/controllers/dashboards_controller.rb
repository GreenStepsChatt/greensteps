class DashboardsController < ApplicationController
  expose :redemption, scope: -> { current_user.redemptions }

  def show; end
end
