def solve()
	highest = 0
	results = []
	File.readlines('input.txt').each do |line|
		line = line.strip
		id = 0
		line.each_char do |r|
			id = id << 1 
			id = id | (r == 'B' || r == 'R' ? 1 : 0)
		end
		results << id
		highest = id if id > highest
	end
	results = results.sort
	results.each_with_index {|n, i| puts "found", n+1 if n+1 != results[i+1]}
	highest
end
puts solve()
