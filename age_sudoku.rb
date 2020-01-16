# Validate Sudoku with size `NxN`

# Given a Sudoku data structure with size NxN, N > 0 and sqrt(N) == integer, write a method to
# validate if it has been filled out correctly.

# The data structure is a multi-dimensional Array:
# [
#   [7,8,4,  1,5,9,  3,2,6],
#   [5,3,9,  6,7,2,  8,4,1],
#   [6,1,2,  4,3,8,  7,5,9],
#
#   [9,2,8,  7,1,5,  4,6,3],
#   [3,5,7,  8,4,6,  1,9,2],
#   [4,6,1,  9,2,3,  5,8,7],
#
#   [8,7,6,  3,9,4,  2,1,5],
#   [2,4,3,  5,6,1,  9,7,8],
#   [1,9,5,  2,8,7,  6,3,4]
# ]

# Rules for validation
# - Data structure dimension: NxN where N > 0 and sqrt(N) == integer
# - Rows may only contain integers: 1..N (N included)
# - Columns may only contain integers: 1..N (N included)
# - ‘Little squares' (3x3 in example above) may also only contain integers: 1..N (N included)

# Note: the matrix may include non-integer elements.

require 'minitest/autorun'
require 'byebug'

class Sudoku
  def initialize(matrix)
    @matrix = matrix
    @size = matrix.size
  end

  def valid?
    correct_dimensions? && entirely_numerical?
  end

private
  def entirely_numerical?
    @matrix.all? do |row|
      return false unless row.all? { |n| n.is_a? Integer }
      row.min > 0 && row.max <= @size && row.uniq.size == @size
    end
  end

  def correct_dimensions?
    root = Math.sqrt(@size)

    return false unless @size.positive? && root.to_i == root
    @matrix.all? { |row| row.size == @size }
  end
end

class SudokuTest < Minitest::Test
  def test_valid_1
    sudoku = Sudoku.new([
      [7,8,4, 1,5,9, 3,2,6],
      [5,3,9, 6,7,2, 8,4,1],
      [6,1,2, 4,3,8, 7,5,9],

      [9,2,8, 7,1,5, 4,6,3],
      [3,5,7, 8,4,6, 1,9,2],
      [4,6,1, 9,2,3, 5,8,7],

      [8,7,6, 3,9,4, 2,1,5],
      [2,4,3, 5,6,1, 9,7,8],
      [1,9,5, 2,8,7, 6,3,4]
    ])
    assert_equal(true, sudoku.valid?)
  end

  def test_valid_2
    sudoku = Sudoku.new([
      [1,4, 2,3],
      [3,2, 4,1],

      [4,1, 3,2],
      [2,3, 1,4]
    ])

    assert_equal(true, sudoku.valid?)
  end

  def test_invalid_1
    sudoku = Sudoku.new([
      [0,2,3, 4,5,6, 7,8,9],
      [1,2,3, 4,5,6, 7,8,9],
      [1,2,3, 4,5,6, 7,8,9],

      [1,2,3, 4,5,6, 7,8,9],
      [1,2,3, 4,5,6, 7,8,9],
      [1,2,3, 4,5,6, 7,8,9],

      [1,2,3, 4,5,6, 7,8,9],
      [1,2,3, 4,5,6, 7,8,9],
      [1,2,3, 4,5,6, 7,8,9]
    ])

    assert_equal(false, sudoku.valid?)
  end

  def test_invalid_2
    sudoku = Sudoku.new([
      [1,2,3,4,5],
      [1,2,3,4],
      [1,2,3,4],
      [1]
    ])

    assert_equal(false, sudoku.valid?)
  end
end
