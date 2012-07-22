puts "12meses12katas: Abril-Bowling"

# --------------------------------------------------------------------- Classes

class Game 

    def initialize rolls
        puts "Initializing game with rolls = " + rolls + "."
        
        @score = 0
        @frames = []  
        @extraRolls = []
        
        setFrames rolls  
    end

    def calcGameScore
      @frames.each_with_index do |frameRolls, frameIndex|      
        @score += calcFrameScore frameRolls, frameIndex
      end
      
      @score      
    end
    
    private
  
    #  "private" means that the methods defined here are
    #  methods internal to the object.
    
    def setFrames rolls        
        frame = ""        
        rolls.each_char do |c|        
            if @frames.length < 10 # Regular rolls
              frame += c    
              if frame.length == 2 or frame == "X"
                  @frames.push frame        
                  frame = ""
              end
            else # Extra rolls
              @extraRolls.push c
            end
        end

        puts "Regular rolls = " + @frames.to_s + ". Extra rolls = " + @extraRolls.to_s
    end    
    
    def calcFrameScore frameRolls, frameIndex      
      frameScore = 0
      frameRolls.each_char do |c|
      if c == "-"
          frameScore += 0
        elsif c == "/"
         frameScore = calcSpareScore frameIndex
        elsif c == "X"
          frameScore = calcStrikeScore frameIndex
        elsif 
          frameScore += c.to_i
        end        
      end
      
      frameScore  
    end
    
    def calcSpareScore frameIndex
      score = 10 + (getNextRollPinsDown frameIndex + 1)
    end
    
    def calcStrikeScore frameIndex
      score = 10 + (getNextTwoRollsPinsDown frameIndex + 1)
    end
    
    def getNextRollPinsDown fromFrameIndex
      if fromFrameIndex < @frames.length
        frame = @frames[fromFrameIndex]
        pinsDown = pinsDownToInt frame[0].to_s
      else
        pinsDown = pinsDownToInt @extraRolls[0].to_s
      end
      
      pinsDown    
    end
    
    def getNextTwoRollsPinsDown fromFrameIndex
      if fromFrameIndex < @frames.length
        frame = @frames[fromFrameIndex]
        if frame.length == 2
          if frame[1] == "/" # Spare
            pinsDown = 10
          else
            pinsDown = (pinsDownToInt frame[0]) + (pinsDownToInt frame[1])   
          end          
        else
          pinsDown = (pinsDownToInt frame[0]) + (getNextRollPinsDown fromFrameIndex + 1)
        end
      else
        pinsDown = (pinsDownToInt @extraRolls[0]) + (pinsDownToInt @extraRolls[1])
      end
        
      pinsDown
    end
    
    def pinsDownToInt pinsDown
      if pinsDown == "-"
          value = 0
      elsif pinsDown == "X"
          value = 10
      else
          value = pinsDown.to_i
      end
      
      value
    end
    
end

# ------------------------------------------------------------------------ Main


gameRolls = "X23--4--6X5/23"
game = Game.new gameRolls
puts "For '" + gameRolls + "' the score is " + game.calcGameScore.to_s #67

gameRolls = "XXXXXXXXXXXX"
game = Game.new gameRolls
puts "For '" + gameRolls + "' the score is " + game.calcGameScore.to_s #300

gameRolls = "9-9-9-9-9-9-9-9-9-9-"
game = Game.new gameRolls
puts "For '" + gameRolls + "' the score is " + game.calcGameScore.to_s #90

gameRolls = "5/5/5/5/5/5/5/5/5/5/5"
game = Game.new gameRolls
puts "For '" + gameRolls + "' the score is " + game.calcGameScore.to_s #150

gameRolls = "23232323232323232/5/X"
game = Game.new gameRolls
puts "For '" + gameRolls + "' the score is " + game.calcGameScore.to_s # 75