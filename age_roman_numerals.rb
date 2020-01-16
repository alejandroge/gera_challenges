require "minitest/autorun"

class RomanNumerals
  DEC_2_ROMAN = {
    1000 => 'M',
    900 => 'CM',
    500 => 'D',
    400 => 'CD',
    100 => 'C',
    90 => 'XC',
    50 => 'L',
    40 => 'XL',
    10 => 'X',
    9 => 'IX',
    5 => 'V',
    4 => 'IV',
    1 => 'I',
  }.freeze

  def self.to_roman(dec_2_convert)
    raise 'Numbers bigger than 3,999 cannot be processed' if dec_2_convert > 3999

    DEC_2_ROMAN.each_with_object('') do |(curr_value, roman_symbol), roman_number|
      next if dec_2_convert < curr_value
      times, dec_2_convert = dec_2_convert / curr_value, dec_2_convert % curr_value
      roman_number << (roman_symbol * times)
    end
  end

  ROMAN_2_DEC = {
    'M' => 1000,
    'CM' => 900,
    'D' => 500,
    'CD' => 400,
    'C' => 100,
    'XC' => 90,
    'L' => 50,
    'XL' => 40,
    'X' => 10,
    'IX' => 9,
    'V' => 5,
    'IV' => 4,
    'I' => 1,
  }.freeze

  def self.from_roman(roman_number)
    decimal_number = ROMAN_2_DEC.inject(0) do |decimal_number, (roman, dec)|
      matches = roman_number.scan(/(?<=\b|#{roman})(#{roman})/).size
      roman_number.sub!(/\b(#{roman})+/, '') unless matches.zero?
      decimal_number + (dec * matches)
    end

    raise "Invalid Number: Could not decode: #{roman_number}" unless roman_number.empty?
    decimal_number
  end
end

class Testing < Minitest::Test
  def test_to_roman_1
    assert_equal('M', RomanNumerals.to_roman(1000))
  end

  def test_to_roman_2
    assert_equal('MCMXC', RomanNumerals.to_roman(1990))
  end

  def test_to_roman_3
    assert_equal('MDCLXVI', RomanNumerals.to_roman(1666))
  end

  def test_to_roman_4
    assert_equal('', RomanNumerals.to_roman(0))
  end

  def test_to_roman_5
    assert_equal('', RomanNumerals.to_roman(-1))
  end

  def test_to_roman_max
    assert_equal('MMMCMXCIX', RomanNumerals.to_roman(3_999))
  end

  def test_to_roman_bigger_than_max
    assert_raises 'Numbers bigger than 3,999 cannot be processed' do
      RomanNumerals.to_roman(4_000)
    end
  end

  def test_from_roman_1
    assert_equal(1000, RomanNumerals.from_roman('M'))
  end

  def test_from_roman_2
    assert_equal(1990, RomanNumerals.from_roman('MCMXC'))
  end

  def test_from_roman_3
    assert_equal(1666, RomanNumerals.from_roman('MDCLXVI'))
  end

  def test_from_roman_4
    assert_equal(3666, RomanNumerals.from_roman('MMMDCLXVI'))
  end

  def test_from_roman_max
    assert_equal(3999, RomanNumerals.from_roman('MMMCMXCIX'))
  end

  def test_from_roman_min
    assert_equal(0, RomanNumerals.from_roman(''))
  end

  def test_from_roman_error
    assert_raises 'Invalid Number: Could not decode: Y' do
      RomanNumerals.from_roman('YXV')
    end
  end
end

