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
    if deed.p_left_total
      flash[:notice] = if deed.p_left_total == 1
                         t('.fail_one', p_left_total: deed.p_left_total)
                       else
                         t('.fail_multiple', p_left_total: deed.p_left_total)
                       end
    else
      flash[:notice] = t('.success')
    end
  end

  private

  def deed_params
    params.require(:deed).permit(:trash_bags)
  end
end
