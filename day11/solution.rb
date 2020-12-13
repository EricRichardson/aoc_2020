
def solve
  file_name = 'input.txt'
  map = []
  tolerance = 5
  File.readlines(file_name).each do |line|
    map << line.chomp.split('') 
  end
  cardinals = -> (i, j) {
    x = [i-1, i, i+1].reject { |i| i.negative? || i >= map.length }
    y = [j-1, j, j+1].reject { |j| j.negative? || j >= map.first.length }
    x.product(y).reject{ |pair| pair[0] == i && pair[1] == j }
  }
  changed = true
  new_map = []
  count = 0
  while(changed) do
    break if count > 9
    changed = false
    new_map = map.map(&:dup)
    (0...map.length).each do |i|
      (0...map.first.length).each do |j|
        loc = map[i][j]
        directions = cardinals.call(i, j)
        if loc == 'L'
          empty = true
          directions.each do |cord|
            x, y = cord[0], cord[1]
            while(map.dig(x, y) == '.') do
              x += cord[0] - i
              y += cord[1] - j
            end
            next if x < 0 || x >= map.length
            next if y < 0 || y >= map.first.length
            empty = false if map[x][y] == '#'
          end
          if empty
            new_map[i][j] = '#' 
            changed = true
          end
        elsif loc == '#'
          occupied = 0
          directions.each do |cord|
            x, y = cord[0], cord[1]
            while(map.dig(x, y) == '.') do
              x += cord[0] - i
              y += cord[1] - j
            end
            next if x < 0 || x >= map.length
            next if y < 0 || y >= map.first.length
            occupied += 1 if map[x][y] == '#'
          end
          if occupied >= tolerance
            new_map[i][j] = 'L'
            changed = true
          end
        end
      end
    end
    map = new_map
  end

  map.sum {|line| line.sum { |seat| seat == '#' ? 1 : 0 } }
end

puts solve
