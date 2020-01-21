# Write a function which makes a list of strings representing all of the ways you can balance
# n pairs of parentheses
#
# balanced_parens(0) => [""]
# balanced_parens(1) => ["()"]
# balanced_parens(2) => ["()()","(())"]
# balanced_parens(3) => ["()()()","(())()","()(())","(()())","((()))"]

require 'minitest/autorun'

def balanced_parens(pairs_n)
  ['(())', '()()']
end

class Test < Minitest::Test
  def test_case_0
    assert_same_elements([''], balanced_parens(0))
  end

  def test_case_1
    assert_same_elements(['()'], balanced_parens(1))
  end

  def test_case_2
    assert_same_elements(['()()', '(())'], balanced_parens(2))
  end

  def test_case_3
    assert_same_elements(
      ["()()()","(())()","()(())","(()())","((()))"],
      balanced_parens(3)
    )
  end
end
