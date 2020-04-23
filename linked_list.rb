require_relative 'node.rb'

class LinkedList
  attr_accessor :head, :tail

  def initialize(head=nil, tail=nil)
    @head = head
    @tail = tail || head
  end

  def append(data)
    node = Node.new(data)
    tail ? tail.nxt = node : @head = node
    @tail = node
  end

  def prepend(data)
    node = Node.new(data)
    head ? node.nxt = head : @tail = node
    @head = node
  end

  def size(node=head, counter=0)
    while node
      node = node.nxt
      counter += 1
    end
    counter
  end

  def at(index, node=head, counter=1)
    until counter == index || node == tail
      node = node.nxt
      counter += 1
    end
    counter == index ? node : error_msg
  end

  def pop(node=head)
    if head == tail
      @head, @tail = nil, nil
    else
      node = node.nxt until node.nxt == tail
      node.nxt = nil
      @tail = node
    end
  end

  def contains?(data, node=head)
    return false unless head
    node = node.nxt until node.data == data || node == tail
    node.data == data ? true : false
  end

  def to_s(node=head)
    while node
      print "( #{node.data} ) -> "
      node = node.nxt
    end
    print "nil\n"
  end

  def insert_at(data, index)
    return error_msg unless head
    if index == 1
      prepend(data)
    else
      node = at(index - 1)
      return error_msg if node == error_msg || node == tail
      node.nxt = Node.new(data, node.nxt)
      @tail = node.nxt unless node.nxt.nxt
    end
  end

  def remove_at(index, node=head)
    return error_msg unless head
    if index == 1
      @head = node.nxt
      @tail = nil unless head
    else
      node = at(index - 1)
      return error_msg if node == error_msg || node == tail
      node.nxt = node.nxt.nxt
      @tail = node unless node.nxt
    end
  end

  private

  def error_msg
    'Error: Index not in list'
  end
end

linked_list = LinkedList.new


# TESTING

puts 'APPEND:'
linked_list.append('charmander')
linked_list.append('squirtle')
linked_list.append('pikachu')
linked_list.to_s

puts 'PREPEND:'
linked_list.prepend('bulbasaur')
linked_list.to_s

puts 'SIZE:'
p linked_list.size

puts 'HEAD:'
p linked_list.head.data

puts 'TAIL:'
p linked_list.tail.data

puts 'AT(2):'
p linked_list.at(2).data

puts 'POP:'
linked_list.pop
linked_list.to_s

puts 'CONTAINS?("bulbasaur" / "snorlax"):'
p linked_list.contains?('bulbasaur')
p linked_list.contains?('snorlax')

puts 'INSERT AT("charizard", 2):'
linked_list.insert_at('charizard', 2)
linked_list.to_s

puts 'REMOVE AT(2):'
linked_list.remove_at(2)
linked_list.to_s
