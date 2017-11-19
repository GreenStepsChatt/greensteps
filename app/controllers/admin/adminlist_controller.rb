module Admin
  class AdminlistController < AdminController
    expose :admins, -> { User.with_role(:admin) }

    def index; end
  end
end
