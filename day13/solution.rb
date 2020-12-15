def solve
  file = File.open('input.txt')
  time = file.gets.to_i
  times = file
    .gets
    .split(',')
    .reject{|b| b == 'x'}
    .map(&:to_i)
  wait = 0
  while(true) do
    now = time + wait 
    times.each do |t|
      return wait * t if now % t == 0
    end
    wait += 1
  end
end

def part2
  file = File.open('input.txt')
  time = file.gets.to_i
  times = file
    .gets
    .split(',')
  wait = 100000000000000
  while(true) do
    times.each_with_index do |t, i|
      if t != 'x'
        break unless (wait + i) % t.to_i == 0
      end
      return wait if i == times.length - 1
    end
    wait += 1
  end
end

# puts solve

puts part2
