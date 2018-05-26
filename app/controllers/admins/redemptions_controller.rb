module Admins
  class RedemptionsController < BaseController
    expose :redemptions, -> { Redemption.includes(:user).all }

    def index
    end
  end
end
