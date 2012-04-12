class WrongListException < Exception
  def initialize(item, list)
    @item = item
    @list = list
  end
  def message
    "Item #{@item.to_s} not member of list #{@list.to_s}"
  end
end
