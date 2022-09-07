require "main"
require "user"

Shopkeep = Entity:extend()
shopKeepImage = love.graphics.newImage("/art/shopkeepstandleft.png")
shopKeepImageRight = love.graphics.newImage("/art/shopkeepstandright.png")
npcTalkImage = love.graphics.newImage("/art/npctalk.png")
shopImage = love.graphics.newImage("/art/shop.png")

function Shopkeep:new(x, y)
    Gate.super.new(self, x, y, "/art/shopkeepstandleft.png")
    -- Properties
    self.strength = 100
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.weight = 0
    self.image = shopKeepImage
    self.x = x
    self.y = y
    drawShopAlert = false
    shopTalkBool = false
    shopTalkCounter = 0
end

function Shopkeep:update(dt)
    if user_left == false and shopTalkBool == false and user.x < self.x - 10 and gameLevel > 1 and user.y >= 829 then
        if user.x > self.x - 180 then
            drawShopAlert = true
            self.image = shopKeepImage
            if love.keyboard.isDown("q") then
                shopTalkBool = true
            end
        end
--    elseif user_left == true and shopTalkBool == false and user.x > self.x - 50 and gameLevel == 2.5 and user.y >= 829 then
--        if user.x < (self.x - 20) + 180 then
--            drawShopAlert = true
--            self.image = shopKeepImageRight
--            if love.keyboard.isDown("q") then
--                shopTalkBool = true
--            end
--        end
        
    else
        drawShopAlert = false

    end
    
    if user.x > shopKeep.x then
        shopTalkBool = false
        shopTalkCounter = 0
    end
    
    if shopTalkBool == false then
        shopTalkCounter = 0
    end
    
    if shopTalkBool == true and user_left == true and user.x < self.x - 150 or user.y < 829 then
        shopTalkBool = false
    end
    
    if shopTalkCounter >= 3 then
        shopTalkBool = false
    end
    
end

function Shopkeep:draw()
    love.graphics.draw(self.image, self.x, self.y)
    
    if shopTalkBool == true and shopTalkCounter <= 2 then
        
        if shopTalkCounter == 0 and user.x < self.x then
            love.graphics.draw(npcTalkImage, self.x - 160, self.y - 80)
            love.graphics.setColor(0, 0, 0)
            love.graphics.print("Merchant:", self.x - 150, self.y - 70, 0, 0.16, 0.16)
            love.graphics.print("In the market for any", self.x - 150, self.y - 60, 0, 0.16, 0.16)
            love.graphics.print(" tools or commodities?", self.x - 150, self.y - 50, 0, 0.16, 0.16)
            love.graphics.print("(press 'q' to continue)", self.x - 150, self.y - 25, 0, 0.16, 0.16)
            love.graphics.setColor(r, g, b, a)
        elseif shopTalkCounter == 1 and user.x < self.x then
            love.graphics.draw(npcTalkImage, self.x - 160, self.y - 80)
            love.graphics.setColor(0, 0, 0)
            love.graphics.print("Merchant:", self.x - 150, self.y - 70, 0, 0.16, 0.16)
            love.graphics.print("Click on the product", self.x - 150, self.y - 60, 0, 0.16, 0.16)
            love.graphics.print(" you're interested in", self.x - 150, self.y - 50, 0, 0.16, 0.16)
            love.graphics.print(" to buy it.", self.x - 150, self.y - 40, 0, 0.16, 0.16)
            love.graphics.print("(press 'q' to continue)", self.x - 150, self.y - 25, 0, 0.16, 0.16)
            love.graphics.setColor(r, g, b, a)
        elseif shopTalkCounter == 2 and user.x < self.x then
            love.graphics.draw(shopImage, self.x - 140, self.y - 90)
        end
    end
end