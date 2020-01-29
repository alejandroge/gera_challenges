# How many numbers? II
# We want to find the numbers higher or equal than 1000 that the sum of every four consecutives
# digits cannot be higher than a certain given value. If the number is num = d1d2d3d4d5d6, and the
# maximum sum of 4 contiguous digits is maxSum, then:
#   d1 + d2 + d3 + d4 <= maxSum
#   d2 + d3 + d4 + d5 <= maxSum
#   d3 + d4 + d5 + d6 <= maxSum

# For that purpose, we need to create a function, max_sumDig(), that receives nMax, as the max
# value of the interval to study (the range (1000, nMax) ), and a certain value, maxSum, the
# maximum sum that every four consecutive digits should be less or equal to. The function should
# output the following list with the data detailed bellow:
#   [(1), (2), (3)]

# (1) - the amount of numbers that satisfy the constraint presented above
# (2) - the closest number to the mean of the results, if there are more than one, the smallest
#       number should be chosen.
# (3) - the total sum of all the found numbers

# Example
# Let's see a case with all the details:

#   max_sumDig(2000, 3) -------> [11, 1110, 12555]

#   (1) - There are 11 found numbers: 1000, 1001, 1002, 1010, 1011, 1020, 1100, 1101, 1110, 1200 and 2000
#   (2) - The mean of all the found numbers is:
#         (1000 + 1001 + 1002 + 1010 + 1011 + 1020 + 1100 + 1101 + 1110 + 1200 + 2000) /11 = 1141.36363,  
#         so 1110 is the number that is closest to that mean value.
#
#   (3) - 12555 is the sum of all the found numbers
#         1000 + 1001 + 1002 + 1010 + 1011 + 1020 + 1100 + 1101 + 1110 + 1200 + 2000 = 12555
require 'minitest/autorun'

class Integer
  def four_digit_sequences
    digits = number_of_digits(self)
    return [self] if digits == 4

    Enumerator.new do |enum|
      while digits >= 4
        enum.yield (self % (10**digits))/10**(digits-4)
        digits -= 1
      end
    end
  end

private
  def number_of_digits(value)
    return 1 if value < 10
    1 + number_of_digits(value/10)
  end
end

def closest_to_mean(array)
  mean = (array.sum*1.0)/array.length
  index = array.find_index { |n| n > mean }

  diff_to_low = (array[index-1] - mean).abs
  diff_to_high = (array[index] - mean).abs
  diff_to_high < diff_to_low ? array[index] : array[index - 1]
end

def sum_digits(n)
  return n if n < 10
  (n % 10) + sum_digits(n / 10)
end

def max_sum_dig(range_max, max_digits_sum)
  valid_numbers = (1000..range_max).select do |n|
    n.four_digit_sequences.all? { |seq| sum_digits(seq) <= max_digits_sum }
  end
  [valid_numbers.size, closest_to_mean(valid_numbers), valid_numbers.sum]
end

class Test < Minitest::Test
  def test_1
    assert_equal(
      [11, 1110, 12_555],
      max_sum_dig(2000, 3)
    )
  end

  def test_2
    assert_equal(
      [21, 1120, 23665],
      max_sum_dig(2000, 4)
    )
  end

  def test_3
    assert_equal(
      [85, 1200, 99986],
      max_sum_dig(2000, 7)
    )
  end

  def test_4
    assert_equal(
      [141, 1600, 220756],
      max_sum_dig(3000, 7)
    )
  end

  def test_5
    assert_equal(
      [35, 2000, 58331],
      max_sum_dig(4000, 4)
    )
  end

  def test_6
    assert_equal(
      [2538, 20000, 50663941],
      max_sum_dig(50000, 9)
    )
  end
end
