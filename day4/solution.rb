
def check_basic(passport)
	required = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
	required.all? {|f| passport.key? f }
end

def check(passport)
	height = passport['hgt']
	unit = height [-2..-1]
	valid_height = 
	if unit == 'cm'
		height[0..2].to_i.between?(150, 193)
	elsif unit == 'in'
		height[0..1].to_i.between?(59, 76)	
	else
		false
	end
	
	hair = passport['hcl']
	valid_hair = /#[0-9a-f]+$/.match?(hair)

	valid_colors = ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth']
	valid_eye = valid_colors.include?(passport['ecl'])

	valid_pid = passport['pid'] =~ /^[0-9]{9}$/

	valid_height && valid_hair && valid_eye && valid_pid &&
	passport['byr']&.to_i.between?(1920, 2002) &&
	passport['iyr']&.to_i.between?(2010, 2020) &&
	passport['eyr']&.to_i.between?(2020, 2030)
end

def validate
	match = 1
	passport = {}
	File.readlines('input.txt').each do |l|
		if l == "\n"
			match += 1 if check_basic(passport) && check(passport)
			passport = {}
		else
			l.split(' ').map{|p| p.split(':')}.each do |k_v|
				passport[k_v[0]] = k_v[1]
			end
		end
	end
	match
end

puts validate()
