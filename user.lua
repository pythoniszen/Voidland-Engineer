
require "main"
require "entity"
require "helpers"

dashTimer = Timer()
cooldownTimer = Timer()
invincibleTimer = Timer()
User = Entity:extend()

function User:new(x, y)
    -- Loads properties and variables
    User.super.new(self, x, y, "/art/engineerstand.png")
    throw_img = love.graphics.newImage("/art/engineerthrow.png")
    throw_img_left = love.graphics.newImage("/art/engineerthrowleft.png")
    engineer_jump = love.graphics.newImage("/art/engineerjump.png")
    engineer_jump_left = love.graphics.newImage("/art/engineerjumpleft.png")
    dashImage = love.graphics.newImage("/art/dash.png")
    dashImageLeft = love.graphics.newImage("/art/dashleft.png")
    standImageLeft = love.graphics.newImage("/art/engineerstandleft.png")
    standImageRight = love.graphics.newImage("/art/engineerstand.png")
    self.speed = 280
    self.width = self.image:getWidth() - 60
    self.height = self.image:getHeight() - 40
    self.strength = 10
    self.weight = 550
    self.state = "standing"
    jumpBool = true
    user_left = false
    cooldown = false
    isDashing = false
    dashBool = true
    --Bool vals for enemy head bounce
    bounceBool = true
    bounceBool2 = true
    bounceBool3 = true
    bounceBool4 = true
    jumpBool2 = true
    invincible = false
    self.eating = false
    self.jumpFx = love.audio.newSource("/vleaudiofx/jump.ogg", "stream")
    self.dashFx = love.audio.newSource("/vleaudiofx/dash.ogg", "stream")
    self.eatFx = love.audio.newSource("/vleaudiofx/eat.ogg", "stream")
    self.projectileFx = love.audio.newSource("/vleaudiofx/wrench-throw.ogg", "stream")
end

function User:update(dt)
  
    User.super.update(self, dt)
    
--    if jumpBool == true then
--        print("user x =".. user.x)
--        print("user y =".. user.y)
--    end
    
    if isDashing == true then
        dashTimer:after(0.15, function() self:cancelDash() end)
    end
    
-- Player movement/ physics
    if alive == true and start == true then
        
        -- Keeps track of last position for collision detect
        self.last.x = self.x
        self.last.y = self.y
        
        if wallHitBottom == true then
            onGround = true
        end
        if love.keyboard.isDown("d") then
            user_left = false
        elseif love.keyboard.isDown("a") then
            user_left = true
        end
        
        -- Collision detection with enemies
      if gameLevel == 1 then
          for i,enemy in ipairs(enemiesList) do
              if hitDetect(self, enemy) then
                  if invincible == true then
                      enemy.eAlive = true
                  elseif enemy.eAlive == false then
                      return
                  elseif invincible == false then
                      alive = false
                  end
              end
          end
      
      elseif gameLevel == 2.5 then
          for i,enemy in ipairs(enemiesList2) do
              if hitDetect(self, enemy) then
                  if invincible == true then
                      enemy.eAlive = true
                  elseif enemy.eAlive == false then
                      return
                  elseif invincible == false then
                      alive = false
                  end
              end
          end
      elseif gameLevel == 3.5 then
          for i,enemy in ipairs(enemiesList3) do
              if hitDetect(self, enemy) then
                  if invincible == true then
                      enemy.eAlive = true
                  elseif enemy.eAlive == false then
                      return
                  elseif invincible == false then
                      alive = false
                  end
              end
          end
          
          if hitDetect(self, boss) then
              boss.bounceBool = false
              if boss.bounceBool == false and self.y < 720 and invincible == false then
                  if love.keyboard.isDown("space") then
                      self.gravity = -520
                  else
                      self.gravity = -200
                  end
              elseif invincible == false and boss.eAlive == true and userHitBoss == false then
                  alive = false
              end
          end
      end
      
      if jumpBool == true then
          boss.bounceBool = true
      end
      
      -- enemies from classes head bounce
      for i,enemy in ipairs(enemiesList) do
          if enemy.eAlive == false and enemy.bounceBool == true then
              if love.keyboard.isDown("space") then
                  self.gravity = -520
                  enemy.bounceBool = false
              else
                  self.gravity = -200
                  enemy.bounceBool = false
              end
          end
      end
      
      for i,enemy in ipairs(enemiesList2) do
          if enemy.eAlive == false and enemy.bounceBool == true then
              if love.keyboard.isDown("space") then
                  self.gravity = -520
                  enemy.bounceBool = false
              else
                  self.gravity = -200
                  enemy.bounceBool = false
              end
          end
      end
      
      
      for i,enemy in ipairs(enemiesList3) do
          if enemy.eAlive == false and enemy.bounceBool == true then
              if love.keyboard.isDown("space") then
                  self.gravity = -520
                  enemy.bounceBool = false
              else
                  self.gravity = -200
                  enemy.bounceBool = false
              end
          end
      end
      
