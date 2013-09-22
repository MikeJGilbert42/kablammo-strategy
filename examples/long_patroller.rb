require './examples/base_strategy.rb'

class LongPatroller < BaseStrategy
  PATROL_VECTORS = [0, 45, 90, 135, 180, 225, 275]
  def execute
    if @combat_mode
      return combat_move
    end
    if patrol_dest
      if (@enemy = closest(opponents))
        @patrol_dest = nil
        puts "COMBAT TIME!"
        @combat_mode = true
        retreat!
      else
        @patrol_dest = nil if robot.x == patrol_dest.x && robot.y == patrol_dest.y
        save_position
        move_towards! patrol_dest
      end
    else
      rest
    end
  end

  def patrol_dest
    return @patrol_dest if @patrol_dest
    # Pick the direction we can travel the longest
    all_vectors = PATROL_VECTORS.map { |angle| [angle, visible_portion(robot.line_of_sight(angle))] }
    best_vector = all_vectors.sort { |d1, d2| d1[1].count <=> d2[1].count }.last
    dest = best_vector[1].last
    @patrol_dest = dest
  end

  def visible_portion vector
    wall_index = vector.index { |point| board.obstruction? point }
    vector = vector[0, wall_index] if wall_index
    vector
  end

  def combat_move
    puts "Retreated from: #{@retreated_from}"
    if !@fired && @retreated_from.nil?
      puts "FIRE!"
      # Fire!
      @fired = true
      fire_at! @enemy
    elsif @retreated_from != nil
      puts "Ready, aim!"
      # Ready, aim!
      return aim_at!(@enemy) if !aiming_at?(@enemy)
      # Charge!
      puts "Charge!"
      save_position
      dest = @retreated_from
      @retreated_from = nil
      move_towards! dest
    else
      # Back it up!
      puts "Back it up!"
      @fired = false
      retreat!
    end
  end
end