module Strategy::Model
  class Battle
    include Base

    attr_accessor :name, :turn

    def initialize(args)
      asdf = JSON.parse(args["value"])
      #print "Current board: #{asdf}"
      super asdf
    end

    def board
      turn.board
    end

    def robots
      board.robots
    end

    def power_ups
      board.power_ups
    end
  end
end
