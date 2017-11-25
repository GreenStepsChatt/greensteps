module Admin
  class AdminsController < BaseController
    expose :admins, -> { User.with_role(:admin) }

    def index; end
  end
end
