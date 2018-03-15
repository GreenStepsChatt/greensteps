module Admins
  class PrizesController < BaseController
    expose :prize

    def new; end

    def create
      if prize.save
        redirect_to admins_dashboards_show_path, notice: t('.success')
      else
        render 'new'
      end
    end

    def edit
      @prize = Prize.find(params[:id])
    end

    def update
      @prize = Prize.find(params[:id])
      @prize.assign_attributes(prize_params)

      if @prize.save
        flash[:notice] = 'Prize was updated.'
        redirect_to admins_dashboards_show_path
      else
        flash.now[:alert] = 'Error saving the prize. Please try again.'
        render :edit
      end
    end

    private

    def prize_params
      params.require(:prize).permit(:title, :quantity, :cost)
    end
  end
end
