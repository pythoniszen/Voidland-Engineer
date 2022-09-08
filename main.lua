function love.load()

    -- Including classic module to simulate classes in Love2d
    -- Including chrono module to simulate timers
    -- Linking other pages to main
    Object = require "classic-master.classic"
    Timer = require "chrono-master.chrono-master.Timer"
    require "entity"
    require "titlescreenmushroom"
    require "button" require "sbutton" require "shopbutton"
    require "helpers"
    require "user"
    require "benemy"
    --require "flowerenemy"
    require "projectile"
    require "emushroomclass"
    require "projectileleft"
    require "coin"
    require "mushroom"
    require "wrench"
    require "wall"
    require "user"
    require "key"
    require "gate"
    require "shopkeep"

    
    -- Loading in base game assets
    start = false
    gameLevel = 2
    stillCoin = love.graphics.newImage("/art/stillcoin.png")
    coinCount = 0
    mushroomCount = 0
    drawGatePrompt = false
    promptX = 0
    PromptY = 0
    startButton = startButtonClass(310, 380, startButtonImage)
    mouse = {}
    startFade = false
    gameOver = love.graphics.newImage("/art/gameover.png")
    level1Text = false
    drawIntro = true
    stopIntroFadeIn = false
    introFadeOut = false
    drawLevel2Intro = false
    drawLevel2Text = false
    drawLevel3Intro = false
    drawLevel3Text = false
    textPrompt = love.graphics.newImage("/art/textprompt.png")
    shopKeep = Shopkeep(400, 845)
    shopButton1 = ShopButton(400, 800, wrenchImage, 15)
    shopButton2 = ShopButton(460, 800, mushroomImage, 30)
    
    -- Player character components
    user = User(60, 480)
    hasKey = false
    inStock = true
    onGround = true
    

    -- Spawns enemies for level 1
    enemyTitleScreen = TitleScreenM(890, 290, -60, 900, 290)
    
    enemy = EnemyMushroom(800, 525, 690, 810, 525)
    enemy2 = EnemyMushroom(1290, 525, 1200, 1300, 525)
    enemy3 = EnemyMushroom(1440, 375, 1350, 1450, 375)
    enemy4 = EnemyMushroom(2230, 375, 2140, 2240, 375)
    enemy5 = EnemyMushroom(2590, 525, 2500, 2600, 525)
    enemy6 = EnemyMushroom(3190, 525, 3100, 3200, 525)
    enemy7 = EnemyMushroom(3590, -15, 3500, 3600, -25)
    enemy8 = EnemyMushroom(4190, 525, 4100, 4200, 525)
    enemy9 = EnemyMushroom(4290, 525, 4200, 4300, 525)
    enemy10 = EnemyMushroom(5377, 525, 5287, 5387, 525)
    enemy11 = EnemyMushroom(5810, 125, 5720, 5820, 125)
    enemy12 = EnemyMushroom(2650, 125, 2560, 2660, 125)
    
    --fEnemy1 = FEnemyClass(1650, 475)
    
    bEnemy = BEnemyClass(2430, 280, 2340, 2440)
    bEnemy2 = BEnemyClass(3180, 300, 3090, 3190)
    bEnemy3 = BEnemyClass(3690, 370, 3600, 3700)
    bEnemy4 = BEnemyClass(4500, 260, 4410, 4510)
    bEnemy5 = BEnemyClass(4000, 150, 3910, 4010)
    bEnemy6 = BEnemyClass(5000, 350, 4910, 5010)
    bEnemy7 = BEnemyClass(2450, 20, 2360, 2460)
    bEnemy8 = BEnemyClass(5200, 20, 5110, 5210)
    
    -- List of all level 1 enemies
    enemiesList = {enemy, enemy2, enemy3, enemy4, enemy5, bEnemy, enemy6, enemy7, bEnemy2, bEnemy3, enemy8, enemy9, bEnemy4, bEnemy5, enemy10, bEnemy6, enemy11, enemy12, bEnemy7, bEnemy8} --fEnemy1}
    
   
   -- Spawns enemies for level 2
    enemyL2 = EnemyMushroom(1200, 875, 1110, 1210, 875)
    enemy2L2 = EnemyMushroom(1400, 875, 1310, 1410, 875)
    enemy3L2 = EnemyMushroom(1800, 875, 1710, 1810, 875)
    enemy4L2 = EnemyMushroom(3590, 725, 3540, 3600, 725)
    enemy5L2 = EnemyMushroom(3630, 725, 3580, 3640, 725)
    enemy6L2 = EnemyMushroom(3430, 525, 3410, 3440, 525)
    enemy7L2 = EnemyMushroom(2000, 875, 1910, 2010, 875)
    
    bEnemyL2 = BEnemyClass(2100, 710, 2010, 2110)
    bEnemy2L2 = BEnemyClass(1480, 650, 1390, 1490)

    
    -- List of all level 2 enemies
    enemiesList2 = {enemyL2, enemy2L2, enemy3L2, enemy4L2, enemy5L2, enemy6L2, enemy7L2, bEnemyL2, bEnemy2L2}
    
    -- Level 1 timers
    titleEnemeyTimer = Timer()
    introTimer = Timer()
    introFadeOutTimer = Timer()
    level2TextTimer = Timer()
    level2ScreenEndTimer = Timer()
    level3TextTimer = Timer()
    level3ScreenEndTimer = Timer()
    
    enemyTimer = Timer()
    enemy2Timer = Timer()
    enemy3Timer = Timer()
    bEnemyTimer = Timer()
    enemy4Timer = Timer()
    enemy5Timer = Timer()
    enemy6Timer = Timer()
    enemy7Timer = Timer()
    enemy8Timer = Timer()
    enemy9Timer = Timer()
    enemy10Timer = Timer()
    enemy11Timer = Timer()
    enemy12Timer = Timer()
    
    bEnemy2Timer = Timer()
    bEnemy3Timer = Timer()
    bEnemy4Timer = Timer()
    bEnemy5Timer = Timer()
    bEnemy6Timer = Timer()
    bEnemy7Timer = Timer()
    bEnemy8Timer = Timer()
    
    fEnemey1StretchTimer = Timer()
    
    
    -- Title screen animation enemy
    titleEnemeyTimer:every(2, function() enemyTitleScreen:movement() end)
    introTimer:after(2, function() startButtonClass:introEnd() end)
    
    -- Level 2 timers
    enemyL2Timer = Timer()
    enemy2L2Timer = Timer()
    enemy3L2Timer = Timer()
    enemy4L2Timer = Timer()
    enemy5L2Timer = Timer()
    enemy6L2Timer = Timer()
    enemy7L2Timer = Timer()
    
    bEnemyL2Timer = Timer()
    bEnemy2L2Timer = Timer()
    
    -- Level 1 timers
    -- mushroom enemies
    enemyTimer:every(2, function() enemy:movement() end)
    
    enemy2Timer:script(function(wait)
        wait(2.4)
        enemy2Timer:every(2, function() enemy2:movement() end)
    end)
  
    enemy3Timer:script(function(wait)
        wait(1.3)
        enemy3Timer:every(2, function() enemy3:movement() end)
    end)
  
    enemy4Timer:script(function(wait)
        wait(4.1)
        enemy4Timer:every(2, function() enemy4:movement() end)
    end)
  
    enemy5Timer:script(function(wait)
        wait(1.5)
        enemy5Timer:every(2, function() enemy5:movement() end)
    end)
    
    enemy6Timer:script(function(wait)
        wait(2.2)
        enemy6Timer:every(2, function() enemy6:movement() end)
    end)
  
    enemy7Timer:script(function(wait)
        wait(1.5)
        enemy7Timer:every(2, function() enemy7:movement() end)
    end)
  
    enemy8Timer:script(function(wait)
        wait(1.1)
        enemy8Timer:every(2, function() enemy8:movement() end)
    end)
  
    enemy9Timer:script(function(wait)
        wait(2.3)
        enemy9Timer:every(2, function() enemy9:movement() end)
    end)
  
    enemy10Timer:script(function(wait)
        wait(1.1)
        enemy10Timer:every(2, function() enemy10:movement() end)
    end)
  
    enemy11Timer:script(function(wait)
        wait(3.4)
        enemy11Timer:every(2, function() enemy11:movement() end)
    end)
  
    enemy12Timer:script(function(wait)
        wait(2.1)
        enemy12Timer:every(2, function() enemy12:movement() end)
    end)
  
  
    -- Bee timers
    bEnemyTimer:script(function(wait)
        wait(1.4)
        bEnemyTimer:every(2, function() bEnemy:movement() end)
    end)
  
    bEnemy2Timer:script(function(wait)
        wait(2.2)
        bEnemy2Timer:every(2, function() bEnemy2:movement() end)
    end)
  
    bEnemy3Timer:script(function(wait)
        wait(4.1)
        bEnemy3Timer:every(2, function() bEnemy3:movement() end)
    end)
    
    bEnemy4Timer:script(function(wait)
        wait(1.8)
        bEnemy4Timer:every(2, function() bEnemy4:movement() end)
    end)
  
    bEnemy5Timer:script(function(wait)
        wait(1.4)
        bEnemy5Timer:every(2, function() bEnemy5:movement() end)
    end)
  
    bEnemy6Timer:script(function(wait)
        wait(2.1)
        bEnemy6Timer:every(2, function() bEnemy6:movement() end)
    end)
    
    bEnemy7Timer:script(function(wait)
        wait(1.7)
        bEnemy7Timer:every(2, function() bEnemy7:movement() end)
    end)
  
    bEnemy8Timer:script(function(wait)
        wait(1.3)
        bEnemy8Timer:every(2, function() bEnemy8:movement() end)
    end)
  
