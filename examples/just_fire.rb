require './examples/utils.rb'

class JustFire
  include Utils

  def execute
    return rest if my.ammo == 0
    fire_at!(closest(opponents))
  end
end