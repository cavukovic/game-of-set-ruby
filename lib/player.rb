class Player
    attr_reader :name
    attr_reader :score

    def initialize(name)
        @name = name
        @score = 0
    end

    def to_s
        "#{@name}"
    end

    def addScore
        @score = @score + 1
    end

    def displayScore
        puts "The current score for #{@name} is #{@score}"
    end

end