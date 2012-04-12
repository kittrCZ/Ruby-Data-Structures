require "boolean_array"
require 'singly_linked_list'

class StackEmptyException < Exception
  def initialize(stack)
    @stack = stack
  end

  def message
    "Stack is empty"
  end
end

class StackFullException < Exception
  def initialize(stack)
    @stack = stack
  end

  def message
    "Stack is full"
  end
end

class SinglyListStack
  def initialize
		@list = SinglyLinkedList.new()
    @length = 0
  end

  def push(x)
		@list.unshift(x)
    @length += 1
    return x
  end

  def pop
    if (@length == 0)
		raise StackEmptyException.new
    end
    first = @list[0]
    @list.delete_at(0)
    @length -= 1
    return first
  end
end

class BooleanArrayStack
  def initialize(size)
    
  end

  def push(x)
	
  end

  def pop
   
  end
end
