require "main"


-- Entity class which is used by various entities to create
-- A unique class for that entity appearing in the game world
-- Which uses this class as a template
Entity = Object:extend()

function Entity:new(x, y, img_path)
    -- Loads properties and variables
    self.x = x
    self.y = y
    self.image = love.graphics.newImage(img_path)
    self.last = {}
    self.last.x = self.x
    self.last.y = self.y
    self.strength = 0
    self.iStrength = 0
    self.gravity = 0
    self.weight = 400
end

function Entity:update(dt)
    -- Updates entity properties
    self.last.x = self.x
    self.last.y = self.y
    self.iStrength = self.strength
end

-- Functions which determine how an enity aligns with a different entity
-- (This is for collision detection, primarily between user and walls)
function Entity:alignedVertical(e)
    return self.last.y < e.last.y + e.height and self.last.y + self.height > e.last.y
end

function Entity:alignedHorizontal(e)
    return self.last.x < e.last.x + e.width and self.last.x + self.width > e.last.x
end

-- Resolves collision for entity
function Entity:resolveCollision(e)

    if self.iStrength > e.iStrength then
        return e:resolveCollision(self)
    end
    
    if self:checkCollision(e) then
        if self:alignedVertical(e) then
            if self.x + 30 + self.width/2 < e.x + e.width/2 then
                local pushback = self.x + self.width - e.x
                self.x = self.x - pushback
            else
                local pushback = e.x + e.width - self.x
                self.x = self.x + pushback
            end
        elseif self:alignedHorizontal(e) then
            if self.y + self.height/2 < e.y + e.height /2 then
                local pushback = self.y + self.height - e.y
                self.y = self.y - pushback
                wallHitBottom = true
                self.gravity = 0
                jumpBool = true
            else
                local pushback = e.y + e.height - self.y
                self.y = self.y + pushback
                jumpBool = false
                self.gravity = 0
            end
        end
        return true
    end
    return false
end

function Entity:draw()
  if self.strength == 100 then
      love.graphics.draw(self.image, self.x + 10, self.y)
  else
      love.graphics.draw(self.image, self.x, self.y)
  end
end

-- Function called to check if entity collides with entity
function Entity:checkCollision(e)
    return self.x + self.width > e.x
    and self.x < e.x + e.width
    and self.y + self.height > e.y
    and self.y < e.y + e.height
end
