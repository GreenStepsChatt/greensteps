module Admin
  class DashboardsController < AdminController
    # TODO: when we start exposing more things here, we should probably refactor
    # this, maybe with a view object or something
    expose :prizes, -> { Prize.all }

    def show; end
  end
end
