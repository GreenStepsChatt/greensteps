module Admins
  class UsersController < BaseController
    expose :users, -> { User.by_total_points.page(params[:page]) }

    def index; end
  end
end
