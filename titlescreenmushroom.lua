require "main"
require "helpers"
require "user"

-- Similar to "enemy" but with a few changes
TitleScreenM = Entity:extend()
imgM = love.graphics.newImage("/art/enemy1.png")
enemyFaceL = love.graphics.newImage("/art/enemy1.png")
enemyFaceR = love.graphics.newImage("/art/enemy1right.png")
enemyDropL = love.graphics.newImage("/art/enemydropleft.png")
enemyDropR = love.graphics.newImage("/art/enemydropright.png")

function TitleScreenM:new(x, y, boundLeft, boundRight, floor)
    -- Loads properties and variables
    self.image = love.graphics.newImage("/art/enemy1.png")
    self.imageMain = imgM
    self.speed = 145
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
    self.floorVal = floor
    self.eAlive = true
    self.eLeft = true
    self.bounceBool = true
    self.currentFrame = 1
    self.startBool = true

end

function TitleScreenM:update(dt)
    if self.x < -60 then
        self.x = 890
    end
    if self.eAlive == false and self.bounceBool == true then
          if love.keyboard.isDown("space") then
              user.gravity = -520
              self.bounceBool = false
          else
              user.gravity = -200
              self.bounceBool = false
          end
      end
    if self.eAlive == true then
        self.eMove = false
        self.last.x = self.x
        self.last.y = self.y
        self.currentFrame = self.currentFrame + 5.8 * dt
        if self.currentFrame >= 5 then
            self.currentFrame = 1
        end
      
        -- Enemy direction change and jump mechanic
        if self.loop == true then
            self.eMove = true
            self.y = self.y - (self.speed * dt)
            if self.eLeft == true then
                self.x = self.x - ((self.speed) * dt)
            elseif self.eLeft == false then
                self.x = self.x + ((self.speed) * dt)
            end
        end
        
        -- Enemy gravity
        if self.y < self.floorVal then
            self.gravity = self.gravity + self.weight * dt
            self.y = self.y + self.gravity * dt
        else
            self.gravity = -10
        end
    -- Checks if enemy is currently alive and drop from screen if its not
    elseif start == true and self.eAlive == false then
        self.gravity = self.gravity + self.weight * dt
        self.y = self.y + (self.gravity + 400) * dt
    end
end

-- Movement funtion for enemy including direction change and bounce
function TitleScreenM:movement()
    -- Movement
    if self.x < self.boundaryRight and self.x > self.boundaryLeft then
        self.eLeft = true
    else
        self.eLeft = false
    end
    if self.eLeft == true and self.eMove == true and self.eAlive == false then
        self.image = enemyFaceR
        self.currentFrame = 1
    elseif self.eLeft == true and self.eMove == false then
        self.image = enemyFaceL
        self.currentFrame = 1
    elseif self.eLeft == false and self.eMove == true and self.eAlive == false then
        self.image = enemyFaceL
        self.currentFrame = 1
    elseif self.eLeft == false and self.eMove == false then
        self.image = enemyFaceR
        self.currentFrame = 1
    end
    
    if self.loop == true then
        self.loop = false
    elseif self.loop == false then
        self.loop = true
    end
end


function TitleScreenM:draw()
    if start == false then
        if self.loop == true and self.eLeft == true and self.eAlive == true then
            love.graphics.draw(enemyJumpImage, eFrames[math.floor(self.currentFrame)], self.x + 6, self.y + 12)
        elseif self.loop == true and self.eLeft == false and self.eAlive == true then
            love.graphics.draw(enemyJumpImageRight, eFrames[math.floor(self.currentFrame)], self.x + 12, self.y + 12)
        elseif self.eAlive == false and self.eLeft == true and eMove == false then
            love.graphics.draw(enemyDropR, self.x, self.y)
        elseif self.eAlive == false and self.eLeft == false and eMove == false then
            love.graphics.draw(enemyDropL, self.x, self.y)
        
        -- Ensures that enemy is facing the right direction while falling
        elseif self.eAlive == false and self.eLeft == false and eMove == true then
            love.graphics.draw(enemyDropR, self.x, self.y)
        elseif self.eAlive == false and self.eLeft == true and eMove == true then
            love.graphics.draw(enemyDropL, self.x, self.y)
        else
            love.graphics.draw(self.image, self.x, self.y)
        end
    end
end
