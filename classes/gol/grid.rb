require_relative "cell"

class Grid
  attr_accessor :rows, :cols, :cell_board, :cells
  
  def initialize(rows=8, cols=8, initial_alives_cells=[{x: 0, y: 0}])
    @rows = rows
    @cols = cols
    @cell_board = Array.new(rows) do |row|
      Array.new(cols) do |col|
        Cell.new(col, row, initial_alives_cells.include?({x:col, y:row}))
      end
    end
  end

  def live_neighbours_around_cell(cell)
    live_neighbours = []
    # Neighbour to the North-East
    if cell.y > 0 and cell.x < (cols - 1)
      candidate = @cell_board[cell.y - 1][cell.x + 1]
      live_neighbours << candidate if candidate.alive?
    end
    # Neighbour to the South-East
    if cell.y < (rows - 1) and cell.x < (cols - 1)
      candidate = @cell_board[cell.y + 1][cell.x + 1]
      live_neighbours << candidate if candidate.alive?
    end
    # Neighbours to the South-West
    if cell.y < (rows - 1) and cell.x > 0
      candidate = @cell_board[cell.y + 1][cell.x - 1]
      live_neighbours << candidate if candidate.alive?
    end
    # Neighbours to the North-West
    if cell.y > 0 and cell.x > 0
      candidate = @cell_board[cell.y - 1][cell.x - 1]
      live_neighbours << candidate if candidate.alive?
    end
    # Neighbour to the North
    if cell.y > 0
      candidate = @cell_board[cell.y - 1][cell.x]
      live_neighbours << candidate if candidate.alive?
    end
    # Neighbour to the East
    if cell.x < (cols - 1)
      candidate = @cell_board[cell.y][cell.x + 1]
      live_neighbours << candidate if candidate.alive?
    end
    # Neighbour to the South
    if cell.y < (rows - 1)
      candidate = @cell_board[cell.y + 1][cell.x]
      live_neighbours << candidate if candidate.alive?
    end
    # Neighbours to the West
    if cell.x > 0
      candidate = @cell_board[cell.y][cell.x - 1]
      live_neighbours << candidate if candidate.alive?
    end
    live_neighbours
  end


  def calc_new_generation
    # Prepare grid clone
    next_gen_cell_board = Array.new(rows) do |row|
      Array.new(cols) do |col|
        Cell.new(col, row, cell_board[row][col].alive?)
      end
    end
    @cell_board.each do |row|
      row.each do |element|
        live_neighbours_count = live_neighbours_around_cell(element).length()
        if element.alive? && (live_neighbours_count < 2 || live_neighbours_count > 3)
          next_gen_cell_board[element.y][element.x].die!
        elsif element.dead? && live_neighbours_count == 3
          next_gen_cell_board[element.y][element.x].revive!
        end
      end
    end
    @cell_board = next_gen_cell_board;
  end


  def print
    @cell_board.each do |row|
      string_row_separator = '-'
      string_row = '|'
      row.each do |element|
        string_row += " #{element.to_s} |"
        string_row_separator += '----'
      end
      puts string_row
      puts string_row_separator
    end
  end

end