class Card
  attr_reader :value , :suit
  
  VALUE = (2..10).to_a
  SUIT = [:spade , :heart, :clover, :diamond]
  
  def initialize(value,suit)
    @value = value
    @suit = suit
  end

  
end