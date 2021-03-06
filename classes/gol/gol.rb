require_relative "grid"
require_relative "config_handler"

class GameOfLife
  attr_accessor :grid, :generation, :current_gen_same_as_prev

  #Initialize game data, input to choose config type
  def initialize(use_json_config = false)
    @current_gen_same_as_prev = false
    initial_config = ConfigHandler.new()
    begin
      if use_json_config
        initial_config.parseAndValidateJsonConfig
      elsif
        initial_config.parseAndValidateCustomConfig
      end
    rescue StandardError => e
      puts "Invalid config, using defaults"
    end
    @grid = Grid.new(initial_config.config["rows"], initial_config.config["columns"], initial_config.config["initial_alive_cells"])
    @generation = initial_config.config["actual_gen"]
  end

  # Step to next generation
  def next_gen
    @grid.calc_new_generation
    @generation += 1
    @current_gen_same_as_prev = @grid.current_gen_same_as_prev
  end

  # Handle printing generation data on the console
  def print
    puts ""
    puts ""
    puts "Generation #{@generation}"
    puts "#{@grid.rows} x #{@grid.cols}"
    @grid.print()
  end
end