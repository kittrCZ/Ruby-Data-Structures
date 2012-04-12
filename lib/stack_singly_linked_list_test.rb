# To change this template, choose Tools | Templates
# and open the template in the editor.

require "stack.rb"
require 'test/unit'

class SinglyListStackTest < Test::Unit::TestCase
  def setup
    @x = SinglyListStack.new()
    @x.push(1)
    @x.push(2)
    @x.push(3)
    @x.push(4)
    @x.push(5)
    @x.push(6)

  end

  def test_pop
    assert_equal @x.pop(), 6
    assert_equal @x.pop(), 5
    assert_equal @x.pop(), 4
    assert_equal @x.pop(), 3
    assert_equal @x.pop(), 2
    assert_equal @x.pop(), 1
    #PUSH
    @x.push(10)
    @x.push(9)
    @x.push(8)
    @x.push(7)
    @x.push(6)
    @x.push(5)
    #POP
    assert_equal @x.pop(), 5
    assert_equal @x.pop(), 6
    assert_equal @x.pop(), 7
    assert_equal @x.pop(), 8
    assert_equal @x.pop(), 9
    assert_equal @x.pop(), 10
  end
end

