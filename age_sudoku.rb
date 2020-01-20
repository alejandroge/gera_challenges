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
    correct_dimensions? && all_valid_values? &&
      rows_are_correct? && columns_are_correct? &&
      inner_squares_are_correct?
  end

private
  def correct_dimensions?
    root = Math.sqrt(@size)

    @size.positive? && (root.to_i == root) &&
      @matrix.all? { |row| row.size === @size }
  end

  def all_valid_values?
    @matrix.all? do |row|
      row.all? { |n| n.is_a?(Integer) && n > 0 && n <= @size }
    end
  end

  def rows_are_correct?
    @matrix.all? do |row|
      row.uniq.size === @size
    end
  end

  def columns_are_correct?
    (0...@size).all? do |index|
      column = @matrix.map { |row| row[index] }
      column.uniq.size === @size
    end
  end

  def inner_squares_are_correct?
    root = Math.sqrt(@size)

    (0...root).all? do |row|
      (0...root).all? do |column|
        r_idx = (row * root).to_i

        (r_idx...r_idx + root).each_with_object([]) do |mat_row, numbers|
          c_idx = (column * root).to_i
          numbers << @matrix[mat_row][c_idx...c_idx + root]
        end.flatten.uniq.size === @size
      end
    end
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

  def test_invalid_3
    sudoku = Sudoku.new([
      [1,2,3, 4,5,6, 7,8,9],
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

  def test_invalid_4
    sudoku = Sudoku.new([
      [7,8,4, 1,5,9, 3,2,6],
      [5,3,9, 6,7,2, 8,4,1],
      [6,1,2, 4,3,8, 7,5,9],

      [9,2,8, 7,1,5, 4,6,3],
      [3,5,7, 8,4,6, 1,9,2],
      [8,7,6, 3,9,4, 2,1,5],

      [4,6,1, 9,2,3, 5,8,7],
      [2,4,3, 5,6,1, 9,7,8],
      [1,9,5, 2,8,7, 6,3,4]
    ])

    assert_equal(false, sudoku.valid?)
  end
end
