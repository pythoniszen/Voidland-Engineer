require "main"
require "shopkeep"
require "coin"

ShopButton = Button:extend()

function ShopButton:new(x, y, imageVar, price)
    self.image = imageVar
    self.imageMain = imageVar
    self.x = x
    self.y = y
    self.height = love.graphics.getHeight(self.image)
    self.width = love.graphics.getWidth(self.image)
    self.canBuy = false
    self.price = price
end

function ShopButton:update(dt)
  
    if mouse.x > self.x - 98 and mouse.y < self.y and mouse.x < self.x - 48 and mouse.y > 220 and mouse.y < 300 then
        --self.image = stillCoin
        self.canBuy = true
    else
        --self.image = self.imageMain
        self.canBuy = false
    end
    
    if user.x ~= user.last.x then
        self.canBuy = false
        shopTalkCounter = 0
        shopTalkBool = false
    end
end

function ShopButton:draw()
    if shopTalkCounter == 2 and user.x < shopKeep.x then
        if self.imageMain == mushroomImage then
            love.graphics.draw(self.image, self.x - 110, self.y - 25, 0, 0.8, 0.8)
        else
            love.graphics.draw(self.image, self.x - 100, self.y - 25)      
        
        end
        
        love.graphics.draw(stillCoin, self.x - 95, self.y + 10, 0, 0.2, 0.2)
        love.graphics.print(":"..self.price, self.x - 85, self.y + 10, 0, 0.16, 0.16)
    end
end