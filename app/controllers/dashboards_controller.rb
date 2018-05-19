class DashboardsController < ApplicationController
  expose :redemption, scope: -> { current_user.redemptions }
  expose :prizes, -> { Prize.by_cost }

  def show; end
end
