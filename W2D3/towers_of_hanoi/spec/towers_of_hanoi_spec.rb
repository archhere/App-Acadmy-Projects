require 'rspec'
require 'towers_of_hanoi'

RSpec.describe TowersOfHanoi do
  subject(:toh) {TowersOfHanoi.new([[3,2,1],[],[]])}
  towers = [[3,2,1],[],[]]

  describe "#initialize" do
    it "sets an initial variable,tower to be 3 x 3 array " do
      expect(toh.towers).to eq([[3,2,1],[],[]])
    end
  end

  describe "#move" do
    subject(:toh) {TowersOfHanoi.new([[3,2,1],[],[]])}

    let(:from_tower) { 0 }
    let(:to_tower) { 1 }

    it "moves a disk from start position to end and returns updated towers" do
      disc = towers[from_tower].pop
      expect(toh.move(from_tower,to_tower)).to eq([[3,2],[disc],[]])
    end
  end

  describe "#valid_move?" do
    let(:tower_1) {[[3,2],[1],[]]}

    it "does not permit a larger disk to move to a smaller disk" do
      disc1 = :tower_1[0][1]
      disc2 = :tower_1[1][0]
      expect(:tower_1.)


end
