def all_ans
	count = 0
	lines = []
	File.readlines('input.txt').each do |line|
		line.chomp!
		if line != ''
			lines << line.split('')
		else
			count += lines.reduce(:&).length
			lines = []
		end
	end
	count
end


def any_ans
	count = 0	
	ans = []
	File.readlines('input.txt').each do |line|
		line.chomp!
		if line == ''
			count += ans.uniq.length
			ans = []
		else
			ans.concat(line.split(''))
		end
	end
	count
end

puts any_ans
puts all_ans
