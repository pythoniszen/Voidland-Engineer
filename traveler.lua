require "main"
require "user"

Traveler = Entity:extend()
travelerImage = love.graphics.newImage("/art/traveler.png")

function Traveler:new(x, y)
    -- Properties
    self.image = travelerImage
    self.strength = 100
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.weight = 0
    
    self.x = x
    self.y = y
    drawTravelerAlert = false
    travelerTalkBool = false
    travelerCounter = 0
end

function Traveler:update(dt)
    if user.x > 5738 and user.x < 5779 and user.y <= 85 and user_left == false and user.y > 70 and travelerTalkBool == false then
        drawTravelerAlert = true
        if love.keyboard.isDown("q") then
            travelerTalkBool = true
        end
    else
        drawTravelerAlert = false
    end
    
    if user.x > traveler.x then
        travelerTalkBool = false
        travelerCounter = 0
    end
    
    if travelerTalkBool == false then
        travelerCounter = 0
    end
    
    if user_left == true then
        travelerTalkBool = false
    end
    
    if travelerCounter >= 11 then
        travelerTalkBool = false
    end

end

function Traveler:draw()
    love.graphics.draw(self.image, self.x, self.y)
    
    if travelerTalkBool == true and travelerCounter <= 11 and user.x == user.last.x and user.x < traveler.x - 80 then
        
        if travelerCounter == 0 and user.x < self.x then
            love.graphics.draw(npcTalkImage, self.x - 160, self.y - 80)
            love.graphics.setColor(0, 0, 0)
            love.graphics.print("Traveler:", self.x - 150, self.y - 70, 0, 0.16, 0.16)
            love.graphics.print("Hello, there.", self.x - 150, self.y - 60, 0, 0.16, 0.16)
            love.graphics.print(" How did you find", self.x - 150, self.y - 50, 0, 0.16, 0.16)
            love.graphics.print(" me up here?", self.x - 150, self.y - 40, 0, 0.16, 0.16)
            love.graphics.print("(press 'q' to continue)", self.x - 150, self.y - 25, 0, 0.16, 0.16)
            love.graphics.setColor(r, g, b, a)
        elseif travelerCounter == 1 and user.x < self.x then
            love.graphics.draw(npcTalkImage, self.x - 160, self.y - 80)
            love.graphics.setColor(0, 0, 0)
            love.graphics.print("Traveler:", self.x - 150, self.y - 70, 0, 0.16, 0.16)
            love.graphics.print("I thought I was the", self.x - 150, self.y - 60, 0, 0.16, 0.16)
            love.graphics.print(" only one who knew", self.x - 150, self.y - 50, 0, 0.16, 0.16)
            love.graphics.print(" about this place.", self.x - 150, self.y - 40, 0, 0.16, 0.16)
            love.graphics.print("(press 'q' to continue)", self.x - 150, self.y - 25, 0, 0.16, 0.16)
            love.graphics.setColor(r, g, b, a)
        elseif travelerCounter == 2 and user.x < self.x then
            love.graphics.draw(npcTalkImage, self.x - 160, self.y - 80)
            love.graphics.setColor(0, 0, 0)
            love.graphics.print("Traveler:", self.x - 150, self.y - 70, 0, 0.16, 0.16)
            love.graphics.print("Anyway, I was just", self.x - 150, self.y - 60, 0, 0.16, 0.16)
            love.graphics.print(" thinking...", self.x - 150, self.y - 50, 0, 0.16, 0.16)
            love.graphics.print("(press 'q' to continue)", self.x - 150, self.y - 25, 0, 0.16, 0.16)
            love.graphics.setColor(r, g, b, a)
        elseif travelerCounter == 3 and user.x < self.x then
            love.graphics.draw(npcTalkImage, self.x - 160, self.y - 80)
            love.graphics.setColor(0, 0, 0)
            love.graphics.print("Traveler:", self.x - 150, self.y - 70, 0, 0.16, 0.16)
            love.graphics.print("Sometimes I wonder why", self.x - 150, self.y - 60, 0, 0.16, 0.16)
            love.graphics.print(" we harm the creatures", self.x - 150, self.y - 50, 0, 0.16, 0.16)
            love.graphics.print(" of Voidland.", self.x - 150, self.y - 40, 0, 0.16, 0.16)
            love.graphics.print("(press 'q' to continue)", self.x - 150, self.y - 25, 0, 0.16, 0.16)
            love.graphics.setColor(r, g, b, a)
        elseif travelerCounter == 4 and user.x < self.x then
            love.graphics.draw(npcTalkImage, self.x - 160, self.y - 80)
            love.graphics.setColor(0, 0, 0)
            love.graphics.print("Traveler:", self.x - 150, self.y - 70, 0, 0.16, 0.16)
            love.graphics.print("I mean, what did they", self.x - 150, self.y - 60, 0, 0.16, 0.16)
            love.graphics.print(" ever do to us anyway?!", self.x - 150, self.y - 50, 0, 0.16, 0.16)
            love.graphics.print("(press 'q' to continue)", self.x - 150, self.y - 25, 0, 0.16, 0.16)
            love.graphics.setColor(r, g, b, a)
        elseif travelerCounter == 5 and user.x < self.x then
            love.graphics.draw(npcTalkImage, self.x - 160, self.y - 80)
            love.graphics.setColor(0, 0, 0)
            love.graphics.print("Traveler:", self.x - 150, self.y - 70, 0, 0.16, 0.16)
            love.graphics.print("After all, we're the", self.x - 150, self.y - 60, 0, 0.16, 0.16)
            love.graphics.print(" ones who decided take", self.x - 150, self.y - 50, 0, 0.16, 0.16)
            love.graphics.print(" over their territory...", self.x - 150, self.y - 40, 0, 0.16, 0.16)
            love.graphics.print("(press 'q' to continue)", self.x - 150, self.y - 25, 0, 0.16, 0.16)
            love.graphics.setColor(r, g, b, a)
        elseif travelerCounter == 6 and user.x < self.x then
            love.graphics.draw(npcTalkImage, self.x - 160, self.y - 80)
            love.graphics.setColor(0, 0, 0)
            love.graphics.print("Traveler:", self.x - 150, self.y - 70, 0, 0.16, 0.16)
            love.graphics.print("So that we could", self.x - 150, self.y - 60, 0, 0.16, 0.16)
            love.graphics.print(" build our machines", self.x - 150, self.y - 50, 0, 0.16, 0.16)
            love.graphics.print(" and such.", self.x - 150, self.y - 40, 0, 0.16, 0.16)
            love.graphics.print("(press 'q' to continue)", self.x - 150, self.y - 25, 0, 0.16, 0.16)
            love.graphics.setColor(r, g, b, a)
        elseif travelerCounter == 7 and user.x < self.x then
            love.graphics.draw(npcTalkImage, self.x - 160, self.y - 80)
            love.graphics.setColor(0, 0, 0)
            love.graphics.print("Traveler:", self.x - 150, self.y - 70, 0, 0.16, 0.16)
            love.graphics.print("Thats why I like eating", self.x - 150, self.y - 60, 0, 0.16, 0.16)
            love.graphics.print(" these wild mushrooms.", self.x - 150, self.y - 50, 0, 0.16, 0.16)
            love.graphics.print("(press 'q' to continue)", self.x - 150, self.y - 25, 0, 0.16, 0.16)
            love.graphics.setColor(r, g, b, a)
        elseif travelerCounter == 8 and user.x < self.x then
            love.graphics.draw(npcTalkImage, self.x - 160, self.y - 80)
            love.graphics.setColor(0, 0, 0)
            love.graphics.print("Traveler:", self.x - 150, self.y - 70, 0, 0.16, 0.16)
            love.graphics.print("They seem to cause", self.x - 150, self.y - 60, 0, 0.16, 0.16)
            love.graphics.print(" one to harmonize with", self.x - 150, self.y - 50, 0, 0.16, 0.16)
            love.graphics.print(" the creatures.", self.x - 150, self.y - 40, 0, 0.16, 0.16)
            love.graphics.print("(press 'q' to continue)", self.x - 150, self.y - 25, 0, 0.16, 0.16)
            love.graphics.setColor(r, g, b, a)
        elseif travelerCounter == 9 and user.x < self.x then
            love.graphics.draw(npcTalkImage, self.x - 160, self.y - 80)
            love.graphics.setColor(0, 0, 0)
            love.graphics.print("Traveler:", self.x - 150, self.y - 70, 0, 0.16, 0.16)
            love.graphics.print("Maybe one day there", self.x - 150, self.y - 60, 0, 0.16, 0.16)
            love.graphics.print(" can be a better world.", self.x - 150, self.y - 50, 0, 0.16, 0.16)
            love.graphics.print("(press 'q' to continue)", self.x - 150, self.y - 25, 0, 0.16, 0.16)
            love.graphics.setColor(r, g, b, a)
        elseif travelerCounter == 10 and user.x < self.x then
            love.graphics.draw(npcTalkImage, self.x - 160, self.y - 80)
            love.graphics.setColor(0, 0, 0)
            love.graphics.print("Traveler:", self.x - 150, self.y - 70, 0, 0.16, 0.16)
            love.graphics.print("...", self.x - 150, self.y - 60, 0, 0.16, 0.16)
            love.graphics.setColor(r, g, b, a)
        end
    end
end