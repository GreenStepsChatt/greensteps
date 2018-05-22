class RedemptionForm < ApplicationForm
  attr_accessor :prize_id, :user
  delegate_missing_to :redemption
  validates_models :redemption

  def redemption
    @redemption ||= Redemption.new(user: user, prize_id: prize_id)
  end

  def prize_choices
    @prize_choices ||=
      Prize.by_cost.map { |prize| PrizeChoice.new(prize, user) }
  end

  # forms should submit to redemptions_path, not redemption_forms_path
  def self.model_name
    ActiveModel::Name.new(self, nil, 'redemption')
  end

  class PrizeChoice
    delegate_missing_to :@prize

    def initialize(prize, user)
      @prize = prize
      @user = user
    end

    def disabled?
      Redemption.new(user: @user, prize: @prize).invalid?
    end
  end
end
