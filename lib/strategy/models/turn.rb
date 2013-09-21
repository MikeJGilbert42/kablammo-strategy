module Strategy::Model
  class Turn
    include Base

    attr_accessor :board, :battle

    def initialize(parent, args)
      super(args)
      @battle = parent
      #@board = Board.new self, args
    end

    def to_s
      "Turn[]"
    end
  end
end
