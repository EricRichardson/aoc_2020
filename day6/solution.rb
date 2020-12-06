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

