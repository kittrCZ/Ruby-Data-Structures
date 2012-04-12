$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'boolean_array'

class BooleanArray
  # Invokes block once for each element of self. Creates a new array containing the values returned by the block.
  def collect
    result = []
    self.each { |item|
      result << (yield item)
    }
    return result
  end

  # Converts self to the standard Ruby Array.
  def to_a
    return collect { |item| item }
  end
end

# Contains tests of BooleanArray implementation
class BooleanArrayTest < Test::Unit::TestCase

  def setup
    @x = BooleanArray.new(20)
    @x << true
    @x << true
    @x << false

    @y = BooleanArray.new(3)
  end

  def test_get
    assert_equal true, @x[0]
    assert_equal true, @x[1]
    assert_equal false, @x[2]
    assert_equal [true, true, false], @x.to_a
    assert_raise(IndexOutOfBoundsException) { @x[-1] }
    assert_raise(IndexOutOfBoundsException) { @x[3] }
  end

  def test_set
    @x[1] = false
    @x[2] = true
    assert_equal true, @x[0]
    assert_equal false, @x[1]
    assert_equal true, @x[2]
    assert_equal [true, false, true], @x.to_a
    assert_raise(IndexOutOfBoundsException) { @x[-1] = true }
    assert_raise(IndexOutOfBoundsException) { @x[20] = true }
    assert_raise(BooleanExpectedException) { @x[0] = 1 }
    assert_raise(BooleanExpectedException) { @x[0] = "" }
  end

  def test_find
    assert_equal 0, @x.find(true)
    assert_equal 2, @x.find(false)
    @x[2] = true
    assert_nil @x.find(false)
  end

  def test_insert
    assert_equal [true, true, true, false], @x.insert(0, true).to_a
    assert_equal [false, true, true, true, false], @x.insert(0, false).to_a
    assert_equal [false, true, true, true, false, false], @x.insert(5, false).to_a
    assert_equal [false, true, true, true, false, false, true], @x.insert(6, true).to_a
    assert_equal [false, true, false, true, true, false, false, true], @x.insert(2, false).to_a
    assert_equal [false, true, true, false, true, true, false, false, true], @x.insert(1, true).to_a
    assert_raise(IndexOutOfBoundsException) { @x.insert(-1, true) }
    assert_raise(IndexOutOfBoundsException) { @x.insert(20, true) }
    assert_raise(BooleanExpectedException) { @x.insert(0, 1) }
    assert_raise(BooleanExpectedException) { @x.insert(0, "") }

    @y.insert(0, true)
    @y.insert(0, true)
    @y.insert(0, true)
    assert_raise(IndexOutOfBoundsException) { @y.insert(0, true) }
  end

  def test_delete_at
    @x << false
    @x << true
    assert_equal true, @x.delete_at(0)
    assert_equal [true, false, false, true], @x.to_a
    assert_equal false, @x.delete_at(1)
    assert_equal [true, false, true], @x.to_a
    assert_equal true, @x.delete_at(2)
    assert_equal [true, false], @x.to_a
    assert_raise(IndexOutOfBoundsException) { @x.delete_at(-1) }
    assert_raise(IndexOutOfBoundsException) { @x.delete_at(20) }

    @y << true
    @y << true
    @y << true
    @y.delete_at(0)
    @y.delete_at(0)
    @y.delete_at(0)
    assert_raise(IndexOutOfBoundsException) { @y.delete_at(0) }
  end

  def test_append
    assert_equal [true, true, false, false], (@x << false).to_a
    assert_equal [true, true, false, false, true], (@x << true).to_a
    assert_raise(BooleanExpectedException) { @x << 1 }
    assert_raise(BooleanExpectedException) { @x << "" }

    @y << true
    @y << true
    @y << true
    assert_raise(IndexOutOfBoundsException) { @y << true }
  end

  def test_unshift
    assert_equal [false, true, true, false], @x.unshift(false).to_a
    assert_equal [true, false, true, true, false], @x.unshift(true).to_a
    assert_raise(BooleanExpectedException) { @x.unshift(1) }
    assert_raise(BooleanExpectedException) { @x.unshift("") }

    @y.unshift(true)
    @y.unshift(true)
    @y.unshift(true)
    assert_raise(IndexOutOfBoundsException) {@y.unshift(true) }
  end

end
