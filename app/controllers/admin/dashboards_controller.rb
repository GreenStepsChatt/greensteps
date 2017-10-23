module Admin
  class DashboardsController < AdminController
    expose :prizes, ->{ Prize.all }

    def show; end
  end
end
