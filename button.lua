require "main"

Button = Object:extend()
controlsButtonImage = love.graphics.newImage("/art/controlsbutton.png")
controlsButtonImage2 = love.graphics.newImage("/art/controlsbutton2.png")
storyButtonImage = love.graphics.newImage("/art/storybutton.png")
storyButtonImage2 = love.graphics.newImage("/art/storybutton2.png")

function Button:new(x, y, imageVar)
    self.image = imageVar
    self.x = x
    self.y = y
    self.height = love.graphics.getHeight(self.image)
    self.width = love.graphics.getWidth(self.image)
end

function Button:update(dt)
    -- Gets the x and y position of the mouse
    mouse.x, mouse.y = love.mouse.getPosition()
end

function Button:draw()
    if start == false then
        love.graphics.draw(self.image, self.x, self.y, 0, 0.2, 0.2)
    end
end