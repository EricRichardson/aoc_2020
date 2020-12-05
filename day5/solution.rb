def solve()
	highest = 0
	File.readlines('input.txt').each do |line|
		line = line.strip
		row_part = line[0..6]
		col_part = line[-3..-1]
		row = 0
		row_part.each_char do |r|
			row = row << 1 
			row = row | (r == 'B' ? 1 : 0)
		end
		col = 0
		col_part.each_char do |c|
	 		col = col << 1	
			col = col | (c == 'R' ? 1 : 0)
		end
		res = (row << 3) + col
		highest = res if res > highest
	end
	highest
end
puts solve()
