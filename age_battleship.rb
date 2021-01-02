# frozen_string_literal: true

require 'minitest/autorun'
require 'byebug'

module Battleship
  InvalidShipPositions = Class.new(StandardError)

  class Field
    def initialize(field)
      @field = field
      @validation_field = field.dup
    end

    def valid?
      valid_ships = { 4 => 1, 3 => 2, 2 => 3, 1 => 4 }

      (0...9).each do |row_no|
        while (index = @validation_field[row_no].index { |c| c == 1 })
          byebug
          return false if invalid_position?(row_no, index)
          true
        end
      end
    rescue InvalidShipPositions
      false
    end

  end
end

class Test < Minitest::Test
  def test_case_1
    field = [[1, 0, 0, 0, 0, 1, 1, 0, 0, 0],
             [1, 0, 1, 0, 0, 0, 0, 0, 1, 0],
             [1, 0, 1, 0, 1, 1, 1, 0, 1, 0],
             [1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
             [0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
             [0, 0, 0, 0, 1, 1, 1, 0, 0, 0],
             [0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
             [0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
             [0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
             [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]

    assert_equal(
      true,
      Battleship::Field.new(field).valid?
    )
  end

end
