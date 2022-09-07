require "main"
require "user"
require "helpers"
require "benemy"

-- Class for wrench items which are thrown to the right
Projectile = Object:extend()

function Projectile:new(x, y)
  
  -- Properties
    self.image = love.graphics.newImage("/art/wrench.png")
    self.x = x + 100
    self.y = y + 70
    self.speed = 600
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.gravity = 200
    self.weight = 100
end

function Projectile:update(dt)
    for i,v in ipairs(walls) do
        if self:checkCollision(v) then
            if self.y < 2000 then
                while self.y < 2000 do
                    self.y = self.y + self.gravity * dt
                end
            end
        end
    end

    -- Enemies
    for i,enemy in ipairs(enemiesList) do
        if self:checkCollision(enemy) then
            enemy.eAlive = false
            enemy.bounceBool = false
            if self.y < 2000 then
                while self.y < 2000 do
                    self.y = self.y + self.gravity * dt
                end
            end
        end
    end
    
    for i,enemy in ipairs(enemiesList2) do
        if self:checkCollision(enemy) then
            enemy.eAlive = false
            enemy.bounceBool = false
            if self.y < 2000 then
                while self.y < 2000 do
                    self.y = self.y + self.gravity * dt
                end
            end
        end
    end

    self.x = self.x + self.speed * dt
    
    
end

function Projectile:draw()
    --if enemyAlive == false then
        --love.graphics.draw(self.image, self.x, self.y)
    --elseif enemy2Alive == false then
        --love.graphics.draw(self.image, self.x, self.y)
    --else
        love.graphics.draw(wrench_spin, spin_frames[math.floor(wrenchCurrentFrame)], self.x, self.y)
    --end
end

function Projectile:checkCollision(e)
    return self.x + self.width > e.x + 20
    and self.x < e.x + e.width + 42
    and self.y + self.height > e.y
    and self.y < e.y + e.height + 20
end