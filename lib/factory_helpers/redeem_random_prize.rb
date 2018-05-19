class RedeemRandomPrize
  include FactoryBot::Syntax::Methods

  def initialize(user)
    @user = user
    create :redemption, user: user, prize: find_or_create_redeemable_prize
  end

  private

  attr_reader :user

  def find_or_create_redeemable_prize
    if redeemable_prizes.empty?
      create :prize, cost: user.total_points
    else
      redeemable_prizes.offset(prize_offset).first
    end
  end

  def redeemable_prizes
    Prize.where('cost <= ?', user.total_points)
  end

  def prize_offset
    Faker::Number.between(0, redeemable_prizes.size - 1)
  end
end
