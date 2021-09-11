
class Cell
  attr_accessor :x, :y, :alive
  
  def initialize(x=0, y=0, alive=false)
    @x = x
    @y = y
    @alive = alive
  end

  def alive?; alive; end
  
  def dead?; !alive; end

  def die!
    @alive = false
  end

  def revive!
    @alive = true 
  end

  def to_s
    if self.alive? 
      return '*'
    else
      return '.'
    end
  end
end
