module Admins
  class UsersController < BaseController
    expose :users, -> { User.all }

    def index; end
  end
end
