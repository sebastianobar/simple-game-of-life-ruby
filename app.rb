require_relative "classes/gol/gol"

gol = GameOfLife.new();

while !gol.current_gen_same_as_prev do
  sleep(1);
  gol.print
  gol.next_gen
end

