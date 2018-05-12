class RedemptionsController < ApplicationController
  expose :prize, id: :prize_id 

  def create
    redemption = Redemption.new(
      title: prize.title, cost: prize.cost, user: current_user
    )

    user_points = PointCalculator.new(current_user).total_points
    if user_points >= redemption.cost and redemption.save
      flash[:notice] = t('.success')
      redirect_to dashboard_path
    else
      flash[:notice] = t('.failure')
      redirect_to new_prize_redemption_path
    end
  end
end