--      if boss.lastHit < boss.hits then
          
--      end
      
      -- Left and right player movement + dashing
      if love.keyboard.isDown("d") and isDashing == false then
          self.x = self.x + self.speed * dt
      elseif love.keyboard.isDown("a") and isDashing == false then
          self.x = self.x - self.speed * dt
      elseif isDashing == true and user_left == false then
          self.image = dashImage
          self.x = self.x + (self.speed + 600) * dt
      elseif isDashing == true and user_left == true then
          self.image = dashImageLeft
          self.x = self.x - (self.speed + 600) * dt

      end
      
      -- Keeps track of if player can jump (prevents infinite jumping)
      if self.last.y == self.y then
          jumpBool = false
      else
          jumpBool = true
      end
      
      -- User gravity
      self.gravity = self.gravity + self.weight * dt
          self.y = self.y + self.gravity * dt
  
  -- Prevents user from moving player character while either dead or
  -- While at title screen
  elseif alive == false or start == false then
      self.x = self.x
      self.y = self.y
  end
    
    -- Contains user in the game window
    local window_width = love.graphics.getWidth(myBackground)
    
    if self.x < 0 then
        self.x = 0
    elseif self.x > 6649 and bossBool == false then
        self.x = 6649
    end
    
    -- Running animation
    if love.keyboard.isDown("d")then
        currentFrame = currentFrame + 15 * dt
        if currentFrame >= 4 then
            currentFrame = 1
        end
    end
    if love.keyboard.isDown("a")then
        currentFrameLeft = currentFrameLeft + 15 * dt
        if currentFrameLeft >= 4 then
            currentFrameLeft = 1
        end
    end
    
    if drawLevel2Intro == true and drawLevel2Text == false then
        self.x = self.last.x
        self.y = self.last.y
        jumpBool = true
    -- places user at level2 start point    
    elseif drawLevel2Intro == true and drawLevel2Text == true then
        self.x = 60
        self.y = 830
        jumpBool = true
    end
    
    if drawLevel3Intro == true and drawLevel3Text == false then
        self.x = self.last.x
        self.y = self.last.y
        jumpBool = true
    -- places user at level3 start point    
    elseif drawLevel3Intro == true and drawLevel3Text == true then
        self.x = 60
        self.y = 830
        jumpBool = true
    end
end

-- Jump function
function User:jump()
    onGround = false
    love.audio.stop(self.jumpFx)
    self.jumpFx:setLooping(false)
    self.jumpFx:setVolume(0.4)
    self.jumpFx:play()
    if jumpBool == true then
        self.gravity = -420
    elseif wallHitBottom == true then
        jumpBool = false
    elseif isDashing == true and user_left == false then
        self.gravity = 0
        self.x = self.x + (self.speed + 800) * dt
    elseif isDashing == true and user_left == true then
        self.gravity = 0
        self.x = self.x - (self.speed + 800) * dt
    end
    wallHitBottom = false
end

-- Dash function

function User:dash()
    
    self.dashFx:setLooping(false)
    self.dashFx:setVolume(0.3)
    self.dashFx:play()
    if cooldown == false then
        isDashing = true
        cooldown = true
    end
end

function User:cancelDash()
    isDashing = false
    cooldownTimer:after(2, function() self:cooldownEnd() end)
end


function User:cooldownEnd()
    love.audio.stop(self.dashFx)
    cooldown = false
end

