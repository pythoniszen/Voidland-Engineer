require "main"

controlsButtonClass = Button:extend()
controlsButtonImage = love.graphics.newImage("/art/controlsbutton.png")
controlsButtonImage2 = love.graphics.newImage("/art/controlsbutton2.png")
storyButtonImage = love.graphics.newImage("/art/storybutton.png")
storyButtonImage2 = love.graphics.newImage("/art/storybutton2.png")

function controlsButtonClass:new(x, y, imageVar, imageVar2)
    self.image = imageVar
    self.image2 = imageVar
    self.image3 = imageVar2
    self.x = x
    self.y = y
    self.height = love.graphics.getHeight(self.image)
    self.width = love.graphics.getWidth(self.image)
    controlScreenBool = false
    storyScreenBool = false
end

function controlsButtonClass:update(dt)
    
    mouse.x, mouse.y = love.mouse.getPosition()
  
    if mouse.x > self.x and mouse.y < self.y + 50 and mouse.x < self.width - self.x and mouse.y < self.y + self.height + 50 and mouse.y > self.y then
        self.image = self.image3
        if love.mouse.isDown("1") and start == false and self.image == controlsButtonImage2 and storyScreenBool == false and controlScreenBool == false and drawIntro == false and startFade == false then
            love.audio.stop(clickFx)
            clickFx:play()
            self:controlScreen()
            love.graphics.setColor(r,g,b,a)
        elseif love.mouse.isDown("1") and start == false and self.image == storyButtonImage2 and controlScreenBool == false and storyScreenBool == false and drawIntro == false and startFade == false then
            love.audio.stop(clickFx)
            clickFx:play()
            self:storyScreen()
            love.graphics.setColor(r,g,b,a)
        end
    else
        self.image = self.image2
    end
    
    if controlScreenBool == true then
        if love.keyboard.isDown("escape") then
            controlScreenBool = false
        end
    elseif storyScreenBool == true then
        if love.keyboard.isDown("escape") then
            storyScreenBool = false
        end
    end
end

function controlsButtonClass:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, 0.2, 0.2)
end

function controlsButtonClass:controlScreen()
    controlScreenBool = true
end

function controlsButtonClass:storyScreen()
    storyScreenBool = true
end