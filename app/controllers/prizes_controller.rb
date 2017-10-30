class PrizesController < ApplicationController
  expose :prize

  def new; end

  def create
    if prize.save
      redirect_to admin_dashboards_show_path, notice: t('.success')
    else
      render 'new'
    end
  end

  private

  def prize_params
    params.require(:prize).permit(:title, :quantity, :cost)
  end
end
