class DeedsController < ApplicationController
  expose :deed, scope: -> { current_user.deeds }

  def new; end

  def create
    if deed.save
      flash[:notice] = t('.success')
      redirect_to dashboard_path
    else
      render 'new'
    end
  end

  private

  def deed_params
    params.require(:deed).permit(:trash_bags, :miles)
  end
end
