module Utils
  def closest targets
    targets.sort { |t| robot.distance_to t }
  end

  def fire_at!(enemy)
    direction = robot.direction_to(enemy).round
    skew = direction - robot.rotation
    fire! skew
  end
end