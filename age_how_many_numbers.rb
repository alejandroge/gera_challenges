require 'minitest/autorun'

def find_all(digits_sum, digits_number)
  return [] if (digits_number > digits_sum) || (9 * digits_number < digits_sum)
  combos = generator(digits_number, digits_sum).to_a
  [combos.length, combos.first, combos.last]
end

def sum_digits(n)
  return n if n < 10
  (n % 10) + sum_digits(n / 10)
end

def generator(digits_number, digits_sum)
  Enumerator.new do |enum|
    i = initialized_int(1, digits_number)
    max = initialized_int(9, digits_number)

    while (i <= max)
      while (i % 10) < 9
        enum.yield i if sum_digits(i) == digits_sum
        i += 1
      end
      enum.yield i if sum_digits(i) == digits_sum
      i = next_num(i, 2)
    end
  end
end

def initialized_int(value, digits)
  base_value = (10**digits - 1) / 9 # basing all calculations on 1s numbers
  return base_value if value === 1
  base_value * value
end

def next_num(i, position)
  pos_fac = (10 ** position)
  prev_pos_fac = pos_fac / 10

  # i.e. i = 1199, position = 2, next_pos_value = 9
  next_pos_value = ((i % pos_fac) - (i % prev_pos_fac)) / prev_pos_fac
  return next_num(i, position + 1) if next_pos_value >= 9

  next_pos_value = initialized_int(next_pos_value + 1, position)
  diff_on_position = (next_pos_value - (i % pos_fac))
  # we need to add the diff between the wanted value and the current one
  i + (next_pos_value - (i % pos_fac))
end

class TestNumbers < Minitest::Test
  def test_1
    assert_equal(
      [8, 118, 334],
      find_all(10, 3)
    )
  end

  def test_2
    assert_equal(
      [1, 999, 999],
      find_all(27, 3)
    )
  end

  def test_3
    assert_equal(
      [],
      find_all(84, 4)
    )
  end

  def test_4
    assert_equal(
      [123, 116999, 566666],
      find_all(35, 6)
    )
  end

  def test_5
    assert_equal(
      [15, 1999, 7777],
      find_all(28, 4)
    )
  end

  def test_6
    assert_equal(
      [73, 11599, 55555],
      find_all(25, 5)
    )
  end

  def test_7
    assert_equal(
      [486, 11115999, 44445555],
      find_all(36, 8)
    )
  end

  def test_8
    assert_equal(
      [3768, 111111899999, 455555555555],
      find_all(59, 12)
    )
  end

  def test_9
    assert_equal(
      [],
      find_all(47, 5)
    )
  end
end
