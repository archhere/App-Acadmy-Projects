
require "byebug"
# O(n!)
def first_anagram?(str, str2)
  result = str.chars.permutation.to_a
  result.any?{ |str| str2.chars == str }
end

#O(n^2)
def second_anagram?(str, str2)
  str.chars.each do |el|
    str2.chars.each do |el2|
      count1 = str.count(el)
      count2 = str2.count(el2)
      if el == el2
        str.delete!(el)
        str2.delete!(el2)
        if count1 > count2
          str += el * (count1 - count2)
        else
          str2 += el2 * (count2 - count1)
        end
      end
    end
  end
  return true if str.empty? && str2.empty?
  false
end


# O(n^2 / nlogn)
def third_anagram?(str, str2)
  str.chars.sort == str2.chars.sort
end

# O(n)
def fourth_anagram?(str, str2)
  str_hash = Hash.new(0)
  # str2_hash = Hash.new(0)
  str.downcase.each_char{ |char| str_hash[char] += 1 }
  str2.downcase.each_char{ |char| str_hash[char] -= 1 }
  # str_hash.all?{ |k, v| v == 0 }
  str_hash.values.sum === 0
end



p first_anagram?("elvis", "lives")
p second_anagram?("elvis", "lives")
p third_anagram?("elvis", "lives")
p fourth_anagram?("elvis", "lives")
