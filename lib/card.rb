class Card 
    attr_accessor :number
    attr_accessor :color
    attr_accessor :shape
    attr_accessor :shading
    attr_accessor :id
    #initialize variables
    def initialize params = {}
        params.each { |key, value| send "#{key}=", value }
    end

    #returns an array 81 unique cards for the game set
    def generateCards
        #define posiblities of attributes
        numbers = [1, 2, 3]
        colors = ["red", "green", "blue"]
        shapes = ["oval", "rombus", "squiggle"]
        shadings = ["empty", "solid", "stripped"]
        cards = []
        count = 0
    
        #generate a deck
        numbers.each_with_index do |a,index1|
            colors.each_with_index do |b,index2|
                shapes.each_with_index do |c,index3|
                    shadings.each_with_index do |d, index4|
                        card = Card.new(number: numbers[index1], color: colors[index2],shape: shapes[index3],shading: shadings[index4],id: count)
                        cards.push(card)
                        count = count + 1
                    end
                end
            end
        end
        return cards
    end

    def thinksNoSet? (cards)
        #brute force check for set (this is terribly inefficent but it'll work)
        cards.each_with_index do |a|
            cards.each_with_index do |b|
                cards.each_with_index do |c|
                    if(a.id != b.id && b.id != c.id && a.id != c.id)    
                        if((a.color == b.color && b.color == c.color)||(a.color != b.color && b.color != c.color && a.color != c.color))
                            if((a.number == b.number && b.number == c.number)||(a.number != b.number && b.number != c.number && a.number != c.number))
                                if((a.shape == b.shape && b.shape == c.shape)||(a.shape != b.shape && b.shape != c.shape && a.shape != c.shape))
                                    if((a.shading == b.shading && b.shading == c.shading)||(a.shading != b.shading && b.shading != c.shading && a.shading!= c.shading))
                                        puts "It must have been hiding from you but there is a set, cards #{a.id}, #{b.id}, and #{c.id} form a set, I'll let one of you take that one."
                                        return false
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        puts "Would you look at that, there is no set. Go ahead and start a new game."
        return true

    end

    #removes three cards and returns array without those three cards   
    def removeCards (firstCard,thirdCard,secondCard,cards)
        stagedForDeletion = []
        #find the cards 
        cards.each_with_index do |card,index|
            temp = card.id
            if(temp == firstCard.to_i || temp == secondCard.to_i || temp == thirdCard.to_i)
                stagedForDeletion.push(index)
            end
        end
        #delete
        cards.delete_at(stagedForDeletion.pop)
        cards.delete_at(stagedForDeletion.pop)
        cards.delete_at(stagedForDeletion.pop)
        return cards
    end

    #prints the cards in a "nice" way in the terminal
    def displayCards(cards)
    shading = [" ","#","="]
    ovals = ["    O    ","    OO   ","   OOO   "]
    rombuses = ["    <>   ","   <><>  ","  <><><> "]
    squiggles = ["    ~    ","    ~~   ","   ~~~   "]
    shapes = [ovals, rombuses, squiggles]
    pArr = [
        [0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0]
    ]
    firstSix = []
    cardIds = []
    cardCount = 0
    counter = 0

    cards.each_with_index do |card,index|
        #init variables
        color = card.color
        shade = card.shading
        shape = card.shape
        number = card.number
        shadeIndx = -1
        shapeIdx = -1
        cardID = card.id
        cardIds.push(cardID)

        #for printing the right shape
        if(shape == "oval")
            shapeIdx = 0
        elsif (shape == "rombus")
            shapeIdx = 1
        elsif(shape == "squiggle")
            shapeIdx = 2
        end

        #for printing the right shading
        if(shade == "empty")
            shadeIdx = 0
        elsif (shade == "solid")
            shadeIdx = 1
        elsif(shade == "stripped")
            shadeIdx = 2
        end

        #output 
        if (color == "green")
        str0 = " --------- ".green
        str1 = "|#{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]}|".green
        str2 = "|#{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]}|".green
        str3 = "|#{shapes[shapeIdx].at(number-1)}|".green
        str4 = "|#{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]}|".green
        str5 = "|#{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]}|".green
        str6 = " --------- ".green

        pArr[0][cardCount] = str0
        pArr[1][cardCount] = str1
        pArr[2][cardCount] = str2
        pArr[3][cardCount] = str3
        pArr[4][cardCount] = str4
        pArr[5][cardCount] = str5
        pArr[6][cardCount] = str6

        cardCount += 1
        
        end 
        if (color == "blue")
        str0 = " --------- ".blue
        str1 = "|#{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]}|".blue
        str2 = "|#{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]}|".blue
        str3 = "|#{shapes[shapeIdx].at(number-1)}|".blue
        str4 = "|#{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]}|".blue
        str5 = "|#{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]}|".blue
        str6 = " --------- ".blue

        pArr[0][cardCount] = str0
        pArr[1][cardCount] = str1
        pArr[2][cardCount] = str2
        pArr[3][cardCount] = str3
        pArr[4][cardCount] = str4
        pArr[5][cardCount] = str5
        pArr[6][cardCount] = str6

        cardCount += 1

        end 
        if (color == "red")
        str0 = " --------- ".red
        str1 = "|#{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]}|".red
        str2 = "|#{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]}|".red
        str3 = "|#{shapes[shapeIdx].at(number-1)}|".red
        str4 = "|#{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]}|".red
        str5 = "|#{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]} #{shading[shadeIdx]}|".red
        str6 = " --------- ".red

        pArr[0][cardCount] = str0
        pArr[1][cardCount] = str1
        pArr[2][cardCount] = str2
        pArr[3][cardCount] = str3
        pArr[4][cardCount] = str4
        pArr[5][cardCount] = str5
        pArr[6][cardCount] = str6

        cardCount += 1

        end
        
        #print out first six
        if(cardCount == 6 && counter < 1)
            counter += 1
            firstSix.replace(pArr)
            puts "\n"
            print "     "
            #print ids
            cardIds.each do |c|
                print c 
                #for even spacing if card ids are 1 digit or two
                if c.digits.count == 1
                    print " "
                end
                print "          "
            end
            #clear array for the next 6
            cardIds.clear
            puts " "
            #print 6 cards 
            firstSix.each do |r|
                puts r.each { |p| p }.join(" ")
            end
            cardCount = 0
        end

    end

    #print out last 6
    pArr.each do |x|
        puts x.each { |y| y }.join(" ")
    end
    print "     "
    cardIds.each do |c|
        print c 
        if c.digits.count == 1
            print " "
        end
        print "          "
    end
    puts "\n"
    puts "\n"
end

end 