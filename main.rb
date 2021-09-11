require_relative "classes/gol/gol"

gol = GameOfLife.new();

2.times do
  gol.print
  gol.next_gen
end

puts "Keep running? (y,n)"

input = gets

if "y" == input.chomp.downcase
  while !gol.current_gen_same_as_prev do
    sleep(1);
    gol.print
    gol.next_gen
  end
end

