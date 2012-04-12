require "index_out_of_bounds_exception"
require "boolean_expected_exception"

class BooleanArray
  attr_reader :length
  attr_reader :used_length

  def initialize(length)
    @length = length
    @used_length = 0
    @inner = Array.new((length - 1) / 8 + 1, 0)
  end

  private

  def get_byte_bit(index)
    return index / 8, index % 8
  end

  public

  # get(i)
  def [](index)
    raise IndexOutOfBoundsException.new(index, @length) if (index < 0 || index >= @used_length)
    byte, bit = get_byte_bit(index)
    return ((@inner[byte]) & (1 << bit)) != 0
  end

  # set(i, value)
  # vrací hodnotu value
  def []=(index, value)
    raise IndexOutOfBoundsException.new(index, @length) if (index < 0 || index >= @length)
    raise BooleanExpectedException.new(value) unless value.instance_of?(TrueClass) || value.instance_of?(FalseClass)
    byte, bit = get_byte_bit(index)
    if value
      @inner[byte] |= 1 << bit
    else
      @inner[byte] &= 255 - (1 << bit)
    end
    @used_length = index + 1 if index >= @used_length
    return value
  end

  # find(value)
  # v případě neúspěchu vrací nil
  def find(value)
    @used_length.times { |index|
      return index if self[index] == value
    }
    return nil
  end

  # iterate(callback)
  def each
    @used_length.times { |i|
      yield self[i]
    }
  end

  # insert(i, value)
  # vrací pole samotné
  def insert(index, value)
    raise IndexOutOfBoundsException.new(index, @length) if (index < 0 || index >= @length)
    raise IndexOutOfBoundsException.new(@length, @length) if @used_length == @length
    raise BooleanExpectedException.new(value) unless value.instance_of?(TrueClass) || value.instance_of?(FalseClass)
    if index >= @used_length
      self[index] = value
    else
      i = @used_length - 1
      while i >= index
        self[i + 1] = self[i]
        i -= 1
      end
      self[index] = value
    end
    return self
  end

  # remove(i)
  # vrací odebranou hodnotu
  def delete_at(index)
    raise IndexOutOfBoundsException.new(index, @length) if (index < 0 || index >= @used_length)
    removed = self[index]
    i = index
    while i < @used_length - 1
      self[i] = self[i + 1]
      i += 1
    end
    self[i] = false
    @used_length = i
    return removed
  end

  # append(value)
  def <<(value)
    self.insert(@used_length, value)
  end

  # prepend(value)
  def unshift(value)
    self.insert(0, value)
  end

end
