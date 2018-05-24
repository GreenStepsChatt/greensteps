module Admins
  class UsersController < BaseController
    # TODO: this causing N+1 queries that Bullet is not detecting
    expose :users, -> { sorted_users.page(params[:page]) }

    def index; end

    private

    def sorted_users
      if sort_column == 'total_points'
        User.by_total_points(sort_direction)
      else
        User.order("#{sort_column} #{sort_direction}")
      end
    end

    def sort_column
      if %w[email total_points].include?(params['column'])
        params['column']
      else
        'total_points'
      end
    end
    helper_method :sort_column

    def sort_direction
      if %w[ASC DESC].include?(params['direction'])
        params['direction']
      else
        sort_column == 'total_points' ? 'DESC' : 'ASC'
      end
    end
    helper_method :sort_direction
  end
end
