require_relative "classes/gol/gol"

gol = GameOfLife.new();
gol.print()


100.times do
  sleep(1);
  gol.print
  gol.next_gen
end

