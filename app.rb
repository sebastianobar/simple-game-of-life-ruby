require_relative "classes/gol/gol"

gol = GameOfLife.new();

while true do
  sleep(1);
  gol.print
  gol.next_gen
end

