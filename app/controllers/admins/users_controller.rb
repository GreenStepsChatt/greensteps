module Admins
  class UsersController < BaseController
    # TODO: this causing N+1 queries that Bullet is not detecting
    expose :users, :sort_and_paginate_users

    def index; end

    private

    def sort_column
      if %w[email total_points].include?(params['column'])
        params['column']
      else
        'total_points'
      end
    end

    def sort_direction
      if %w[ASC DESC].include?(params['direction'])
        params['direction']
      else
        default_sort_direction
      end
    end

    helper_method :sort_column, :sort_direction

    def default_sort_direction
      sort_column == 'total_points' ? 'DESC' : 'ASC'
    end

    def sort_and_paginate_users
      User.order_by(sort_column, sort_direction).page(params[:page])
    end
  end
end
