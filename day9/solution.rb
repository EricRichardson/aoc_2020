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
	File.readlines(filename).each_with_index do |line, i|
		num = line.to_i
		ptr = i % block_size
		if ready
			return num unless find_sum.call(num)
		end
		ready = true if ptr == block_size-1
		cipher[ptr] = num
	end
	'not found'
end

puts find_number
