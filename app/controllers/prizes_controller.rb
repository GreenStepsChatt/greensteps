class PrizesController < ApplicationController
  def index
    @prizes = Prize.all
  end

  def self.get_prizes
    Prize.all
  end
end
