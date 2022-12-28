require "main"
require "user"

-- Class for walls in game world
Wall = Entity:extend()

function Wall:new(x, y)
    Wall.super.new(self, x, y, "/art/wall.png")
    
    -- Changes wall skin from base skin
    if brickWall == true then
        Wall.super.new(self, x, y, "/art/wallbrick.png")
    elseif grassBlock1 == true then
        Wall.super.new(self, x, y, "/art/grassnodirt.png")
    elseif grassBlock2 == true then
        Wall.super.new(self, x, y, "/art/grassnodirtnotop.png")
    elseif grassBlock3 == true then
        Wall.super.new(self, x, y, "/art/grassdirtnotop.png")
    elseif dirtBlock == true then
        Wall.super.new(self, x, y, "/art/dirt.png")
    elseif metalBrick == true then
        Wall.super.new(self, x, y, "/art/metalbrick.png")
    end
    
    -- Properties
    self.strength = 100
    self.width = self.image:getWidth() - 40
    self.height = self.image:getHeight() - 40
    self.weight = 0
    self.alive = true
end
