require 'rspec'
require 'tdd'

RSpec.describe Array do
  let(:arr) { ["a", "a"] }
  
  describe "#remove_dups" do
    it "returns an array with only unique elements" do
      expect(arr.remove_dups).to eq(["a"])
    end
  end
  
  
  describe "#two_sum" do 
    let(:sum) { [-1, 0, 2, -2, 1]}
    it "returns the sorted array pairs which sum to zero" do 
      expect(sum.two_sum).to eq([[0, 4], [2, 3]])
    end 
  end 
  
  
  describe "#my_transpose" do 
    let(:transpose_arr) { [[0, 1, 2], [3, 4, 5], [6, 7, 8]] }
    it "returns the transposed array" do 
      expect(transpose_arr.my_transpose).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
    end 
  end 
  
  describe "#stock_picker" do
    let(:stocks) {[20,40,35,20,50,21]}
    it "returns the most profitable pair" do
      expect(stocks.stock_picker).to eq([0,4])
    end 
  end 
  
  
end 


