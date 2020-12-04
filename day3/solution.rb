def parse() 
	File.readlines('input.txt').map { |l| l.strip }
end

def traverse(slopes)
	map = parse()
	bottom = map.length
	edge = map.first.length
	ans = 1
	slopes.each do |pair|
		y_inc = pair[0]
		x_inc = pair[1]
		x = 0
		y = 0
		tree_count = 0
		while(x < bottom) do
			tree_count += 1 if map[x][y] == '#'		
			x += x_inc
			y += y_inc
			y = y % edge
		end
		ans *= tree_count
	end
	return ans
end

puts traverse([[1,1], [3,1], [5,1], [7,1], [1,2]])
