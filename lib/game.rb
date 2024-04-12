require_relative 'player_creator'
require_relative 'card'


class Game < Card

    def initialize
        @player_creator = PlayerCreator.new
    end

    def add_players
        @players = @player_creator.get_players
        puts "Welcome #{@players.join(' and ')}"
    end

    def start
        #make and shuffle the cards 
        myCards = generateCards
        myCards = myCards.shuffle
        numOfCardsUsed = 12
        displayCards(myCards.first(12)) 
        
        #main loop to keep game running
        while(true)
            quit = false
            currentPlayer = -1

            #figure out who is going
            puts "Do you think you found a set? Type y if you think you found a set and type n if you think there is no set."
            input = gets.chomp
            if(input == 'n')
                if(thinksNoSet?(myCards.first(12)))
                    break
                end
            end

            puts "Who found a set, #{@players.join(' or ')}?"
            playerUp = gets.chomp
            if(@players[0].to_s == playerUp)
                currentPlayer = 0
            elsif(@players[1].to_s == playerUp)
                currentPlayer = 1
            end
            
            #select cards
            puts "Enter the 1st card you think is in the set based on the card's ID (or type q to quit)"
            firstCard = gets.chomp
            if(firstCard == "q")
                break
            end
            puts "Enter the 2nd card you think is in the set"
            secondCard = gets 
            puts "Enter the 3rd card you think is in the set"
            thirdCard = gets 
            
            #check if those cards make a set
            if (checkSet?(firstCard,secondCard,thirdCard,myCards))
                if(numOfCardsUsed+3 <= 81)
                    myCards = removeCards(firstCard,secondCard,thirdCard,myCards)
                    numOfCardsUsed += 3
                    @players[currentPlayer].addScore
                    @players[0].displayScore
                    @players[1].displayScore
                    puts "\nWould you like to keep playing? (y/n)"
                    ans = gets.chomp
                    if(ans == "n")
                        case @players[0].score <=> @players[1].score
                        when -1
                            puts "#{@players[1].to_s} is the winner with a score of #{@players[1].score}"
                        when 0
                            puts "You are both just too good! It's a tie"
                        when 1
                            puts "#{@players[0].to_s} is the winner with a score of #{@players[0].score}"
                        end

                        break
                    end
                    displayCards(myCards.first(12))
                elsif
                    puts "There's not enough cards to continue the game, please play again."
                    break
                end
            elsif
                puts "Try again\n"
            end
            
            end
    end

end

#checks if the 3 cards given make a set
def checkSet?(firstCard,secondCard,thirdCard,cards)
    firstCardIdx = -1
    secondCardIdx = -1
    thirdCardIdx = -1
    set = false
    number = false
    shape = false
    shading = false
    color = false
    
    #get indecies of cards
    cards.each_with_index do |card,index|
        tempId = card.id
        if(tempId == firstCard.to_i)
            firstCardIdx = index 
        elsif(tempId == secondCard.to_i)
            secondCardIdx = index
        elsif(tempId == thirdCard.to_i)
            thirdCardIdx = index
        end
    end

    #deal with possiblity of errors
    if firstCardIdx == -1 || secondCardIdx == -1 || thirdCardIdx == -1 || firstCardIdx == secondCardIdx || secondCardIdx == thirdCardIdx || firstCardIdx == thirdCardIdx
        puts "ERROR: you did not enter a valid card id"
        return false
    end   

    #check color
    fColor = cards.at(firstCardIdx).color
    sColor = cards.at(secondCardIdx).color
    tColor = cards.at(thirdCardIdx).color
    #all the same
    if fColor == sColor && sColor == tColor
        color = true
    elsif fColor != sColor && sColor != tColor && fColor != tColor
        #all different
        color = true
    end

    #check number
    fNum = cards.at(firstCardIdx).number
    sNum = cards.at(secondCardIdx).number
    tNum = cards.at(thirdCardIdx).number
    if fNum == sNum && sNum == tNum
        number = true
    elsif fNum != sNum && sNum != tNum && fNum != tNum
        number = true
    end

    #check shape
    fShape = cards.at(firstCardIdx).shape
    sShape = cards.at(secondCardIdx).shape
    tShape = cards.at(thirdCardIdx).shape
    if fShape == sShape && sShape == tShape
        shape = true
    elsif fShape != sShape && sShape!= tShape && fShape != tShape
        shape = true
    end

    #check shade
    fShade = cards.at(firstCardIdx).shading
    sShade = cards.at(secondCardIdx).shading
    tShade = cards.at(thirdCardIdx).shading
    if fShade == sShade && sShade == tShade
        shading = true
    elsif fShade != sShade && sShade!= tShade && fShade != tShade
        shading = true
    end

    #output
    if number && shading && color && shape
        puts "\nCongrats! You found a set!"
        puts "\n"
        set = true
    else
        puts "\nSorry, that's not a set"
        puts "\n"
    end

    return set
end
