module Admins
  class UsersController < BaseController
    expose :users, -> { User.page(params[:page]) }

    def index; end
  end
end
