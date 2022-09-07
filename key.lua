require "main"

-- Class for walls in game world
Key = Entity:extend()
keyImage = love.graphics.newImage("/art/key.png")

function Key:new(x, y)
    Key.super.new(self, x, y, "/art/key.png")
    
    -- Properties
    self.strength = 100
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.weight = 0
    self.strength = 100
    self.alive = true
    self.image = keyImage
    self.loop = true
    self.x = self.x + 20
end

function Key:update(dt)
    
    if self.alive == false and self.loop == true then
        hasKey = true
        self.loop = false
    end
end

function Key:draw(x, y)
    if self.alive == true then
        love.graphics.draw(keyImage, self.x + 2, self.y)
    end
end