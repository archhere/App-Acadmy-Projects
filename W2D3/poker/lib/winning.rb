module Win
  VALUE = (2..10).to_a
  SUIT = [:spade , :heart, :clover, :diamond]
  POINTS = {:four_of_a_kind => 10, :full_house => 8, :flush => 6, :straight => 4, :three_of_a_kind =>3, :two_of_a_kind => 2}

  def flush(hand)
    first_hand = hand[0]
    hand[1..-1].all? {|card| card.suit == first_hand.suit}
  end


  def straight(hand)
    lowest = hand.value.min
    sorted_hand = hand.value.sort
    lowest_sorted = [lowest, lowest + 1, lowest + 2, lowest + 3, lowest + 4]
    sorted_hand == lowest_sorted
  end

  def three_of_a_kind(hand)
    counts = Hash.new(0)
    hand.each { |card| counts[card.value] += 1 }
    threes = counts.select { |k, v| v == 3 }
    threes.empty? ? false : true
  end

  def two_of_a_kind(hand)
    counts = Hash.new(0)
    hand.each { |card| counts[card.value] += 1 }
    twos = counts.select { |k, v| v == 2 }
    twos.empty? ? false : true
  end

  def full_house(hand)
    return true unless three_of_a_kind(hand).empty? && two_of_a_kind(hand).empty?
    false
  end


  def four_of_a_kind(hand)
    counts = Hash.new(0)
    hand.each { |card| counts[card.value] += 1 }
    fours = counts.select { |k, v| v == 4 }
    fours.empty? ? false : true
  end
end