-- Eat funtion
function User:eat()
    love.audio.stop(self.eatFx)
    self.eatFx:setLooping(false)
    self.eatFx:setVolume(0.6)
    self.eatFx:play()
    if mushroomCount > 0 then
        self.eating = true
        if invincible == true then
            invincibleTimer:destroy()
        end
        mushroomCount = mushroomCount - 1
        invincible = true
        invincibleTimer:after(3, function() self:invincibleEnd() end)
    else
        mushroomCount = 0
    end
end

function User:invincibleEnd()
    invincible = false
    self.eating = false
end


function User:draw()
    -- Player movement
    if love.keyboard.isDown("d") and jumpBool == true and isDashing == false then
        love.graphics.draw(jump_img, frames[math.floor(currentFrame)], self.x + 45, self.y + 40)
    elseif love.keyboard.isDown("a") and jumpBool == true and isDashing == false then
        love.graphics.draw(jump_img_left, left_run_frames[math.floor(currentFrameLeft)], self.x + 55, self.y + 40)
    elseif gameLevel == 2 or gameLevel == 2.5 and drawLevel2Intro == true then
        love.graphics.draw(standImageRight, self.x, self.y)
    elseif onGround == false and jumpBool == false then
        if love.keyboard.isDown("d") or love.keyboard.isDown("lshift") and user_left == false then
            love.graphics.draw(engineer_jump, self.x, self.y)
        elseif love.keyboard.isDown("a") or love.keyboard.isDown("lshift") and user_left == true then
            love.graphics.draw(engineer_jump_left, self.x, self.y)
        else
            if user_left == true then
                love.graphics.draw(engineer_jump_left, self.x, self.y)
            elseif user_left == false then
                love.graphics.draw(engineer_jump, self.x, self.y)
            end
        end
        
    -- Projectile input
    elseif love.keyboard.isDown("k") and user_left == true and jumpBool == true then
        love.graphics.draw(throw_img_left, self.x, self.y)
    elseif love.keyboard.isDown("k") and user_left == false and jumpBool == true then
        love.graphics.draw(throw_img, self.x, self.y)
        
    -- Basic stance / dashing / jump
    elseif self.x ~= self.last.x then
        if user_left == false then
            love.graphics.draw(engineer_jump, self.x, self.y)
        else
            love.graphics.draw(engineer_jump_left, self.x, self.y)
        end
    elseif self.x == self.last.x then
        if user_left == false and jumpBool == true then
              love.graphics.draw(standImageRight, self.x, self.y)
        elseif user_left == true and jumpBool == true then
            love.graphics.draw(standImageLeft, self.x, self.y)
        end
    end
end

-- Function used for user projectile throw function
function User:keyInput(key)
    if key == "k" and user_left == true then
        if pStock > 0 then
            love.audio.stop(self.projectileFx)
            self.projectileFx:setLooping(false)
            self.projectileFx:setVolume(0.6)
            self.projectileFx:play()
            table.insert(leftProjectileList, Projectile_Left(self.x, self.y))
            pStock = pStock - 1
        end
    elseif key == "k" and user_left == false then
        if pStock > 0 then
            love.audio.stop(self.projectileFx)
            self.projectileFx:setLooping(false)
            self.projectileFx:setVolume(0.6)
            self.projectileFx:play()
            table.insert(projectileList, Projectile(self.x, self.y))
            pStock = pStock - 1
        end
    elseif key == "lshift" then
        self:dash()
    elseif key == "e" then
        self:eat()
    end
end

-- Level 2 transition functions
function User:level2(level)
    if level == 2 then
        gameLevel = 2.5
        hasKey = false
    end
end

function User:drawLevel2Text()
    drawLevel2Text = true
    level2ScreenEndTimer:after(2, function() self:endLevel2Screen() end)
end

function User:endLevel2Screen()
    drawLevel2Intro = false
end

-- Level 3 transition functions
function User:level3(level)
    if level == 3 then
        gameLevel = 3.5
        hasKey = false
    end
end

function User:drawLevel3Text()
    drawLevel3Text = true
    level3ScreenEndTimer:after(2, function() self:endLevel3Screen() end)
end

function User:endLevel3Screen()
    drawLevel3Intro = false
end