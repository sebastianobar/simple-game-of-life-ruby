require_relative "classes/gol/gol"

gol = GameOfLife.new();

100.times do
  sleep(1);
  gol.print
  gol.next_gen
end

