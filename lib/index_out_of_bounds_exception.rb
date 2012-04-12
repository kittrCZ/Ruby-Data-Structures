class IndexOutOfBoundsException < Exception
  def initialize(index, length)
    @index = index
    @length = length
  end
  def message
    "Index #{@index} cannot be accessed in an array of length #{@length}"
  end
end
