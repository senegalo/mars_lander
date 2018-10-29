STDOUT.sync = true # DO NOT REMOVE
# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

@land_x = []
@land_y = []

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

# game loop
loop do
    # h_speed: the horizontal speed (in m/s), can be negative.
    # v_speed: the vertical speed (in m/s), can be negative.
    # fuel: the quantity of remaining fuel in liters.
    # rotate: the rotation angle in degrees (-90 to 90).
    # power: the thrust power (0 to 4).
    x, y, h_speed, v_speed, fuel, rotate, power = gets.split(" ").collect {|x| x.to_i}

    STDERR.puts best_landing_spot
    # Write an action using puts
    # To debug: STDERR.puts "Debug messages..."


    # rotate power. rotate is the desired rotation angle. power is the desired thrust power.
    puts "-20 3"
end
