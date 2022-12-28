require "main"
require "helpers"
require "user"

Boss = Entity:extend()
imgM = love.graphics.newImage("/art/enemy1.png")
bossJumpImg = love.graphics.newImage("/art/bossjump.png")
bossHitImage = love.graphics.newImage("/art/bosshit.png")
bossRunLeftImage = love.graphics.newImage("/art/bossrunleft.png")

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
    userHitBoss = false
    bossGroundBool = true
    bossHitFx = love.audio.newSource("/vleaudiofx/boss-hit.ogg", "stream")
    bossDieFx = love.audio.newSource("/vleaudiofx/boss-die.ogg", "stream")
end

function Boss:update(dt)
    
    -- Keeps track of position
    if self.y >= 760 then
        bossGroundBool = true
    else
        bossGroundBool = false
    end
    
    -- Allows user to bounce
    if self.eAlive == true then
        self.bounceBool = true
    end
  
    -- Helps keep track of hitpoints
    if self.hits > self.lastHit + 1 then
        self.hits = self.lastHit + 1
    end
    
    self.lastHit = self.hits

    if self.hits >= 12 then
        love.audio.stop(bossHitFx)
        bossDieFx:setLooping(false)
        bossDieFx:play()
        self.eAlive = false
        self.image = bossHitImage
        self.hits = 0
    end
    
    -- Determines animation speed
    if self.speed ~= 400 then
        self.currentFrame = self.currentFrame + 2 * dt
    elseif self.speed == 400 then
        self.currentFrame = self.currentFrame + 6 * dt
    end
    if self.currentFrame >= 3 then
        self.currentFrame = 1
    end
    
    -- Collision detection with user
    if self.bounceBool == true and hitDetect(user, self) and (user.y >= user.last.y or bJumpBool == true) and invincible == false then
        bJumpBool = false
        if love.keyboard.isDown("space") then
            self.bounceBool = false
            if self.bounceBool == false and (userHitBoss == true or bJumpBool == true) then
                invincible = true
                self.image = bossHitImage
                if self.hits == self.lastHit then
                    self.hits = self.hits + 1
                end
                userHitBoss = false
                if self.hits > self.lastHit + 1 then
                    self.hits = self.lastHit + 1
                end
                bossTimer4:after(0.5, function() self:hitAnimationEnd() end)
            end
            user.gravity = -520
            self.gravity = 500
            invincible = false
            love.audio.stop(bossHitFx)
            bossHitFx:setLooping(false)
            bossHitFx:setVolume(0.6)
            bossHitFx:play()
            return
        else
            self.bounceBool = false
            if self.bounceBool == false and (userHitBoss == true or bJumpBool == true) then
                invincible = true
                self.image = bossHitImage
                if self.hits == self.lastHit then
                    self.hits = self.hits + 1
                end
                userHitBoss = false
                if self.hits > self.lastHit + 1 then
                    self.hits = self.lastHit + 1
                end
                bossTimer4:after(0.5, function() self:hitAnimationEnd() end)
            end
            invincible = false
            user.gravity = -200
            self.gravity = 500
            love.audio.stop(bossHitFx)
            bossHitFx:setLooping(false)
            bossHitFx:setVolume(0.6)
            bossHitFx:play()
            return
        end
        
        if user.eating == false and invincible == true then
            bossTimer2:after(0.1, function() user:invincibleEnd() end)
        end
        
        self.bounceBool = true

    elseif hitDetect(user, self) and invincible == false and user.y >= self.y then
        alive = false
    end
    
    -- Boss movement
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

function Boss:hitAnimationEnd()
    self.image = bossImage
end

function Boss:movement(dt)
    self.speed = 400
    bossTimer3:after(2, function() self:endSpeed() end)
end

function Boss:endSpeed(dt)
    self.speed = 120
end

function Boss:jump(dt)
    bossGroundBool = false
    if self.eAlive == true then
        bJumpBool = true
        -- Makes boss fall to ground level when user collides
        if hitDetect(user, self) then
            self.gravity = 500
        else
            self.gravity = -420
        end
        bossTimer2:after(0.2, function() self:endJump() end)
        self.image = bossJumpImg
    end
end

function Boss:endJump()
    bJumpBool = false
    self.image = bossImage
end

function Boss:draw()
    --Draws boss spritesheet
    if self.image ~= bossJumpImg and self.image ~= bossHitImage and bossGroundBool == true then
        love.graphics.draw(bossRunLeftImage, bossFramesLeft[math.floor(self.currentFrame)], self.x, self.y + 10)
    else
        love.graphics.draw(self.image, self.x, self.y)
    end
end
  
  