class Node
  attr_accessor :data, :nxt
  def initialize(data=nil, nxt=nil)
    @data = data
    @nxt = nxt
  end
end