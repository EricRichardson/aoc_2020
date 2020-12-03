def parse(line)
	parts = line.split(' ')
	nums = parts.first.split('-')
	{
		min: nums.first.to_i,
		max: nums.last.to_i,
		letter: parts[1][0],
		password: parts.last
	}
end

def check(pw)
	password = pw[:password]
	# letter_count = password.count(pw[:letter])
	# if letter_count.between?(pw[:min], pw[:max])
	# 	return true 
	# end
	# false
	first = password[pw[:min]-1] == pw[:letter]
	second = password[pw[:max]-1] == pw[:letter]
	return first ^ second
end

def solve
	good_pw_count = 0
	File.readlines('input.txt').each do |line|	
		puts line
		parsed_line = parse(line)
		if check(parsed_line)
			good_pw_count += 1
		end
	end
	puts good_pw_count, "passing passwords"
end

solve()
