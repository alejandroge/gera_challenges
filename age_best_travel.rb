require 'minitest/autorun'

def choose_best_sum(max_miles, max_cities, distances)
  return if distances.size < max_cities
  return distances.sum if distances.size == max_cities

  sum = 0
  distances.combination(max_cities).
    map { |combo| sum if (sum = combo.sum) <= max_miles }.
    compact.sort.last
end

class TestChooseBestSum < Minitest::Test
  def test_case_1
    ts = [50, 55, 56, 57, 58]
    assert_equal 163, choose_best_sum(163, 3, ts)
  end

  def test_case_2
    ts = [50]
    assert_nil choose_best_sum(163, 3, ts)
  end

  def test_case_3
    ts = [91, 74, 73, 85, 73, 81, 87]
    assert_equal 228, choose_best_sum(230, 3, ts)
  end

  def test_case_4
    ts = [50, 55, 57, 58, 60]
    assert_equal 173, choose_best_sum(174, 3, ts)
  end
end
