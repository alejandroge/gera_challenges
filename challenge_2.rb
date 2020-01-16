# Challenge - Josephus Permutation

# This problem takes its name by arguably the most important event in the life of the ancient
# historian Josephus: according to his tale, he and his 40 soldiers were trapped in a cave by the
# Romans during a siege.

# Refusing to surrender to the enemy, they instead opted for mass suicide, with a twist: they
# formed a circle and proceeded to kill one man every three, until one last man was left (and that
# it was supposed to kill himself to end the act).

# Well, Josephus and another man were the last two and, as we now know every detail of the story,
# you may have correctly guessed that they didn't exactly follow through the original idea.
# You are now to create a function that returns a Josephus permutation, taking as parameters the
# initial array/list of items to be permuted as if they were in a circle and counted out every k
# places until none remained.

# Examples
# For example, with n=7 and k=3 josephus(7,3) should act this way.

# [1,2,3,4,5,6,7] - initial sequence
# [1,2,4,5,6,7] => 3 is counted out and goes into the result [3]
# [1,2,4,5,7] => 6 is counted out and goes into the result [3,6]
# [1,4,5,7] => 2 is counted out and goes into the result [3,6,2]
# [1,4,5] => 7 is counted out and goes into the result [3,6,2,7]
# [1,4] => 5 is counted out and goes into the result [3,6,2,7,5]
# [4] => 1 is counted out and goes into the result [3,6,2,7,5,1]
# [] => 4 is counted out and goes into the result [3,6,2,7,5,1,4]

# So our final result is:
# josephus([1,2,3,4,5,6,7],3)==[3,6,2,7,5,1,4]

require "minitest/autorun"

def josephus(soldiers, k)
  return soldiers if k == 1 || soldiers.empty?

  execution_order, index = [], 0
  while(soldiers.size > 1)
    current_size = soldiers.size
    new_index = (index - 1) + k # everytime you delete an element, you go back one place
    index = new_index < current_size ? new_index : (new_index % current_size)

    execution_order << soldiers.delete_at(index)
  end
  execution_order << soldiers.last
end

class Testing < Minitest::Test
  def test_josephus
    assert_equal(josephus([1,2,3,4,5,6,7,8,9,10],1),[1,2,3,4,5,6,7,8,9,10])
    assert_equal(josephus([1,2,3,4,5,6,7,8,9,10],2),[2, 4, 6, 8, 10, 3, 7, 1, 9, 5])
    assert_equal(
      josephus(["C","o","d","e","W","a","r","s"], 4), ['e', 's', 'W', 'o', 'C', 'd', 'r', 'a']
    )
    assert_equal(josephus([1,2,3,4,5,6,7],3),[3, 6, 2, 7, 5, 1, 4])
    assert_equal(josephus([],3),[])
    assert_equal(josephus([1, 2], 10), [2, 1])
    assert_equal(Permutation.josephus([nil,3],2), [3])
  end
end
