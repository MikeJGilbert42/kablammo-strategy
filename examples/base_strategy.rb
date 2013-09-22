require './examples/utils.rb'

class BaseStrategy
  include Utils

  attr_accessor :base

  def method_missing message, *args
    base.send(message, *args) if base.respond_to? message
  end

  def initialize base
    @base = base
  end

  def geometry
    battle.board.geometry
  end

  def current_pixel
    Pixel.new robot.x, robot.y
  end

  def save_position
    (@position_log ||= []) << current_pixel
  end

  def retreat!
    return rest if @position_log.nil? || @position_log.empty?
    @retreated_from = current_pixel
    move_towards! @position_log.pop
  end

  def closest targets
    targets.sort { |t| robot.distance_to t }.first
  end

  def fire_at!(enemy)
    direction = robot.direction_to(enemy).round
    skew = direction - robot.rotation
    fire! skew
  end
end