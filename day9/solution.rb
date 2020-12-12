def find_number
	filename = 'input.txt'
	block_size = 25
	ready = false
	cipher = []
	find_sum = ->(num) {
		cipher.each_with_index do |x, i|
			(0..i).each do |y|
				next if x == y
				return true if x + cipher[y] == num
			end
		end
		false
	}
	find_zone = -> (target) {
		lines = File.readlines(filename).map {|l| l.to_i }
		lines.each_with_index do |x, i|
			acc = x
			lines[i..-1].each_with_index do |y, j|
				next if x == y
				acc += y
				if acc == target
					zone = lines[i..j+i].sort
					return zone[0] + zone[-1]
				
				end
				break if acc > target
			end
		end
	}
	File.readlines(filename).each_with_index do |line, i|
		num = line.to_i
		ptr = i % block_size
		if ready
			unless find_sum.call(num)
				puts "target is", num
				zone =  find_zone.call(num)
				return zone
			end
		end
		ready = true if ptr == block_size-1
		cipher[ptr] = num
	end
	'not found'
end

puts find_number
