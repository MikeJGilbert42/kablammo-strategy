require './examples/just_fire.rb'

STRATEGIES_PER_MAP = { 'Battle Royale' => JustFire }

on_turn do
  @strategy ||= (STRATEGIES_PER_MAP[battle.name] || JustFire).new
  @strategy.execute
end
