#phase 1


def my_min1(list)   #O(n^2)
  list.each_with_index do |el1,idx1|
    min = true
    list.each_with_index do |el2,idx2|
      next if idx1 == idx2
      min = false if el1 > el2
    end
    return el1 if min
  end
end

def my_min2(list) #O(n)
  min = nil
  list.each do |el|
    if min.nil?
      min = el
    elsif el < min
      min = el
    end
  end
  min
end

# Largest Contiguous Sub-sum

def lc_sub_sum1(list)   # O(n^2)
  subsets = []
  list.each_index do |idx1|
    list.each_index do |idx2|
      next if idx1 == idx2
      subs = list[idx1..idx2]
      subsets << subs unless subs.empty?
    end
  end
  subsets.map(&:sum).sort.last
end



def lc_sub_sum2(list)  # *** O(n) time with O(1) memory
  largest = 0
  sum = 0
  list.each do |el|
    sum += el
    sum = 0 if sum < 0
    largest = sum if sum > largest
  end
  sum
end





if __FILE__ == $PROGRAM_NAME
  # start_time =
  p my_min1([ 0, 3, 5, 4, -5, 10, 1, 90 ])
  p my_min2([ 0, 3, 5, 4, -5, 10, 1, 90 ])
  p lc_sub_sum1([2, 3, -6, 7, -6, 7])
  p lc_sub_sum2([2, 3, -6, 7, -6, 7])
  # end_time =
end
