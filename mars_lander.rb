STDOUT.sync = true # DO NOT REMOVE
# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

@land_x = []
@land_y = []

MAX_H_ACC = 1.433
MAX_H_V = 30.0
MIN_BREAKING_DISTANCE = MAX_H_V**2/(2*MAX_H_ACC)+200
STDERR.puts "MIN_BREAKING_DISTANCE: #{MIN_BREAKING_DISTANCE}"

@surface_n = gets.to_i # the number of points used to draw the surface of Mars.
@surface_n.times do
  # land_x: X coordinate of a surface point. (0 to 6999)
  # land_y: Y coordinate of a surface point. By linking all the points together in a sequential fashion, you form the surface of Mars.
  land_data = gets.split(" ").collect {|x| x.to_i}
  @land_x << land_data[0]
  @land_y << land_data[1]
end

def best_landing_spot
  return @best_landing_spot if @best_landing_spot
  terrain = []
  @surface_n.times do |i|
    if terrain.count == 0 || terrain.last[:y] != @land_y[i]
      terrain << {
        x: @land_x[i],
        y: @land_y[i],
        length: 0
      }
    elsif terrain.last[:y] == @land_y[i]
      terrain.last[:length] += @land_x[i] - terrain.last[:x]
    end
  end
  @best_landing_spot = terrain.sort { |a,b| a[:length] <=> b[:length]}.last
end

def activation(x)
  Math.atan(x*8/MIN_BREAKING_DISTANCE)/(Math::PI/2)
end

def go_to_x(x, v0, dx)
  diff = x - dx
  v_h = -1 * activation(diff) * MAX_H_V
  STDERR.puts "X_DIFF: #{diff} DES_V_H: #{v_h} ACTIVATION: #{activation(diff)}"
  get_ah_for_vh(v0, v_h)
end

def get_ah_for_vh(v0, vh)
  diff = v0 - vh
  STDERR.puts "V.DIFF: #{diff}"
  out = -1.0 * Math.tanh(diff)*MAX_H_ACC
  STDERR.puts "H_ACC: #{out}"
  out
end

def get_av_for_vv(v0, vv)

end

def get_rotation_acceleration(v_acc, h_acc)
  STDERR.puts "V_ACC: #{v_acc} H_ACC: #{h_acc}"
  acceleration = Math.sqrt(h_acc * h_acc + v_acc * v_acc)
  rotation = to_deg(Math.atan(h_acc/v_acc))
  out = "#{rotation.round} #{acceleration.round}"
  STDERR.puts rotation, acceleration
  out
end

def to_deg(rad)
  rad*180/Math::PI
end

# game loop
loop do
  # h_speed: the horizontal speed (in m/s), can be negative.
  # v_speed: the vertical speed (in m/s), can be negative.
  # fuel: the quantity of remaining fuel in liters.
  # rotate: the rotation angle in degrees (-90 to 90).
  # power: the thrust power (0 to 4).
  x, y, h_speed, v_speed, fuel, rotate, power = gets.split(" ").collect {|x| x.to_i}

  STDERR.puts "x :#{x} y: #{y} H_SPEED: #{h_speed} V_SPEED: #{v_speed} PWD: #{power} RT: #{rotate}"
  # Write an action using puts
  # To debug: STDERR.puts "Debug messages..."

  h_acc = go_to_x(x, h_speed, 2300)


  # rotate power. rotate is the desired rotation angle. power is the desired thrust power.
  puts get_rotation_acceleration(-3.711, h_acc)
end
