module Admins
  class UsersController < BaseController
    expose :users, -> { sorted_users.page(params[:page]) }

    def index; end

    private

    def sorted_users
      if params['order_by'].blank? || params['order_by'] == 'total_points'
        User.by_total_points
      else
        User.order(order_condition)
      end
    end

    def order_condition
      ApplicationRecord.sanitize_sql_for_order(params['order_by'])
    end
  end
end
