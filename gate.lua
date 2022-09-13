require "main"
require "user"

-- Class for walls in game world
Gate = Entity:extend()
gateImage = love.graphics.newImage("/art/gate.png")

function Gate:new(x, y)
    Gate.super.new(self, x, y, "/art/gate.png")
    -- Properties
    self.strength = 100
    self.width = self.image:getWidth() - 40
    self.height = self.image:getHeight() - 40
    self.weight = 0
    self.image = gateImage
    self.x = x
    self.y = y
    self.alive = true
end

--function Gate:update(dt)
--    if self.alive == false then
--        self.y = self.y + 10000
--    end
--end
