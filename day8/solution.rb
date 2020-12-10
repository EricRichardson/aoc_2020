class Emulator
	def initialize(file: 'input.txt')
		@rom = {}	
		File.open(file).each do |line|
			@rom[$.-1] = line.chomp
		end
	end
	
	def find_loop
		acc = 0
		sp = 0
		seen = {}
		while !seen[sp] do
			seen[sp] = true
			puts "sp", sp
			pp @rom
			parts = @rom[sp].split(' ')
			cmd = parts[0]
			val = parts[1].to_i
			case cmd
			when 'acc' 
				acc += val
				sp += 1
			when 'jmp' 
				sp += val
			when 'nop' 
				sp += 1
			else 
				puts "unknown command #{cmd}"
			end
		end
		acc
	end
end

puts Emulator.new.find_loop
