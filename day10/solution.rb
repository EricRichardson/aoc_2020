def solve
  one_diff = 0
  three_diff = 1 # for the device

  small_count = 0
  file_name = 'other.txt'
  adaptors = File
    .readlines(file_name)
    .map(&:to_i)
    .sort
    .inject(0) do |last, adp|
      diff = adp - last
      one_diff += 1 if diff == 1
      three_diff += 1 if diff == 3
      adp
    end
    
  one_diff * three_diff
end

puts solve
