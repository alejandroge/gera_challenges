# Colored Triangles
# A coloured triangle is created from a row of colours, each of which is red, green or blue.
# Successive rows, each containing one fewer colour than the last, are generated by considering
# the two touching colours in the previous row. If these colours are identical, the same colour
# is used in the new row. If they are different, the missing colour is used in the new row.
# This is continued until the final row, with only a single colour, is generated.

# The different possibilities are:
# Colour here:        G G        B G        R G        B R
# Becomes colour:      G          R          B          G

#With a bigger example:
# R R G B R G B B
#  R B R G B R B
#   G G B R G G
#    G R G B G
#     B B R R
#      B G R
#       R B
#        G

# You will be given the first row of the triangle as a string and its your job to return the final
# colour which would appear in the bottom row as a string. In the case of the example above, you
# would the given RRGBRGBB you should return G.
# * The input string will only contain the uppercase letters R, G, B and there will be at least one
#   letter so you do not have to test for invalid input.
# * If you are only given one colour as the input, return that colour.

import unittest

class Triangle:
  COLOR_TRANSLATION = {
    'BG': 'R', 'GB': 'R',
    'RG': 'B', 'GR': 'B',
    'BR': 'G', 'RB': 'G',
  }

  def __init__(self, bottom_row):
    self.triangle = self.build_triangle(bottom_row)

  def build_triangle(self, bottom_row):
    base_size = current_base = len(bottom_row)
    triangle = [bottom_row]

    for i in range(0, base_size-1):
      next_row = ''

      for j in range(1, current_base):
        parents = triangle[i][j-1:j+1]
        next_row += parents[0] if parents[0] == parents[1] else self.COLOR_TRANSLATION[parents]

      triangle.append(next_row)
      current_base -= 1

    return triangle

  def point_color(self):
    return self.triangle[-1][0]

def triangle(bottom_row):
  return Triangle(bottom_row).point_color()

class MyTest(unittest.TestCase):
  def test_1(self):
    self.assertEqual(triangle('GB'), 'R')

  def test_2(self):
    self.assertEqual(triangle('RRR'), 'R')

  def test_3(self):
    self.assertEqual(triangle('RGBG'), 'B')

  def test_4(self):
    self.assertEqual(triangle('RBRGBRB'), 'G')

  def test_5(self):
    self.assertEqual(triangle('RBRGBRBGGRRRBGBBBGG'), 'G')

  def test_6(self):
    self.assertEqual(triangle('B'), 'B')

unittest.main()