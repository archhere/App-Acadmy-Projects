require_relative 'winning'
require_relative 'card'

class Deck

  attr_reader :my_deck


  def initialize(cards)
    @my_deck = cards
  end

  def self.make_deck
    total_card = []
    Card::VALUE.each do |num|
      Card::SUIT.each do |suit|
        total_card << Card.new(num,suit)
      end
    end
    total_card
    Deck.new(total_cards)
  end

  def deal
    5.times { @my_deck.pop }
  end

  def replace_cards(cards)
    new_cards = @my_deck.scramble.take(cards.length)
    @my_deck.concat(cards)
    new_cards
  end



end
