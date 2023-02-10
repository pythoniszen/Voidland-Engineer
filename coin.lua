require "main"

-- Class for walls in game world
Coin = Entity:extend()
coinImage = love.graphics.newImage("/art/coin.png")

function Coin:new(x, y)
    Coin.super.new(self, x, y, "/art/coin.png")
    
    -- Properties
    self.strength = 100
    self.width = self.image:getWidth() - 250
    self.height = self.image:getHeight() - 50
    self.x = self.x + 18
    self.weight = 0
    self.strength = 100
    self.alive = true
    self.image = coinImage
    self.loop = true
end

function Coin:update(dt)
    
    -- Keeps track of coin count
    if self.alive == false and self.loop == true then
        coinCount = coinCount + 1
        self.loop = false
    end
end

function Coin:draw(x, y)
    if self.alive == true then
        love.graphics.draw(coinSheet, coinFrames[math.floor(coinCurrentFrame)], self.x, self.y)
    end
end