class DeedsController < ApplicationController
  expose :deed, scope: -> { current_user.deeds }

  def new; end

  def create
    if deed.save
      flash[:notice] = t('.success')
    else
      flash[:alert] = t('.failure')
    end
    render 'dashboards/show'
  end

  private

  def deed_params
    params.require(:deed).permit(:trash_bags, :miles)
  end
end
