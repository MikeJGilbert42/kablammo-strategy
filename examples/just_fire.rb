require './examples/base_strategy.rb'

class JustFire < BaseStrategy
  def execute
    enemy = closest(opponents)
    return rest if my.ammo == 0 || enemy.nil?
    fire_at!(enemy)
  end
end