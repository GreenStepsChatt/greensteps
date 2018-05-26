module Admins
  class DashboardsController < BaseController
    expose :stations, -> { Station.all }

    def show; end
  end
end
