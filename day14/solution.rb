def solve
  mem = []
  mask = ""
  File.readlines('input.txt').each do |line|
    if line.start_with?('mask =')
      mask = line.scan(/(\w+$)/).first.first
    else
      parts = line.scan(/\[(\d+)\] = (\d+)/)
      addr, val = parts.first[0].to_i, parts.first[1].to_i
      # part 1
       val = val.to_s(2).rjust(mask.length, "0")
      mask.each_char.with_index do |m, i|
        next if m == 'X'
        val[i] = m
      end
      mem[addr] = val.to_i(2)

  #part 2

#      mask.each_char.with_index do |m, i|
#        addr  = addr.to_s(2).rjust(mask.length, "0")
#        addrs = []
#        mask.each_char.with_index do |c, i|
#          if c == 'X'
#            other = addr.dup
#          else
#
#          end  
#        end
#      end

    end
  end
  mem.compact.reduce(&:+) 
end

puts solve
