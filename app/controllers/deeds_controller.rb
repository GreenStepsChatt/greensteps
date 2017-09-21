class DeedsController < ApplicationController
  expose :deed, scope: -> { current_user.deeds }

  def new; end

  def create
    if deed.save
      flash[:notice] = t('.success')
    else
      # TODO: Add spec for this. There shouldn't be a way for save to fail yet,
      # but we could stub that out. Also, that translation isn't in there yet.
      flash[:alert] = t('.failure')
    end
    render 'dashboards/show'
  end

  private

  def deed_params
    params.require(:deed).permit(:trash_bags, :miles)
  end
end
