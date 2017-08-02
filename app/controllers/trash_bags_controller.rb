class TrashBagsController < ApplicationController
  expose :trash_bag, scope: -> { current_user.trash_bags }

  def create
    if trash_bag.save
      flash[:notice] = t('.success')
    else
      # TODO: Add spec for this. There shouldn't be a way for save to fail yet,
      # but we could stub that out. Also, that translation isn't in there yet.
      flash[:alert] = t('.failure')
    end
    render 'dashboards/show'
  end
end
