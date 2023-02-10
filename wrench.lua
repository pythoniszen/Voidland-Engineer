require "main"

-- Class for walls in game world
Wrench = Entity:extend()
wrenchImage = love.graphics.newImage("/art/wrench.png")

function Wrench:new(x, y)
    Wrench.super.new(self, x, y, "/art/wrench.png")
    
    -- Properties
    self.strength = 100
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.weight = 0
    self.strength = 100
    self.alive = true
    self.image = wrenchImage
    self.loop = true
    self.x = self.x + 15
end

function Wrench:update(dt)
    -- Keeps track of projectile stock
    if self.alive == false and self.loop == true then
        pStock = pStock + 1
        self.loop = false
    end
end

function Wrench:draw(x, y)
    if self.alive == true then
        love.graphics.draw(self.image, self.x + 15, self.y + 10)
    end
end