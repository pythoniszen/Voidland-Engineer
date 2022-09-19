require "main"
require "helpers"
require "user"

-- Similar to "enemy" but with a few changes
Boss = Entity:extend()
imgM = love.graphics.newImage("/art/enemy1.png")
bossJumpImg = love.graphics.newImage("/art/bossjump.png")

function Boss:new(x, y, boundLeft, boundRight, floor)
    -- Loads properties and variables
    self.image = bossImage
    self.imageMain = bossImage
    self.speed = 120
    self.x = x
    self.y = y
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.last = {}
    self.last.x = self.x
    self.last.y = self.y
    self.gravity = 500
    self.weight = 800
    self.loop = false
    self.eMove = false
    self.boundaryLeft = boundLeft
    self.boundaryRight = boundRight
    self.floorVal = floor
    self.eAlive = true
    self.eLeft = true
    self.bounceBool = true
    self.currentFrame = 1
    self.falling = false
    self.hits = 0
    self.lastHit = 0
    jumpHitFloor = true
    jumpHitTop = false
end

function Boss:update(dt)
    self.lastHit = self.hits
    
    if self.eAlive == true then
        self.bounceBool = true
    end
    
    if self.hits >= 54 then
        self.eAlive = false
        self.bounceBool = false
    end
    if self.bounceBool == true and hitDetect(user, self) and user.y < self.y then
          
          invincible = true
          if love.keyboard.isDown("space") then
              user.gravity = -520
              self.bounceBool = false
              self.gravity = 500
          else
              user.gravity = -200
              self.bounceBool = false
              self.gravity = 500
          end
          bossTimer2:after(0.5, function() user:invincibleEnd() end)
      end
    
    if self.x > self.boundaryRight then
        self.eLeft = true
    elseif self.x < self.boundaryLeft then
        self.eLeft = false
    end
    
    if self.eLeft == true then
        self.x = self.x - (self.speed * dt)
    elseif self.eLeft == false then
        self.x = self.x + (self.speed * dt)
    end
    
    if self.y < self.floorVal and bJumpBool == false then
        self.gravity = self.gravity + self.weight * dt
    end
    
    self.y = self.y + self.gravity * dt
    
    if self.y > self.floorVal and self.eAlive == true then
        self.y = self.floorVal
    end
    if self.eAlive == false then
        self.gravity = self.gravity + self.weight * dt
        self.y = self.y + (self.gravity - 200) * dt
    end
end

function Boss:movement(dt)
    self.speed = 400
    bossTimer3:after(2, function() self:endSpeed() end)
end

function Boss:endSpeed(dt)
    self.speed = 120
end

function Boss:jump(dt)
    if self.eAlive == true then
        bJumpBool = true
        self.gravity = -420
        bossTimer2:after(0.2, function() self:endJump() end)
        self.image = bossJumpImg
    end
end

function Boss:endJump()
    bJumpBool = false
    self.image = bossImage
end

function Boss:draw()
    love.graphics.draw(self.image, self.x, self.y)
end
  
  