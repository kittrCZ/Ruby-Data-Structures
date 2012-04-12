class BooleanExpectedException < Exception
  def initialize(object)
    @object = object
  end
  def message
    "Boolean expected, #{@object.to_s} found"
  end
end
