# require 'byebug'
class Array
  
  def remove_dups
    result = []
    self.each {|el| result << el unless result.include?(el)}
    result
  end
  
  def two_sum 
    result = []
    (0...self.length).each do |i|
      ((i + 1)...self.length).each do |j|
        result << [i, j] if self[i] + self[j] == 0
      end 
    end 
  
    result
  end 
  
  def my_transpose
    result = []
    self[0].length.times { result << []}
    self.each do |row|
      row.each_with_index do |col,col_idx|
        result[col_idx] << col
      end
    end
    result  
  end
  
  def stock_picker 
    result = []
    # debugger 
    (0...self.length).each do |i|
      ((i + 1)...self.length).each do |j|
        if result.empty?
          result = [i, j] if self[j] > self[i]
        else 
          result = [i, j] if ((self[j] - self[i]) > (self[result[1]] - self[result[0]]))
        end 
      end 
    end 
    result
  end 
  
end