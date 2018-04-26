require_relative 'winning'
require_relative 'deck'
require_relative 'card'

class Hand
  include Win

  def initialize
    @hand = 
  end

  def get_points(hand)

    combinations = [:four_of_a_kind, :full_house, :flush , :straight, :three_of_a_kind, :two_of_a_kind]
    combinations.each do |key|
      return POINTS[key] if key(hand)
    end

    0
  end

end
