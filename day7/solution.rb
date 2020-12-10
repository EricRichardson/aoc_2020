class Solve
	@@file_name='input.txt'
	def initialize
		@row_map = {}
		File.readlines(@@file_name).each_with_index do |l, i|
			parts = l.chomp!.split(' contain ')
			into = parts[1].delete_suffix('.').gsub('bags','bag').split(', ')
			@row_map[parts.first.gsub('bags', 'bag')] = into
		end
		pp @row_map
	end

	def solve
		possible = []
		File.readlines(@@file_name).each do |l|
			bag = l.chomp!
			.delete_suffix('.')
			.gsub('bags', 'bag')
			.split(' contain ').first

			possible << bag if find_gold bag
		end
		possible.length-1
	end
	
	def find_gold bags
		num = bags.slice!(/\d+ /).to_i
		if bags.chomp == "shiny gold bag"
			return true
		end
		return false if bags == "no other bag"
		return @row_map[bags].any?{|b| find_gold b}
	end
end

contents = {}
File.readlines('input.txt').each do |line|
	line = line.chomp.delete_suffix('.')
	parts = line.split(' bags contain ')
	type = parts.first
	contains = parts[1].split(', ')
	contents[type] = contains.map{|c| [c[2..-1].split('bag').first.strip, c[0].to_i]}.to_h
end

def count_bags(contents, bag_type)
	return 0 if bag_type == 'other'
	count = 1
	contents[bag_type].each do |bag, number|
		next if bag == 'other'
		count += number * count_bags(contents, bag)
	end
	count
end
puts "first part", Solve.new().solve
puts "second part", count_bags(contents, 'shiny gold')-1
