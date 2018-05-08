class DeedsController < ApplicationController
  expose :deed, scope: -> { current_user.deeds }

  def new; end

  def create
    if deed.save
      flash_notice
      redirect_to dashboard_path
    else
      render 'new'
    end
  end

  def flash_notice
    flash[:notice] = if deed.p_left_total
                       t('.fail',
                         points_logged: deed.trash_bags,
                         points_submitted: deed.points_submitted)
                     else
                       t('.success')
                     end
  end

  private

  def deed_params
    params.require(:deed).permit(:trash_bags)
  end
end
