require 'byebug'

class PolyTreeNode
  attr_reader :parent, :children, :value
  
  def initialize(value)
    @value = value
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
  
  def dfs(target_value)
    return self if self.value == target_value
    return nil if self.children.empty?
    # debugger
    output = nil
    self.children.each do |child|
      output = child.dfs(target_value)
      return output unless output.nil?
    end
    output
  end
  
  def bfs(target_value)
    queue = [self] 
    until queue.empty?
      queue += queue[0].children unless queue[0].children.empty?
      if queue[0].value == target_value
        return queue[0]
      else 
        queue.shift
      end
    end
  end
end