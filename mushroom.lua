require "main"

-- Class for walls in game world
Mushroom = Entity:extend()
mushroomImage = love.graphics.newImage("/art/mushroom.png")

function Mushroom:new(x, y)
    Mushroom.super.new(self, x, y, "/art/mushroom.png")
    
    -- Properties
    self.strength = 100
    self.width = self.image:getWidth() 
    self.height = self.image:getHeight()
    self.weight = 0
    self.strength = 100
    self.alive = true
    self.image = mushroomImage
    self.loop = true
end

function Mushroom:update(dt)
    -- Keeps track of mushroom count
    if self.alive == false and self.loop == true then
        mushroomCount = mushroomCount + 1
        self.loop = false
    end
end

function Mushroom:draw(x, y)
    if self.alive == true and gameLevel ~= 3.5 then
        love.graphics.draw(self.image, self.x, self.y + 10)
    elseif self.alive == true and gameLevel == 3.5 then
        love.graphics.draw(self.image, self.x + 10, self.y + 10)
    end
end