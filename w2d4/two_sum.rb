

# O(n^2)
def bad_two_sum?(arr, target)
  (0...arr.length).each do |idx|
    (idx + 1...arr.length).each do |idx2|
      return true if arr[idx] + arr[idx2] == target
    end
  end
  false
end

# O(nlogn)
def okey_two_sum?(arr, target)
  arr.each do |val|
    remainder = target - val
    return true if arr.bsearch{|x| x == remainder}
  end
  false
end




p bad_two_sum?([0, 1, 5, 7], 6)
p okey_two_sum?([0, 1, 2, 4,5], 6)