--  fEnemey1StretchTimer:every(2, function() fEnemy1:movement() end)
    
    --Level 2 enemy timers
    -- Mushroom enemies
    enemyL2Timer:script(function(wait)
        wait(2.6)
        enemyL2Timer:every(2, function() enemyL2:movement() end)
    end)
    enemy2L2Timer:script(function(wait)
        wait(3.3)
        enemy2L2Timer:every(2, function() enemy2L2:movement() end)
    end)
    enemy3L2Timer:script(function(wait)
        wait(4.2)
        enemy3L2Timer:every(2, function() enemy3L2:movement() end)
    end)
    enemy4L2Timer:script(function(wait)
        wait(2.1)
        enemy4L2Timer:every(1.2, function() enemy4L2:movement() end)
    end)
    enemy5L2Timer:script(function(wait)
        wait(4.6)
        enemy5L2Timer:every(1.2, function() enemy5L2:movement() end)
    end)
    enemy6L2Timer:script(function(wait)
        wait(2.3)
        enemy6L2Timer:every(0.6, function() enemy6L2:movement() end)
    end)
    enemy7L2Timer:script(function(wait)
        wait(4.2)
        enemy7L2Timer:every(2, function() enemy7L2:movement() end)
    end)
  
    --Bee Timer
    bEnemyL2Timer:script(function(wait)
        wait(2.1)
        bEnemyL2Timer:every(2, function() bEnemyL2:movement() end)
    end)
    bEnemy2L2Timer:script(function(wait)
        wait(3.4)
        bEnemy2L2Timer:every(2, function() bEnemy2L2:movement() end)
    end)
  
    -- Floor/walls/game objects
    wallHitBottom = false
    brickWall = false
    grassBlock1 = false
    grassBlock2 = false
    grassBlock3 = false
    dirtBlock = false
    walls = {}
    walls2 = {}
    objects = {}
    objects2 = {}
    
    -- Tilemaps located in helpers.lua
    for i,v in ipairs(map) do
        for j,w in ipairs(v) do
            if w == 1 then
                local a = (j-1)*50
                local b = (i-1)*50
                brickWall = false
                grassBlock2 = false
                grassBlock1 = false
                grassBlock3 = false
                local newWall = Wall(a, b)
                table.insert(walls, newWall)
                
            elseif w == 2 then
                local a = (j-1)*50
                local b = (i-1)*50
                brickWall = true
                grassBlock2 = false
                grassBlock1 = false
                grassBlock3 = false
                local newWall = Wall(a, b)
                table.insert(walls, newWall)
            
            elseif w == 5 then
                local a = (j-1)*50
                local b = (i-1)*50
                brickWall = false
                grassBlock2 = false
                grassBlock1 = true
                grassBlock3 = false
                local newWall = Wall(a, b)
                table.insert(walls, newWall)
            elseif w == 6 then
                local a = (j-1)*50
                local b = (i-1)*50
                brickWall = false
                grassBlock2 = true
                grassBlock1 = false
                grassBlock3 = false
                local newWall = Wall(a, b)
                table.insert(walls, newWall)
            elseif w == 7 then
                local a = (j-1)*50
                local b = (i-1)*50
                brickWall = false
                grassBlock2 = false
                grassBlock1 = false
                grassBlock3 = true
                local newWall = Wall(a, b)
                table.insert(walls, newWall)
            
            -- Game objects (anything that isn't a wall)
            elseif w == 3 then
                local a = (j-1)*50
                local b = (i-1)*50
                grassBlock2 = false
                grassBlock1 = false
                grassBlock3 = false
                brickWall = false
                local newCoin = Coin(a, b)
                table.insert(objects, newCoin)
            elseif w == 4 then
                local a = (j-1)*50
                local b = (i-1)*50
                grassBlock2 = false
                grassBlock1 = false
                grassBlock3 = false
                brickWall = false
                local newWrench = Wrench(a, b)
                table.insert(objects, newWrench)
            elseif w == 8 then
                local a = (j-1)*50 + 10
                local b = (i-1)*50
                grassBlock2 = false
                grassBlock1 = false
                grassBlock3 = false
                brickWall = false
                local newMushroom = Mushroom(a, b)
                table.insert(objects, newMushroom)
            elseif w == 9 then
                local a = (j-1)*50
                local b = (i-1)*50
                grassBlock2 = false
                grassBlock1 = false
                grassBlock3 = false
                brickWall = false
                local newKey = Key(a, b)
                table.insert(objects, newKey)
            elseif w == 10 then
                local a = (j-1)*50
                local b = (i-1)*50
                grassBlock2 = false
                grassBlock1 = false
                grassBlock3 = false
                brickWall = false
                local newGate = Gate(a, b)
                table.insert(walls, newGate)
            end
        end
    end
    
    -- Tilemaps for level2
    for i,v in ipairs(map2) do
        for j,w in ipairs(v) do
            if w == 1 then
                local a = (j-1)*50
                local b = (i-1)*50
                brickWall = false
                grassBlock2 = false
                grassBlock1 = false
                grassBlock3 = false
                dirtBlock = false
                local newWall = Wall(a, b)
                table.insert(walls2, newWall)
                
            elseif w == 2 then
                local a = (j-1)*50
                local b = (i-1)*50
                brickWall = true
                grassBlock2 = false
                grassBlock1 = false
                grassBlock3 = false
                dirtBlock = false
                local newWall = Wall(a, b)
                table.insert(walls2, newWall)
            
            elseif w == 5 then
                local a = (j-1)*50
                local b = (i-1)*50
                brickWall = false
                grassBlock2 = false
                grassBlock1 = true
                grassBlock3 = false
                dirtBlock = false
                local newWall = Wall(a, b)
                table.insert(walls2, newWall)
            elseif w == 6 then
                local a = (j-1)*50
                local b = (i-1)*50
                brickWall = false
                grassBlock2 = true
                grassBlock1 = false
                grassBlock3 = false
                dirtBlock = false
                local newWall = Wall(a, b)
                table.insert(walls2, newWall)
            elseif w == 7 then
                local a = (j-1)*50
                local b = (i-1)*50
                brickWall = false
                grassBlock2 = false
                grassBlock1 = false
                grassBlock3 = true
                dirtBlock = false
                local newWall = Wall(a, b)
                table.insert(walls2, newWall)
            elseif w == 11 then
                local a = (j-1)*50
                local b = (i-1)*50
                brickWall = false
                grassBlock2 = false
                grassBlock1 = false
                grassBlock3 = false
                dirtBlock = true
                local newWall = Wall(a, b)
                table.insert(walls2, newWall)
            
            -- Game objects (anything that isn't a wall)
            elseif w == 3 then
                local a = (j-1)*50
                local b = (i-1)*50
                grassBlock2 = false
                grassBlock1 = false
                grassBlock3 = false
                brickWall = false
                dirtBlock = false
                local newCoin = Coin(a, b)
                table.insert(objects2, newCoin)
            elseif w == 4 then
                local a = (j-1)*50
                local b = (i-1)*50
                grassBlock2 = false
                grassBlock1 = false
                grassBlock3 = false
                brickWall = false
                dirtBlock = false
                local newWrench = Wrench(a, b)
                table.insert(objects2, newWrench)
            elseif w == 8 then
                local a = (j-1)*50
                local b = (i-1)*50
                grassBlock2 = false
                grassBlock1 = false
                grassBlock3 = false
                brickWall = false
                dirtBlock = false
                local newMushroom = Mushroom(a, b)
                table.insert(objects2, newMushroom)
            elseif w == 9 then
                local a = (j-1)*50
                local b = (i-1)*50
                grassBlock2 = false
                grassBlock1 = false
                grassBlock3 = false
                brickWall = false
                dirtBlock = false
                local newKey = Key(a, b)
                table.insert(objects2, newKey)
            elseif w == 10 then
                local a = (j-1)*50
                local b = (i-1)*50
                grassBlock2 = false
                grassBlock1 = false
                grassBlock3 = false
                brickWall = false
                dirtBlock = false
                local newGate = Gate(a, b)
                table.insert(walls2, newGate)
            end
        end
    end
    
    -- Player projectile
    projectileList = {}
    leftProjectileList = {}
    
    inStock = true
    pStock = 3
    wallHit = false
    
    
    -- Player movement/ status
    frames = {}
    left_run_frames = {}
    
    -- Left and right run spritesheets animation code
    jump_img = love.graphics.newImage("/art/runsheet.png")
    jump_img_left = love.graphics.newImage("/art/runsheetleft.png")
    local img_width = jump_img:getWidth()
    local img_height = jump_img:getHeight()
    local quad_width = 50
    local quad_height = 80
    
    for i=0, 4 do
        table.insert(frames, love.graphics.newQuad(5 + i * (quad_width + 15), 10, quad_width + 10, quad_height, img_width, img_height))
    end
    
    currentFrame = 1
    
    for i=0, 4 do
        table.insert(left_run_frames, love.graphics.newQuad(5 + i * (quad_width + 15), 10, quad_width + 10, quad_height, img_width,        img_height))
    end
    
    currentFrameLeft = 1
    
    alive = true
    
    -- Projectile animation spritesheet code
    spin_frames = {}
    left_spin_frames = {}
    wrench_spin = love.graphics.newImage("/art/spinsheet.png")
    left_wrench_spin = love.graphics.newImage("/art/spinsheetleft.png")
    wrenchImage = love.graphics.newImage("/art/wrench.png")
    
    local spin_width = wrench_spin:getWidth()
    local spin_height = wrench_spin:getHeight()
    local spin_quad_w = 18
    local spin_quad_h = 21
    
    for i=0, 5 do
        table.insert(spin_frames, love.graphics.newQuad(6 + i * (spin_quad_w + 12), 6, spin_quad_w, (spin_quad_h + 2), spin_width,            spin_height))
    end
    
    wrenchCurrentFrame = 1
    
    for i=0, 5 do
        table.insert(left_spin_frames, love.graphics.newQuad(6 + i * (spin_quad_w + 12), 6, spin_quad_w, (spin_quad_h + 2),            spin_width, spin_height))
    end
    
    wrenchCurrentFrameLeft = 1
    
    -- Coin animation
    coinSheet = love.graphics.newImage("/art/coin.png")
    coinFrames = {}
    local imgWidth = coinSheet:getWidth()
    local imgHeight = coinSheet:getHeight()
    local quadW = 30
    local quadH = 29
    
    for i=0, 5 do
        table.insert(coinFrames, love.graphics.newQuad(6 + i * (quadW + 15), 6, quadW + 4, (quadH + 9.5), imgWidth, imgHeight))
    end
    
    coinCurrentFrame = 1
    
    -- Fade animation
    fade1 = love.graphics.newImage("/art/fade1.png")
    fade2 = love.graphics.newImage("/art/fade2.png")
    fade3 = love.graphics.newImage("/art/fade3.png")
    fade4 = love.graphics.newImage("/art/fade4.png")
    fade5 = love.graphics.newImage("/art/fade5.png")
    fade6 = love.graphics.newImage("/art/fade6.png")
    
    fadeFrames = {}
    
    table.insert(fadeFrames, fade1)
    table.insert(fadeFrames, fade2)
    table.insert(fadeFrames, fade3)
    table.insert(fadeFrames, fade4)
    table.insert(fadeFrames, fade5)
    table.insert(fadeFrames, fade6)
    
    fadeCurrentFrame = 1
    fadeCurrentFrame2 = 7
    fadeCurrentFrame3 = 1
    fadeCurrentFrame4 = 1
    fadeCurrentFrame5 = 1
    
    -- Enemy animations
    
    enemyJumpImage = love.graphics.newImage("/art/enemyjumpleft.png")
    enemyJumpImageRight = love.graphics.newImage("/art/enemyjumpright.png")
    bEnemyFlyRight = love.graphics.newImage("/art/benemyflyright.png")
    bEnemyFlyLeft = love.graphics.newImage("/art/benemyfly.png")
    
    eFrames = {}
    bEFrames = {}
    fEStretchFrames = {}
    fEMoveFrames = {}
    
    local eWidth = enemyJumpImage:getWidth()
    local eHeight = enemyJumpImage:getHeight()
    local eQuadW = 60
    local eQuadH = -20
    
    -- Mushroom Class animation frames
    for i=0, 4 do
        table.insert(eFrames, love.graphics.newQuad(10 + i * (eQuadW + 15), 6, eQuadW, (eHeight - 16), eWidth, eHeight))
    end
    
    -- Bee Enemy Class frames
    for i=0, 4 do
        table.insert(bEFrames, love.graphics.newQuad(6 + i * (eQuadW + 15), 9, eQuadW + 8, (eHeight - 16), eWidth, eHeight))
    end
    
    -- Flower Enemy Class frames
--    local sWidth = whipSheet:getWidth()
--    local sHeight = whipSheet:getHeight()
--    local fQuadW = 185
--    local fQuadH = 40
    
--    for i=0, 6 do
--        table.insert(fEStretchFrames, love.graphics.newQuad(6 + i * (fQuadW + 10), 6, fQuadW + 2, (sHeight - 12), sWidth, sHeight))
--    end
    
--    fEnemy1.currentFrame = 1
    
--    local mWidth = whipSheet:getWidth()
--    local mHeight = whipSheet:getHeight()
    
--    for i=0, 6 do
--        table.insert(fEMoveFrames, love.graphics.newQuad(6 + i * (fQuadW + 10), 6, fQuadW + 2, (sHeight - 12), sWidth, sHeight))
--    end
    
--    fEnemy1.currentFrame = 1
    


    -- Music, background, game over screen, font
    homeSong = love.audio.newSource("/art/voidlandtheme.ogg", "stream")
        homeSong:setLooping(true)
        homeSong:play()
    
    myBackground = love.graphics.newImage("/art/bg.png")
    myBackground2 = love.graphics.newImage("/art/bg2.png")
    statsCanvas = love.graphics.newCanvas(600, 800)
    
    r,g,b,a = love.graphics.getColor()
    
    font = love.graphics.newFont("/art/Retro Gaming.ttf", 60)
    love.graphics.setFont(font)
    
end

function love.update(dt)
    
    -- Fixes bug where character would fall off screen when game window was moved
    dt = math.min(dt, 1/10)
    
    --Button updates
    startButton:update(dt)
    
    enemyTitleScreen:update(dt)
    
    -- Calls to update the state of characters in the game
    user:update(dt)
    
    shopKeep:update(dt)
    shopButton1:update(dt)
    shopButton2:update(dt)
    
    if user.y ~= user.last.y then
        onGround = false
    end
    
    -- Updates enemies
    --if start == true then
        for i,enemy in ipairs(enemiesList) do
            enemy:update(dt)
        end
    --end
    
    for i,enemy in ipairs(enemiesList2) do
        enemy:update(dt)
    end
    
    if start == false then
        startTimer:update(dt)
        titleEnemeyTimer:update(dt)
        level1textTimer:update(dt)
        introTimer:update(dt)
        introFadeOutTimer:update(dt)
    end
    
    level2TextTimer:update(dt)
    level2ScreenEndTimer:update(dt)
    level3TextTimer:update(dt)
    level3ScreenEndTimer:update(dt)
    
    enemyTimer:update(dt)
    enemy2Timer:update(dt)
    enemy3Timer:update(dt)
    bEnemyTimer:update(dt)
    enemy4Timer:update(dt)
    enemy5Timer:update(dt)
    enemy6Timer:update(dt)
    enemy7Timer:update(dt)
    enemy8Timer:update(dt)
    enemy9Timer:update(dt)
    enemy10Timer:update(dt)
    enemy11Timer:update(dt)
    enemy12Timer:update(dt)
    
    bEnemy2Timer:update(dt)
    bEnemy3Timer:update(dt)
    bEnemy4Timer:update(dt)
    bEnemy5Timer:update(dt)
    bEnemy6Timer:update(dt)
    bEnemy7Timer:update(dt)
    bEnemy8Timer:update(dt)
    
    fEnemey1StretchTimer:update(dt)
    
    --lvl 2 timers
    enemyL2Timer:update(dt)
    enemy2L2Timer:update(dt)
    enemy3L2Timer:update(dt)
    enemy4L2Timer:update(dt)
    enemy5L2Timer:update(dt)
    enemy6L2Timer:update(dt)
    enemy7L2Timer:update(dt)
    
    bEnemyL2Timer:update(dt)
    bEnemy2L2Timer:update(dt)
    
    -- Updates player timers with dt
    invincibleTimer:update(dt)
    dashTimer:update(dt)
    cooldownTimer:update(dt)
    
    if start == true then
        titleEnemeyTimer:destroy()
        startTimer:destroy()
        level1textTimer:destroy()
    elseif drawIntro == false then
        introTimer:destroy()
        introFadeOutTimer:destroy()
    end
    
    if gameLevel == 3 then
        level2TextTimer:destroy()
        level2ScreenEndTimer:destroy()
    end
    if gameLevel == 4 then
        level3TextTimer:destroy()
        level3ScreenEndTimer:destroy()
    end
    
    
    if enemy.eAlive == false then
        enemyTimer:destroy()
    end
    if enemy2.eAlive == false then
        enemy2Timer:destroy()
    end
    if enemy3.eAlive == false then
        enemy3Timer:destroy()
    end
    if bEnemy.eAlive == false then
        bEnemyTimer:destroy()
    end
    if enemy4.eAlive == false then
        enemy4Timer:destroy()
    end
    if enemy5.eAlive == false then
        enemy5Timer:destroy()
    end
    if enemy6.eAlive == false then
        enemy6Timer:destroy()
    end
    if enemy7.eAlive == false then
        enemy7Timer:destroy()
    end
    if enemy8.eAlive == false then
        enemy8Timer:destroy()
    end
    if enemy9.eAlive == false then
        enemy9Timer:destroy()
    end
    if enemy10.eAlive == false then
        enemy10Timer:destroy()
    end
    if enemy11.eAlive == false then
        enemy11Timer:destroy()
    end
    if enemy12.eAlive == false then
        enemy12Timer:destroy()
    end
    
    if bEnemy2.eAlive == false then
        bEnemy2Timer:destroy()
    end
    if bEnemy3.eAlive == false then
        bEnemy3Timer:destroy()
    end
    if bEnemy4.eAlive == false then
        bEnemy4Timer:destroy()
    end
    if bEnemy5.eAlive == false then
        bEnemy5Timer:destroy()
    end
    if bEnemy5.eAlive == false then
        bEnemy5Timer:destroy()
    end
    if bEnemy7.eAlive == false then
        bEnemy7Timer:destroy()
    end
    if bEnemy8.eAlive == false then
        bEnemy8Timer:destroy()
    end
--    if fEnemy1.eAlive == false then
--        fEnemey1StretchTimer:destroy()
--    end
    
    -- Level 2 enemies
    if enemyL2.eAlive == false then
        enemyL2Timer:destroy()
    end
    if enemy2L2.eAlive == false then
        enemy2L2Timer:destroy()
    end
    if enemy3L2.eAlive == false then
        enemy3L2Timer:destroy()
    end
    if enemy4L2.eAlive == false then
        enemy4L2Timer:destroy()
    end
    if enemy5L2.eAlive == false then
        enemy5L2Timer:destroy()
    end
    if enemy6L2.eAlive == false then
        enemy6L2Timer:destroy()
    end
    if enemy7L2.eAlive == false then
        enemy7L2Timer:destroy()
    end
    
    if bEnemyL2.eAlive == false then
        bEnemyL2Timer:destroy()
    end
    if bEnemy2L2.eAlive == false then
        bEnemy2L2Timer:destroy()
    end
    
    if isDashing == false then
        dashTimer:destroy()
    end

    -- Draws bitmap and resolves user collision with 'walls' and objects
    if gameLevel == 1 then
        for i,v in ipairs(walls) do
            v:update(dt)
        end
        
        for i,v in ipairs(objects) do
            v:update(dt)
        end
    elseif gameLevel == 2.5 then
        for i,v in ipairs(walls2) do
            v:update(dt)
        end
        
        for i,v in ipairs(objects2) do
            v:update(dt)
        end
    end
    
    local loop = true
    local limit = 0

    while loop do
        loop = false

        limit = limit + 1
        if limit > 100 then
            break
        end
        
        if gameLevel == 1 then
            for i,object in ipairs(objects) do
                if hitDetect(user, object) then
                    object.alive = false
                end
            end

            for i,wall in ipairs(walls) do
                collision = user:resolveCollision(wall)
                if collision then
                    onGround = true
                    loop = true
                else
                    onGround = false
                end
            end
        
        elseif gameLevel == 2.5 then
            for i,object in ipairs(objects2) do
                if hitDetect(user, object) then
                    object.alive = false
                end
            end

            for i,wall in ipairs(walls2) do
                collision = user:resolveCollision(wall)
                if collision then
                    onGround = true
                    loop = true
                else
                    onGround = false
                end
            end
        elseif gameLevel == 3.5 then
            for i,object in ipairs(objects2) do
                if hitDetect(user, object) then
                    object.alive = false
                end
            end

            for i,wall in ipairs(walls2) do
                collision = user:resolveCollision(wall)
                if collision then
                    onGround = true
                    loop = true
                else
                    onGround = false
                end
            end
        end
    end
    
    
    -- Accounts for projectiles
    for i,v in ipairs(projectileList) do
        v:update(dt)
    end
    for i,v in ipairs(leftProjectileList) do
        v:update(dt)
    end
    
    if pStock <= 0 then
        inStock = false
        if pStock < 0 then
            pStock = 0
        end
    end
    
    for i,wall in ipairs(walls) do
        if wall.image == gateImage and user.x > wall.x - 150 and user.y > wall.y - 20 then
            drawGatePrompt = true
            if hasKey == true and love.keyboard.isDown("q") and user.x > wall.x - 150 and user.y > wall.y - 150 then
                if gameLevel == 1 then
                    gameLevel = 2
                    fadeCurrentFrame = 1
                elseif gameLevel == 2.5 then
                    gameLevel = 3
                    fadeCurrentFrame = 1
                end
            end
        elseif wall.image == gateImage and user.x < wall.x - 150 then
            drawGatePrompt = false
        end
    end
    
    -- Game over screen
    if alive == false then
        if love.keyboard.isDown("r") then
            love.graphics.setColor(r,g,b,a)
            love.load()
        end
    end
    
    
    -- Fade animation
    
    fadeCurrentFrame = fadeCurrentFrame + 45 * dt
    if fadeCurrentFrame >= 6 then
        fadeCurrentFrame = 6
    end
    
    fadeCurrentFrame2 = fadeCurrentFrame2 - 45 * dt
    if fadeCurrentFrame2 <= 1 then
        fadeCurrentFrame2 = 1
        stopIntroFadeIn = true
    end
    
    fadeCurrentFrame3 = fadeCurrentFrame3 + 45 * dt
    if fadeCurrentFrame3 >= 6 then
        fadeCurrentFrame3 = 6
    end
    
    fadeCurrentFrame4 = fadeCurrentFrame4 + 45 * dt
    if fadeCurrentFrame4 >= 6 then
        fadeCurrentFrame4 = 6
    end
    
    fadeCurrentFrame5 = fadeCurrentFrame5 + 45 * dt
    if fadeCurrentFrame5 >= 6 then
        fadeCurrentFrame5 = 6
    end

    -- Wrench Animation
    
    wrenchCurrentFrame = wrenchCurrentFrame + 10 * dt
    if wrenchCurrentFrame >= 5 then
        wrenchCurrentFrame = 1
    end
    
    wrenchCurrentFrameLeft = wrenchCurrentFrameLeft + 10 * dt
    if wrenchCurrentFrameLeft >= 5 then
        wrenchCurrentFrameLeft = 1
    end
    
    -- Coin Animation
    coinCurrentFrame = coinCurrentFrame + 6 * dt
    if coinCurrentFrame >= 6 then
        coinCurrentFrame = 1
    end
    
    if gameLevel == 2.5 then
        for i,enemy in ipairs(enemiesList) do
            enemy.eAlive = false
        end
    end
    
    if gameLevel == 2 then
        user:level2(gameLevel)
        drawLevel2Intro = true
    end
    
    if drawLevel2Intro == true then
        level2TextTimer:after(2, function() user:drawLevel2Text() end)
    end
    
    if gameLevel == 3 then
        user:level3(gameLevel)
        drawLevel3Intro = true
    end
    
    if drawLevel3Intro == true then
        level3TextTimer:after(2, function() user:drawLevel3Text() end)
    end 
end

function love.draw()
    
    --Camera
    love.graphics.translate(-user.x + 300, -user.y + 300)
    
    -- Draws base game
    if gameLevel == 1 then
        love.graphics.draw(myBackground, -300, -865)
    elseif gameLevel == 2.5 and drawLevel2Text == true then -- potentially causing animatiuon transition interuption
        love.graphics.draw(myBackground2, -300, -515)  
    elseif gameLevel == 3.5 and drawLevel3Text == true then
        love.graphics.draw(myBackground2, -300, -515)  
    end
    
    if gameLevel ~= 1 then
        shopKeep:draw()
        shopButton1:draw()
        shopButton2:draw()
    end
    
    user:draw()
    
    
    -- Draws bitmap, objects, and projectiles
    
    if gameLevel == 1 then
        for i,v in ipairs(objects) do
            v:draw()
        end
    elseif gameLevel == 2.5 then
        for i,v in ipairs(objects2) do
            v:draw()
        end
    end
    
    -- Draws projectiles
    for i,v in ipairs(projectileList) do
        v:draw()
        if inStock == false then
            projectileList[i]:draw()
        end
    end
    for i,v in ipairs(leftProjectileList) do
        v:draw()
        if inStock == false then
            leftProjectileList[i]:draw()
        end
    end
    
    if gameLevel == 1 then
        for i,v in ipairs(walls) do
            v:draw()
        end
    elseif gameLevel == 2.5 and drawLevel2Text == true then
        for i,v in ipairs(walls2) do
            v:draw()
        end
    elseif gameLevel == 3.5 and drawLevel2Text == true then
        for i,v in ipairs(walls2) do
            v:draw()
        end
    end
    
    -- Draws enemy
    
    if gameLevel == 1 and start == true then
        for i,enemy in ipairs(enemiesList) do
            enemy:draw()
        end
    elseif gameLevel == 2.5 then
        for i,enemy in ipairs(enemiesList2) do
            enemy:draw()
        end
    end
    
    
    if invincible == true then
        love.graphics.draw(mushroomImage, user.x, user.y, 0, 0.6, 0.6)
    end
    
    -- Draws HUD
    if start == true then
        love.graphics.draw(stillCoin, user.x - 290, user.y - 280, 0, 0.5, 0.5)
        love.graphics.print("x".. coinCount, user.x - 260, user.y - 290, 0, 0.5, 0.5)
        love.graphics.draw(wrenchImage, user.x - 286, user.y - 245)
        love.graphics.print("x".. pStock, user.x - 260, user.y - 255, 0, 0.5, 0.5)
        love.graphics.draw(mushroomImage, user.x - 292, user.y - 214, 0, 0.6, 0.6)
        love.graphics.print("x".. mushroomCount, user.x - 260, user.y - 222, 0, 0.5, 0.5)
        if hasKey == true then
            love.graphics.draw(keyImage, user.x - 284, user.y - 180)
        end
    end
    
    if drawGatePrompt == true and jumpBool == true then
        love.graphics.draw(textPrompt, user.x, user.y + 190)
        love.graphics.print("If you have a key,", user.x + 10, user.y + 200, 0, 0.16, 0.16)
        love.graphics.print("press 'q' to open the", user.x + 10, user.y + 210, 0, 0.16, 0.16)
        love.graphics.print(" gate.", user.x + 10, user.y + 220, 0, 0.16, 0.16)
    end
      
    
    -- Start Screen
    if start == false then
        love.graphics.translate(user.x - 300, user.y - 300)
        love.graphics.draw(gameOver, 0, 0)
        love.graphics.setColor(0, 1, 0)
        love.graphics.print("Voidland", 240, 100)
        love.graphics.print("Engineer", 240, 200)
        startButton:draw()
        love.graphics.setColor(r,g,b,a)
        enemyTitleScreen:draw()
    end
    if startFade == true and start == false then
        love.graphics.draw(fadeFrames[math.floor(fadeCurrentFrame)], 0, 0)
    end
    if level1Text == true and startFade == true then
        love.graphics.print("Area 1", 260, 250)
    end
    
    if drawIntro == true and start == false then
        love.graphics.draw(gameOver, 0, 0)
        love.graphics.print("A Nathan Lusk game.", 220, 270, 0, 0.5, 0.5)
        if stopIntroFadeIn == false then
            love.graphics.draw(fadeFrames[math.floor(fadeCurrentFrame2)], 0, 0)
        else
            introFadeOutTimer:after(1, function() startButtonClass:introFadeStart() end)
            if introFadeOut == true then
                love.graphics.draw(fadeFrames[math.floor(fadeCurrentFrame3)], 0, 0)
            end
        end
    end
    
    if drawLevel2Intro == true  then
        love.graphics.draw(fadeFrames[math.floor(fadeCurrentFrame4)], user.x -400, user.y - 400)
        if drawLevel2Text == true then
            love.graphics.print("Area 2", user.x - 50, user.y - 80)
        end
    end
    
    if drawLevel3Intro == true  then
        love.graphics.draw(fadeFrames[math.floor(fadeCurrentFrame5)], user.x -400, user.y - 400)
        if drawLevel3Text == true then
            love.graphics.print("Area 3", user.x - 50, user.y - 80)
            love.graphics.setColor(1, 0, 0)
            love.graphics.print('"The Control Room"', user.x - 90, user.y, 0, 0.5, 0.5)
            love.graphics.setColor(r, g, b, a)
        end
    end
    
    if drawShopAlert == true then
        love.graphics.draw(textPrompt, user.x, user.y + 190)
        love.graphics.print("Press 'q' to talk.", user.x + 10, user.y + 200, 0, 0.16, 0.16)
    end
    
    --love.graphics.draw(love.graphics.newImage("/art/flowerstretchsheet.png"), 200, 468)

    
    -- Game over screen
    if alive == false then
          love.graphics.translate(user.x - 300, user.y - 300)
          love.graphics.draw(gameOver, 0, 0)
          love.graphics.setColor(1, 0, 0)
          love.graphics.print("YOU ARE DEAD.", 140, 200)
          love.graphics.print("Press 'r' to reload the game.", 150, 300, 0, 0.5, 0.5)
          love.audio.stop()
    end
end

-- function for user input
function love.keypressed(key)
    user:keyInput(key)
    if key == "space" then
        if jumpBool == true then
            user:jump()
        end
    elseif key == "return" then
        start = false
    elseif key == "q" then
        if shopTalkBool == true then
            shopTalkCounter = shopTalkCounter + 1
        end
    end
end

function love.mousepressed(x, y, button)
    if button == 1 and shopTalkCounter == 2 and shopButton1.canBuy == true then
        if coinCount >= 15 then
            coinCount = coinCount - 15
            pStock = pStock + 1
        end
    elseif button == 1 and shopTalkCounter == 2 and shopButton2.canBuy == true then
        if coinCount >= 30 then
            coinCount = coinCount - 30
            mushroomCount = mushroomCount + 1
        end
    end
end