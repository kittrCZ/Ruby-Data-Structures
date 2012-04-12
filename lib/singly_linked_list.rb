require "index_out_of_bounds_exception"
require "wrong_list_exception"

class SinglyLinkedListItem
  attr_accessor :object, :next
  attr_reader :list
  def initialize(object, list)
    @object = object
    @list = list
  end
end

class SinglyLinkedList
  attr_reader :length

  def initialize
    @length = 0
    @head = nil
    @tail = nil
  end

  # get_item(i)
  def get_item(index)
		 if ((index >= @length) ||(index < 0))
      raise IndexOutOfBoundsException.new(index,@length)
    end
    item = @head
    index.times do
      item = item.next
    end
    return item
  end

  # get(i)
  def [](index)
    if ((index >= @length) ||(index < 0))
      raise IndexOutOfBoundsException.new(index,@length)
    end
    item = @head
    index.times do
      item = item.next
    end
    return item.object
  end

  # set(i, value)
  # vrací hodnotu value
  def []=(index, object)
		if ((index > @length) ||(index < 0))
      raise IndexOutOfBoundsException.new(index,@length)
    end
    item = @head
    index.times do
      item = item.next
    end
    return item.object = object
  end

  # find(value)
  # v případě neúspěchu vrací nil
  def find(object)
		item = @head
    while (item != nil)
      if (item.object == object)
        return item
      end
      item = item.next
    end
    return nil
  end

  # iterate(callback)
  def each
    if @length > 0
      item = @head
      begin
        yield item.object
        item = item.next
      end until item.nil?
    end
  end

  # insert_before(item, value)
  # vrací novou položku
  def insert_before(item, object)
		if(item == @head)
      self.unshift(object)
    else
      first = nil
      second = nil
      item_head = @head
      while (item_head != nil)
        if (item_head == item)
         second = item_head
         break
        end
        first = item_head
        item_head = item_head.next
      end
        new_it = SinglyLinkedListItem.new(object,self)
        first.next = new_it
        new_it.next = second
        @length +=1
    end
  end

  # insert_after(item, value)
  # vrací novou položku
  def insert_after(item, object)
		if(item == @tail)
      self<<object
    else
      self.insert_before(item.next, object)
    end
  end

  # insert(i, value)
  # vrací seznam samotný
  def insert(index, object)
    if (index > @length)
       raise IndexOutOfBoundsException.new(index,@length)
    end
    if (index == 0)
        next_item = @head
        @head = SinglyLinkedListItem.new(object, self)
        @head.next = next_item
        @length +=1
        return self
    elsif(((index) == @length))
      new_item = SinglyLinkedListItem.new(object, self)
      @tail.next = new_item
      @tail = new_item
       @length +=1
        return self
    else
      new_item = SinglyLinkedListItem.new(object, self)
      position = get_item(index-1)
      position2 = get_item(index)
      position.next = new_item
      new_item.next = position2
      @length +=1
      return self
    end
  end

  # remove_item(item)
  # vrací hodnotu odebrané položky
  def remove_item(item)
	if(item == @head)
     next_item = @head.next
     @head = next_item
      return item.object
    else
      first = nil
      second = nil
      item_head = @head
      while (item_head != nil)
        if (item_head == item)
         second = item_head
         break
        end
        first = item_head
        item_head = item_head.next
      end
        first.next = second.next
        
        @length -=1
        return item.object
    end
  end

  # remove(i)
  # vrací odebranou hodnotu
  def delete_at(index)
   if ((index) > @length)
     raise IndexOutOfBoundsException.new(index, @length)
     return nil
   else
     item = @head
     i = 0
     while i < index
        item = item.next
        i += 1
     end
          return self.remove_item(item)

   end
  end

  # append(value)
  def <<(object)
    item = SinglyLinkedListItem.new(object, self)
		if (@tail == nil)
      @head = item
      @tail = item
    else
      @tail.next = item
      @tail = item
    end
    @length +=1
  end

  # prepend(value)
  def unshift(object)
	  item = SinglyLinkedListItem.new(object, self)
    if (@head == nil)
      @head = item
      @tail = item
    else
      item.next = @head
      @head = item
    end
    @length +=1
    return
  end

end
