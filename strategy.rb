require './examples/aggressive'
require './examples/defensive'

extend Aggressive
extend Defensive

@chooser = Proc.new do
  # All aggressive!  All the time!!!!
  # WIP
  act_aggressively
end

on_turn do
  @chooser.call
end
