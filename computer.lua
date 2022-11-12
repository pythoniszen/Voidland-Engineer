require "main"
Timer = require "chrono-master.chrono-master.Timer"

endRunTimer = Timer()

-- Class for walls in game world
Computer = Entity:extend()
computerImage = love.graphics.newImage("/art/computer.png")

function Computer:new(x, y)
    Computer.super.new(self, x, y, "/art/computer.png")
    
    -- Properties
    self.strength = 100
    self.width = self.image:getWidth() 
    self.height = self.image:getHeight()
    self.weight = 0
    self.strength = 100
    self.alive = true
    self.image = computerImage
    self.x = 7710
    endBool = false
    endRunBool = false
end

function Computer:update(dt)
    if alive == true and boss.eAlive == false and user.x > 7649 and user .x < 7916 and user.y >= 780 and endBool == false then
        if love.keyboard.isDown("q") then
            endBool = true
        end
    end
end

function Computer:draw(x, y)
    if gameLevel == 3.5 and bossBool == true then
        love.graphics.draw(computerImage, 7710, 805)
    end
end

function Computer:endRun()
    endRunBool = true
end