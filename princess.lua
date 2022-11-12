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

function Princess:new(x)
    -- Properties
    self.image = princessImage
    self.strength = 100
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.weight = 0
    self.speed = 180
    self.currentFrame = 1
    self.lastX = self.x
    kissBool = false
    walkOutBool = false
    
    self.x = 1200
    self.y = 480
end

function Princess:update(dt)
    self.lastX = self.x
    self.y = user.y + 45
    
    self.currentFrame = self.currentFrame + 15 * dt
    if self.currentFrame >= 4 then
        self.currentFrame = 1
    end
        
    if endBool == true and endRunBool == true and walkOutBool == false then
        if self.x > 790 then
            self.x = self.x - self.speed * dt
        elseif self.x <= 790 then
            self.x = self.lastX
            actionTimer:after(2, function() self:action(dt) end)
        end
    elseif walkOutBool == true then
        self.image = princessImageRight
        self.x = self.x + self.speed * dt
    end
end

function Princess:draw()
    love.graphics.draw(self.image, self.x, self.y)
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
end