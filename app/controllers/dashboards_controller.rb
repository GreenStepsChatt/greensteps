class DashboardsController < ApplicationController
  expose :redemption_form, build_params: -> { { user: current_user } }

  def show; end
end
