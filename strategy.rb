require './examples/just_fire.rb'
require './examples/long_patroller.rb'

STRATEGIES_PER_MAP = { 'Battle Royale' => JustFire,
                       'KISS'          => JustFire }

on_turn do
  @strategy ||= (STRATEGIES_PER_MAP[battle.name] || LongPatroller).new self
  @strategy.execute
end
