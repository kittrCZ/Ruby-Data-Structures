require "boolean_array"
require "singly_linked_list"

class QueueEmptyException < Exception
  def initialize(queue)
    @queue = queue
  end

  def message
    "Queue is empty"
  end
end

class QueueFullException < Exception
  def initialize(queue)
    @queue = queue
  end

  def message
    "Queue is full"
  end
end

class SinglyListQueue
  def initialize
	   @list = SinglyLinkedList.new()
     @length = 0
  end

  def queue(x)
		@list.unshift(x)
    @length += 1
    return x
  end

  def dequeue
    if (@length == 0)
		raise QueueEmptyException.new
    end
    last = @list[@length-1]
    @list.delete_at(@length-1)
    @length -= 1
    return last
  end
end

class BooleanArrayQueue
  def initialize(size)
		# TODO
  end

  def queue(x)
		# TODO
  end

  def dequeue
		# TODO
  end
end
