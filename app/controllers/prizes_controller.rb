class PrizesController < ApplicationController
  expose :prizes, -> { Prize.all }
  expose :prize
end
