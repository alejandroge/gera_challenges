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

class Sudoku
  def initialize(matrix)
    @matrix = matrix
    @size = matrix.size
    @root = Math.sqrt(@size)
  end

  def valid?
    correct_dimensions? && all_valid_values? &&
      rows_are_correct? && columns_are_correct? &&
      inner_squares_are_correct?
  end

private
  def correct_dimensions?
    @size.positive? && (@root.to_i == @root) &&
      @matrix.all? { |row| row.is_a?(Array) && row.size === @size }
  end

  def all_valid_values?
    @matrix.all? { |row| row.all? { |n| n.is_a?(Integer) && n > 0 && n <= @size } }
  end

  def rows_are_correct?
    @matrix.all? { |row| row.uniq.size === @size }
  end

  def columns_are_correct?
    (0...@size).all? { |index| @matrix.map { |row| row[index] }.uniq.size === @size }
  end

  def inner_squares_are_correct?
    (0...@root).all? do |row|
      (0...@root).all? do |column|
        r_idx = (row * @root).to_i

        (r_idx...r_idx + @root).each_with_object([]) do |mat_row, numbers|
          c_idx = (column * @root).to_i
          numbers << @matrix[mat_row][c_idx...c_idx + @root]
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

  def test_valid_3
    sudoku = Sudoku.new([
      [ 8,15,11, 1, 6, 2,10,14,12, 7,13, 3,16, 9, 4, 5],
      [10, 6, 3,16,12, 5, 8, 4,14,15, 1, 9, 2,11, 7,13],
      [14, 5, 9, 7,11, 3,15,13, 8, 2,16, 4,12,10, 1, 6],
      [ 4,13, 2,12, 1, 9, 7,16, 6,10, 5,11, 3,15, 8,14],
      [ 9, 2, 6,15,14, 1,11, 7, 3, 5,10,16, 4, 8,13,12],
      [ 3,16,12, 8, 2, 4, 6, 9,11,14, 7,13,10, 1, 5,15],
      [11,10, 5,13, 8,12, 3,15, 1, 9, 4, 2, 7, 6,14,16],
      [ 1, 4, 7,14,13,10,16, 5,15, 6, 8,12, 9, 2, 3,11],
      [13, 7,16, 5, 9, 6, 1,12, 2, 8, 3,10,11,14,15, 4],
      [ 2,12, 8,11, 7,16,14, 3, 5, 4, 6,15, 1,13, 9,10],
      [ 6, 3,14, 4,10,15,13, 8, 7,11, 9, 1, 5,12,16, 2],
      [15, 1,10, 9, 4,11, 5, 2,13,16,12,14, 8, 3, 6, 7],
      [12, 8, 4, 3,16, 7, 2,10, 9,13,14, 6,15, 5,11, 1],
      [ 5,11,13, 2, 3, 8, 4, 6,10, 1,15, 7,14,16,12, 9],
      [ 7, 9, 1, 6,15,14,12,11,16, 3, 2, 5,13, 4,10, 8],
      [16,14,15,10, 5,13, 9, 1, 4,12,11, 8, 6, 7, 2, 3]
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

  def test_invalid_5
    sudoku = Sudoku.new([
      [1,4, 2,3],
      [3,2, 4,1],

      [4,1, 3,2],
      1
    ])

    assert_equal(false, sudoku.valid?)
  end
end
