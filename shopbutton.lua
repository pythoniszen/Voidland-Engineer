require "main"
require "shopkeep"
require "coin"

ShopButton = Button:extend()

function ShopButton:new(x, y, imageVar, price, i1, i2)
    self.image = imageVar
    self.imageMain = imageVar
    self.x = x
    self.y = y
    self.height = love.graphics.getHeight(self.image)
    self.width = love.graphics.getWidth(self.image)
    self.canBuy = true
    self.price = price
    self.right = i1
    self.left = i2
end

function ShopButton:update(dt)
  
    if mouse.x > self.right and mouse.y < self.y and mouse.x < self.left and mouse.y > 220 and mouse.y < 300 then
        --self.image = stillCoin
        self.canBuy = true
    else
        --self.image = self.imageMain
        self.canBuy = false
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