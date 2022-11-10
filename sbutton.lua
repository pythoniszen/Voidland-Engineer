require "main"
require "cbutton"
Timer = require "chrono-master.chrono-master.Timer"

startTimer = Timer()
level1textTimer = Timer()

startButtonClass = Button:extend()
startButtonImage = love.graphics.newImage("/art/startbutton.png")
startButtonImage2 = love.graphics.newImage("/art/startbuttonhighlight.png")

function startButtonClass:new(x, y, imageVar)
    self.image = imageVar
    self.x = x
    self.y = y
    self.height = love.graphics.getHeight(self.image)
    self.width = love.graphics.getWidth(self.image)
end

function startButtonClass:update(dt)
    mouse.x, mouse.y = love.mouse.getPosition()
  
    if mouse.x > self.x and mouse.y < self.y + 50 and mouse.x < self.width - self.x and mouse.y < self.y + self.height + 50 and mouse.y > self.y then
        self.image = startButtonImage2
        if love.mouse.isDown("1") and start == false and controlScreenBool == false then
            startFade = true
            self:startGame()
            love.graphics.setColor(r,g,b,a)
        end
    else
        self.image = startButtonImage
    end
    
    if startFade == false then
        fadeCurrentFrame = 1
    end
    if introFadeOut == false then
        fadeCurrentFrame3 = 1
    end
    if drawLevel2Intro == false then
        fadeCurrentFrame4 = 1
    end
    if drawLevel3Intro == false then
        fadeCurrentFrame5 = 1
    end
end

function startButtonClass:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, 0.2, 0.2)
end

function startButtonClass:startGame()
    love.audio.stop(clickFx)
    clickFx:play()
    startTimer:after(3, function() self:endFade() end)
    level1textTimer:after(1.5, function() self:l1Txt() end)
end

function startButtonClass:endFade()
    startFade = false
    start = true
    gameLevel = 3
end

function startButtonClass:l1Txt()
    level1Text = true
end

function startButtonClass:introEnd()
    drawIntro = false
end

function startButtonClass:introFadeStart()
    introFadeOut = true
end