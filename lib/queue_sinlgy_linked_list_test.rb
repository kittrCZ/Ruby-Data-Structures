require "test/unit"
require "queue"

class ListQueueTest < Test::Unit::TestCase
  def setup
    @x = SinglyListQueue.new()
    @x.queue(1)
    @x.queue(2)
    @x.queue(3)
    @x.queue(4)
    @x.queue(5)
  end

 def test_queue
    for a in 0..100 do
      @x.queue(a)
    end

   for b in 100..0 do
     assert_equal @x.dequeue(), b
   end

  end
  def test_dequeue
    assert_equal @x.dequeue(), 1
    assert_equal @x.dequeue(), 2
    assert_equal @x.dequeue(), 3
    assert_equal @x.dequeue(), 4
    assert_equal @x.dequeue(), 5

    @x.queue(5)
    @x.queue(4)
    @x.queue(3)
    @x.queue(2)
    @x.queue(1)
    
    assert_equal @x.dequeue(), 5
    assert_equal @x.dequeue(), 4
    assert_equal @x.dequeue(), 3
    assert_equal @x.dequeue(), 2
    assert_equal @x.dequeue(), 1
  end

end