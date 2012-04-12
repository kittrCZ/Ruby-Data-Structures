$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'singly_linked_list'

class SinglyLinkedList
  # Invokes block once for each element of self. Creates a new array containing the values returned by the block.
  def collect
    result = []
    self.each { |item|
      result << (yield item)
    }
    return result
  end

  # Converts self to Array.
  def to_a
    return collect { |item| item }
  end
end

# Contains tests of SinglyLinkedList implementation
class SinglyLinkedListTest < Test::Unit::TestCase

  def setup
    @x = SinglyLinkedList.new
    @x << 2
    @x << 1
    @x << 0
  end

  def test_get
    assert_equal 2, @x[0]
    assert_equal 1, @x[1]
    assert_equal 0, @x[2]
    assert_equal [2, 1, 0], @x.to_a
    assert_raise(IndexOutOfBoundsException) { @x[-1] }
    assert_raise(IndexOutOfBoundsException) { @x[3] }
  end

  def test_set
    @x[1] = 4
    @x[2] = 3
    assert_equal 2, @x[0]
    assert_equal 4, @x[1]
    assert_equal 3, @x[2]
    assert_equal [2, 4, 3], @x.to_a

    assert_raise(IndexOutOfBoundsException) { @x[-1] = 1 }
    assert_raise(IndexOutOfBoundsException) { @x[20] = 1 }
  end

  def test_find
    assert_equal 2, @x.find(2).object
    assert_equal 1, @x.find(1).object
    assert_equal 0, @x.find(0).object
    assert_nil @x.find(5)
    assert_nil @x.find(7)
  end

  def test_insert_before
    assert_equal [2, 1, 0], @x.to_a
    @x.insert_before(@x.find(2), 3)
    assert_equal [3, 2, 1, 0], @x.to_a
    @x.insert_before(@x.find(1), 4)
    assert_equal [3, 2, 4, 1, 0], @x.to_a
    @x.insert_before(@x.find(0), 5)
    assert_equal [3, 2, 4, 1, 5, 0], @x.to_a
  end

  def test_insert_after
    @x.insert_after(@x.find(0), 3)
    assert_equal [2, 1, 0, 3], @x.to_a
    @x.insert_after(@x.find(1), 4)
    assert_equal [2, 1, 4, 0, 3], @x.to_a
    @x.insert_after(@x.find(2), 5)
    assert_equal [2, 5, 1, 4, 0, 3], @x.to_a
  end

  def test_remove_item
    @x << 4
    @x << 3
    assert_equal [2, 1, 0, 4, 3], @x.to_a
    assert_equal 1, @x.remove_item(@x.find(1))
    assert_equal [2, 0, 4, 3], @x.to_a
    assert_equal 3, @x.remove_item(@x.find(3))
    assert_equal [2, 0, 4], @x.to_a
    assert_equal 2, @x.remove_item(@x.find(2))

  end

  def test_insert
    assert_equal [0, 2, 1, 0], @x.insert(0, 0).to_a
    assert_equal [0, 2, 3, 1, 0], @x.insert(2, 3).to_a
    assert_equal [0, 2, 3, 1, 0, 4], @x.insert(5, 4).to_a
    assert_equal [0, 2, 2, 3, 1, 0, 4], @x.insert(2,2).to_a
    assert_raise(IndexOutOfBoundsException) { @x.insert(10,10).to_a }
  end

  def test_delete_at
    @x << 4
    @x << 3
    assert_equal 2, @x.delete_at(0)
    assert_equal [1, 0, 4, 3], @x.to_a
    assert_equal 0, @x.delete_at(1)
    assert_equal [1, 4, 3], @x.to_a
    assert_equal 3, @x.delete_at(2)
    assert_equal [1, 4], @x.to_a
  end

  def test_append
    @x << 4
    @x << 3
    assert_equal [2, 1, 0, 4, 3], @x.to_a
  end

  def test_unshift
    @x.unshift(4)
    @x.unshift(3)
    assert_equal [3, 4, 2, 1, 0], @x.to_a

    @x = SinglyLinkedList.new
    @x.unshift(0)
    assert_equal [0], @x.to_a
  end

end
