class TowersOfHanoi
  attr_reader :towers

  def initialize(towers)
    @towers = [[3,2,1],[],[]]
  end

  def move(from_tower,to_tower)
    disc = towers[from_tower].pop
    towers[to_tower].push(disc)
    towers
  end




end
