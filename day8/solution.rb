class Emulator
	def initialize(file: 'input.txt')
		@rom = {}	
		File.open(file).each do |line|
			@rom[$.-1] = line.chomp
		end
	end
	
	def swap cmd
		cmd == 'jmp' ? 'nop' : 'jmp'	
	end

	def can_swap cmd
		cmd == 'jmp' || cmd == 'nop'
	end
	
	def find_loop
		last_swap = 0
		while true do
		acc = 0
		sp = 0
		seen = {}
		swap = 0
		swapped = false
		puts 'trying', last_swap
		while !seen[sp] && sp <= @rom.length do
			seen[sp] = true
			return acc if sp >= 656
			parts = @rom[sp].split(' ')
			cmd = parts[0]
			if !swapped && can_swap(cmd)
				swap += 1
				if swap > last_swap
					puts "swaping", cmd
					last_swap = swap
					swapped = true
					cmd = swap cmd.strip
				end
			end
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
		end
		acc
	end

end

puts Emulator.new.find_loop
