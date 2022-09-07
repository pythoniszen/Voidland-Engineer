require "main"

Button = Object:extend()

function Button:new(x, y, imageVar)
    self.image = imageVar
    self.x = x
    self.y = y
    self.height = love.graphics.getHeight(self.image)
    self.width = love.graphics.getWidth(self.image)
end

function Button:update(dt)
    mouse.x, mouse.y = love.mouse.getPosition()
end
