require_relative "grid"

class GameOfLife
  attr_accessor :grid, :generation

  def initialize()
    @grid = Grid.new()
    @generation = 0
  end

  def next_gen
    @grid.calc_new_generation
    @generation += 1
  end

  
  def print
    puts "Generation #{@generation}"
    puts "#{@grid.rows} x #{@grid.cols}"
    @grid.print()
  end
end