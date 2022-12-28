require "main"
require "user"
Timer = require "chrono-master.chrono-master.Timer"

actionTimer = Timer()
kissEndTimer = Timer()
walkOutTimer = Timer()
faceRightTimer = Timer()

Princess = Entity:extend()
princessImage = love.graphics.newImage("/art/princessstand.png")
princessImageRight = love.graphics.newImage("/art/princessright.png")
princessKissImage = love.graphics.newImage("/art/princesskiss.png")
princessRunLeftImage = love.graphics.newImage("/art/princessrunsheet.png")
princessRunRightImage = love.graphics.newImage("/art/princessrunsheetright.png")

function Princess:new(x)
    -- Properties
    self.image = princessRunLeftImage
    self.strength = 100
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.weight = 0
    self.speed = 180
    self.currentFrame = 1
    self.lastX = self.x
    kissBool = false
    walkOutBool = false
    self.heartCurrentFrame = 1
    self.currentFrame = 1
    self.x = 1200
    self.y = 480
end

function Princess:update(dt)
    self.lastX = self.x
    self.y = user.y + 45
    
    -- Animates the princess who appears during the end game animation.
    self.currentFrame = self.currentFrame + 5 * dt
    if self.currentFrame >= 3 then
        self.currentFrame = 1
    end
        
    if endBool == true and endRunBool == true and walkOutBool == false then
        if self.x > 790 then
            self.x = self.x - self.speed * dt
        elseif self.x <= 790 then
            if self.image ~= princessKissImage and self.image ~= princessImage and self.image ~= princessImageRight and self.image ~= princessRunRightImage then
                self.image = princessImage
            end
            self.x = self.lastX
            actionTimer:after(2, function() self:action(dt) end)
        end
    elseif walkOutBool == true then
        self.image = princessRunRightImage
        self.x = self.x + self.speed * dt
    end
    
    if endBool == true and walkOutBool == false and kissBool == true then
        self.heartCurrentFrame = self.heartCurrentFrame + 3 * dt
        if self.heartCurrentFrame >= 4 then
            self.heartCurrentFrame = 1
        end
    end
    
end

function Princess:draw()
    if self.image == princessRunLeftImage and self.x ~= self.lastX and walkOutBool == false then
        love.graphics.draw(self.image, princessFramesLeft[math.floor(self.currentFrame)], self.x, self.y + 1)
    elseif walkOutBool == true then
        love.graphics.draw(self.image, princessFramesLeft[math.floor(self.currentFrame)], self.x, self.y + 1)
    else
        love.graphics.draw(self.image, self.x, self.y)
    end
    
    if endBool == true and walkOutBool == false and kissBool == true then
        love.graphics.draw(heartImg, heartFrames[math.floor(self.heartCurrentFrame)], self.x - 20, self.y, 0, 0.5, 0.5)
    end
end

function Princess:action(dt)
    if kissBool == false then
        self.image = princessKissImage
        self.x = self.x - 20 * dt
        kissEndTimer:after(0.5, function() self:kissEnd() end)
    end
end

function Princess:kissEnd()
    if walkOutBool == false then
        self.image = princessImage
        kissBool = true
        faceRightTimer:after(1, function() self:faceRight() end)
    end
end

function Princess:faceRight()
    self.image = princessImageRight
    walkOutTimer:after(1, function() self:walkOut() end)
end

function Princess:walkOut()
    walkOutBool = true
    self.image = princessRunRightImage
end