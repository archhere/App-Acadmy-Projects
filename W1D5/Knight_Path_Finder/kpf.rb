class KnightPathFinder
  attr_reader :parent, :children, :pos
  
  def initialize(pos = [0,0])
    @pos = pos
    @parent = nil
    @children = []
  end

  def parent=(parent)
    if parent.nil?
      @parent = nil
    else
      @parent.children.delete(self) unless @parent == nil
      @parent = parent
      parent.children << self unless parent.children.include?(self)
    end
  end
  
  def add_child(child_node)
    child_node.parent = self
  end
  
  def remove_child(child_node)
    if @children.include?(child_node)
      child_node.parent = nil 
    else
      raise "Node is not a child" 
    end
  end
  
  def dfs(target_pos)
    return self if self.pos == target_pos
    return nil if self.children.empty?
    # debugger
    output = nil
    self.children.each do |child|
      output = child.dfs(target_pos)
      return output unless output.nil?
    end
    output
  end
  
  def bfs(target_pos)
    queue = [self] 
    until queue.empty?
      queue += queue[0].children unless queue[0].children.empty?
      if queue[0].pos == target_pos
        return queue[0]
      else 
        queue.shift
      end
    end
  end
  
  def possible_pos(pos)
    positions = [[1,2],[2,1],[-1,2],[2,-1],[-1,-2],[-2,-1],[-2,1],[1,-2]]
    available_positions = positions.map {|el| [(el.first + pos.first),(el.last + pos.last)]}
  end
  
  def valid_pos?(pos)
    pos.all? { |el| el.between?(0,7) }
  end
  
  def correct_pos(arr)
    arr.select {|el| valid_pos?(el)}
  end
end


if __FILE__ == $PROGRAM_NAME
  root = KnightPathFinder.new     
  post = root.possible_pos(root.pos)
  correct_pos(post)
end