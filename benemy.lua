require "main"
require "helpers"

-- Similar to "enemy" class but with a few changes
BEnemyClass = Entity:extend()
bFallL = love.graphics.newImage("/art/benemyfallleft.png")
bFallR = love.graphics.newImage("/art/benemyfallright.png")
imgB = love.graphics.newImage("/art/benemyleft.png")

function BEnemyClass:new(x, y, boundLeft, boundRight)
    -- Loads properties and variables
    self.image = love.graphics.newImage("/art/benemyleft.png")
    self.speed = 280
    self.imageMain = imgB
    self.x = x
    self.y = y
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.last = {}
    self.last.x = self.x
    self.last.y = self.y
    self.gravity = 0
    self.weight = 470
    self.loop = false
    self.eMove = false
    self.boundaryLeft = boundLeft
    self.boundaryRight = boundRight
    self.eAlive = true
    self.eLeft = true
    self.bounceBool = true
    self.currentFrame = 1
    self.enemyDieFx = love.audio.newSource("/vleaudiofx/enemy2die.ogg", "stream")
end

function BEnemyClass:update(dt)
    self.enemyDieFx:setVolume(0.8)
  
    -- Helps user perfom a 'super jump'
    if self.eAlive == false and self.bounceBool == true then
        if love.keyboard.isDown("space") then
            user.gravity = -520
            self.bounceBool = false
        else
            user.gravity = -200
            self.bounceBool = false
        end
    end
  
    -- Animation and movement code
    if self.eAlive == true then
        self.eMove = false
        self.last.x = self.x
        self.last.y = self.y
        self.currentFrame = self.currentFrame + 20 * dt
    
        if self.currentFrame >= 5 then
            self.currentFrame = 1
        end

        if self.loop == true then
            self.eMove = true
            if self.eLeft == true then
                self.x = self.x - ((self.speed) * dt)
            elseif self.eLeft == false then
                self.x = self.x + ((self.speed) * dt)
            end
        end
        
    -- Checks if enemy is currently alive and drop from screen if it's not
    elseif start == true and self.eAlive == false then
        self.gravity = self.gravity + self.weight * dt
        self.y = self.y + (self.gravity + 400) * dt
    end
    
    -- Determines direction
    if self.eLeft == true and self.eAlive == true then
        self.image = bEnemyFlyLeft
    elseif self.eLeft == false and self.eAlive == true then
        self.image = bEnemyFlyRight
    end
end

-- Movement funtion for enemy including direction change and bounce
function BEnemyClass:movement()
    if self.x < self.boundaryRight and self.x > self.boundaryLeft then
        self.eLeft = true
    elseif self.x > self.boundaryRight then
        self.eLeft = true
    elseif self.x < self.boundaryLeft then
        self.eLeft = false
    end
    
    if self.eLeft == true and self.eAlive == true then
        self.currentFrame = 1
    elseif self.eLeft == false then
        self.currentFrame = 1
    end
    
    if self.loop == true then
        self.loop = false
    elseif self.loop == false then
        self.loop = true
    end
end


function BEnemyClass:draw()
    -- Draws the spritesheet
    if self.eLeft == true and self.eAlive == true then
        love.graphics.draw(bEnemyFlyLeft, bEFrames[math.floor(self.currentFrame)], self.x + 6, self.y + 12)
    elseif self.eLeft == false and self.eAlive == true then
        love.graphics.draw(bEnemyFlyRight, bEFrames[math.floor(self.currentFrame)], self.x + 12, self.y + 12)
    
        -- Ensures that enemy is facing the right direction while falling
    elseif self.eAlive == false and self.image == bEnemyFlyRight then
        love.graphics.draw(bFallR, self.x + 6, self.y + 12)
    elseif self.eAlive == false and self.image == bEnemyFlyLeft then
        love.graphics.draw(bFallL, self.x + 12, self.y + 12)
    end
end
