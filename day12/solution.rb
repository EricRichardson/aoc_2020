class Ship
  BEARINGS = [:north, :east, :south, :west]
  attr_accessor :x, :y, :bearing
  attr_accessor :p_x, :p_y, :mode

  def initialize(config: :default)
    @bearing = BEARINGS[1]
    @x, @y = 0, 0
    @p_x, @p_y = 10, 1
    @mode = config
  end
    
  def move(direction, distance)
    case direction
    when 'F' then forward distance
    when 'R' then right distance
    when 'L' then left distance
    when 'N' then north distance
    when 'E' then east distance
    when 'S' then south distance
    when 'W' then west distance
    else raise "Unrecognized direction: #{direction}"
    end
  end

  def forward distance
    if @mode == :way
      @x += @p_x * distance
      @y += @p_y * distance
      return
    end
    case @bearing
    when :north then @y += distance
    when :east then @x += distance
    when :south then @y -= distance
    when :west then @x -= distance
    else raise "Unrecognized @bearing: #{@bearing}"
    end
  end

  def north distance
    if @mode == :way
      @p_y += distance
      return
    end
    @y += distance
  end

  def east distance
    if @mode == :way
      @p_x += distance
      return
    end
    @x += distance
  end

  def south distance
    if @mode == :way
      @p_y -= distance
      return
    end
    @y -= distance
  end

  def west distance
    if @mode == :way
      @p_x -= distance
      return
    end
    @x -= distance
  end

  def right distance
    if @mode == :way
      case distance / 90
      when 1 then @p_x, @p_y = @p_y, -@p_x
      when 2 then @p_x, @p_y = -@p_x, -@p_y
      when 3 then @p_x, @p_y = -@p_y, @p_x
      end
      return
    end
    @bearing = case @bearing 
    when :north then BEARINGS[(distance / 90) % 4]
    when :east then BEARINGS[(distance / 90 + 1) % 4]
    when :south then BEARINGS[(distance / 90 + 2) % 4]
    when :west then BEARINGS[(distance / 90 + 3) % 4]
    end
  end

  def left distance
    if @mode == :way
      case distance / 90
      when 1 then @p_x, @p_y = -@p_y, @p_x
      when 2 then @p_x, @p_y = -@p_x, -@p_y
      when 3 then @p_x, @p_y = @p_y, -@p_x
      end
      return
    end
    @bearing = case @bearing 
    when :north then BEARINGS[(-distance / 90) % 4]
    when :east then BEARINGS[(-distance / 90 + 1) % 4]
    when :south then BEARINGS[(-distance / 90 + 2) % 4]
    when :west then BEARINGS[(-distance / 90 + 3) % 4]
    else raise "Unrecognized @bearing: #{@bearing}"
    end
  end

  def travelled
    @x.abs + @y.abs
  end
end

def solve
  ship = Ship.new(config: :way)
  file_name = 'input.txt'
  File.readlines(file_name).each do |line|
    line.scan(/(\w)(\d+)/).each do |cmd|
      ship.move(cmd[0], cmd[1].to_i)
    end
  end
  ship.travelled
end

puts solve
