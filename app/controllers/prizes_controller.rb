class PrizesController < ApplicationController
  def index
    @prizes = Prize.all
  end
end
