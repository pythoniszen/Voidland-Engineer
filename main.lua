function love.load()
    -- Includes classic module to simulate classes in Love2d
    -- Includes chrono module to simulate timers
    -- Links other pages to main
    Object = require "classic-master.classic"
    Timer = require "chrono-master.chrono-master.Timer"
    require "entity"
    require "titlescreenmushroom"
    require "button"
    require "sbutton" 
    require "cbutton" 
    require "shopbutton"
    require "helpers"
    require "user"
    require "benemy"
    require "projectile"
    require "emushroomclass"
    require "projectileleft"
    require "coin"
    require "computer"
    require "mushroom"
    require "wrench"
    require "wall"
    require "user"
    require "key"
    require "gate"
    require "shopkeep"
    require "traveler"
    require "boss"
    require "princess"
    
    -- Loading in base game assets
    bossImage = love.graphics.newImage("/art/bossstand.png")
    start = false
    gameLevel = 0
    stillCoin = love.graphics.newImage("/art/stillcoin.png")
    coinCount = 0
    mushroomCount = 0
    drawGatePrompt = false
    promptX = 0
    PromptY = 0
    startButton = startButtonClass(310, 380, startButtonImage)
    controlsButton = controlsButtonClass(310, 440, controlsButtonImage, controlsButtonImage2)
    storyButton = controlsButtonClass(310, 500, storyButtonImage, storyButtonImage2)
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
    heartImg = love.graphics.newImage("/art/heartimg.png")
    shopKeep = Shopkeep(400, 845)
    traveler = Traveler(5872, 85)
    shopButton1 = ShopButton(400, 800, wrenchImage, 10)
    shopButton2 = ShopButton(460, 800, mushroomImage, 20)
    bossBool = false
    boss = Boss(8100, 760, 7460, 8110, 760)
    speedUp = false
    bJumpBool = false
    l3SongTimer = Timer()
    gameOverFxTimer = Timer()
    endGameFxBool = false
    computer = Computer()
    resetGameTimer = Timer()
    drawResetTextBool = false
    playEndFxBool = true
    
    -- Sound Fx/ Audio
    clickFx = love.audio.newSource("/vleaudiofx/click.ogg", "stream")
    coinFx = love.audio.newSource("/vleaudiofx/coingrab.ogg", "stream")
    itemFx = love.audio.newSource("/vleaudiofx/itemgrab.ogg", "stream")
    doorFx = love.audio.newSource("/vleaudiofx/door.ogg", "stream")
    doorFx2 = love.audio.newSource("/vleaudiofx/door.ogg", "stream")
    doorFx3 = love.audio.newSource("/vleaudiofx/door.ogg", "stream")
    serverFx = love.audio.newSource("/vleaudiofx/serverFX.ogg", "stream")
    
    -- Player character components
    user = User(60, 480)
    princess = Princess(200)
    hasKey = false
    inStock = true
    onGround = true

    -- Spawns enemies for level 1
    enemyTitleScreen = TitleScreenM(890, 290, -60, 900, 290)
    
    -- minus 50 to right boundary to FIX MVMNT SCRPT
    enemy = EnemyMushroom(800, 525, 690, 760, 525)--
    enemy2 = EnemyMushroom(1290, 525, 1200, 1250, 525)
    enemy3 = EnemyMushroom(1440, 375, 1350, 1400, 375)
    enemy4 = EnemyMushroom(2230, 375, 2140, 2190, 375)
    enemy5 = EnemyMushroom(2590, 525, 2500, 2550, 525)
    enemy6 = EnemyMushroom(3190, 525, 3100, 3150, 525)
    enemy7 = EnemyMushroom(3590, -15, 3500, 3550, -25)
    enemy8 = EnemyMushroom(4190, 525, 4100, 4150, 525)
    enemy9 = EnemyMushroom(4290, 525, 4200, 4250, 525)
    enemy10 = EnemyMushroom(5377, 525, 5287, 5337, 525)
    enemy11 = EnemyMushroom(5810, 125, 5720, 5770, 125)
    enemy12 = EnemyMushroom(2650, 125, 2560, 2610, 125)
  
    bEnemy = BEnemyClass(2430, 280, 2340, 2390)
    bEnemy2 = BEnemyClass(3180, 270, 3090, 3140)
    bEnemy3 = BEnemyClass(3690, 355, 3600, 3650)
    bEnemy4 = BEnemyClass(4500, 260, 4410, 4460)
    bEnemy5 = BEnemyClass(4000, 150, 3910, 3960)
    bEnemy6 = BEnemyClass(5000, 350, 4910, 4960)
    bEnemy7 = BEnemyClass(2450, 20, 2360, 2410)
    bEnemy8 = BEnemyClass(5200, 20, 5110, 5160)
    
    -- List of all level 1 enemies
    enemiesList = {enemy, enemy2, enemy3, enemy4, enemy5, bEnemy, enemy6, enemy7, bEnemy2, bEnemy3, enemy8, enemy9, bEnemy4, bEnemy5, enemy10, bEnemy6, enemy11, enemy12, bEnemy7, bEnemy8}
    
   -- Spawns enemies for level 2
    enemyL2 = EnemyMushroom(1200, 875, 1110, 1160, 875)
    enemy2L2 = EnemyMushroom(1400, 875, 1310, 1360, 875)
    enemy3L2 = EnemyMushroom(1800, 875, 1710, 1760, 875)
    enemy4L2 = EnemyMushroom(3590, 725, 3580, 3550, 725)
    enemy5L2 = EnemyMushroom(3630, 725, 3620, 3590, 725)
    enemy6L2 = EnemyMushroom(3430, 525, 3420, 3390, 525)
    enemy7L2 = EnemyMushroom(2000, 875, 1910, 1960, 875)
    enemy8L2 = EnemyMushroom(3100, 725, 3010, 3069, 725)
    enemy9L2 = EnemyMushroom(4250, 725, 4160, 4210, 725)
    enemy10L2 = EnemyMushroom(4450, 1425, 4360, 4410, 1425)
    enemy11L2 = EnemyMushroom(4650, 1425, 4560, 4610, 1425)
    enemy12L2 = EnemyMushroom(4500, 1425, 4410, 4460, 1425)
    enemy13L2 = EnemyMushroom(4300, 125, 4210, 4260, 125)
    enemy14L2 = EnemyMushroom(4500, 125, 4410, 4460, 125)
    enemy15L2 = EnemyMushroom(4200, 125, 4110, 4160, 125)
    enemy16L2 = EnemyMushroom(3500, 125, 3410, 3460, 125)
    enemy17L2 = EnemyMushroom(3350, 325, 3260, 3310, 325)
    enemy18L2 = EnemyMushroom(3250, 325, 3160, 3210, 325)
    enemy19L2 = EnemyMushroom(5480, 725, 5470, 5440, 725)
    enemy20L2 = EnemyMushroom(5840, 575, 5830, 5800, 575)
    
    bEnemyL2 = BEnemyClass(2100, 710, 2010, 2060)
    bEnemy2L2 = BEnemyClass(1480, 650, 1390, 1440)
    bEnemy3L2 = BEnemyClass(3100, 640, 3010, 3060)
    bEnemy4L2 = BEnemyClass(3500, 235, 3410, 3460)
    bEnemy5L2 = BEnemyClass(3600, 25, 3510, 3560)
    bEnemy6L2 = BEnemyClass(4500, 25, 4410, 4460)
    bEnemy7L2 = BEnemyClass(5540, 600, 5490, 5500)

    -- List of all level 2 enemies
    enemiesList2 = {enemyL2, enemy2L2, enemy3L2, enemy4L2, enemy5L2, enemy6L2, enemy7L2, enemy8L2, enemy9L2, enemy10L2, enemy11L2, enemy12L2, enemy13L2, enemy14L2, enemy15L2, enemy16L2, enemy17L2, enemy18L2, enemy19L2, enemy20L2, bEnemyL2, bEnemy2L2, bEnemy3L2, bEnemy4L2, bEnemy5L2, bEnemy6L2, bEnemy7L2}
    
    -- Spawns enemies for level 3
    enemyL3 = EnemyMushroom(1700, 525, 1610, 1660, 525)
    enemy2L3 = EnemyMushroom(1800, 525, 1710, 1760, 525)
    enemy3L3 = EnemyMushroom(1800, 325, 1710, 1760, 325)
    enemy4L3 = EnemyMushroom(1900, 325, 1810, 1860, 325)
    enemy5L3 = EnemyMushroom(1700, 325, 1610, 1660, 325)
    enemy6L3 = EnemyMushroom(3000, 325, 2910, 2960, 325)
    enemy7L3 = EnemyMushroom(3100, 325, 3010, 3060, 325)
    enemy8L3 = EnemyMushroom(3150, 325, 3050, 3100, 325)
    enemy9L3 = EnemyMushroom(3100, 525, 3000, 3050, 525)
    enemy10L3 = EnemyMushroom(3150, 525, 3050, 3100, 525)
    enemy11L3 = EnemyMushroom(3250, 525, 3150, 3200, 525)
    enemy12L3 = EnemyMushroom(3900, 325, 3800, 3850, 325)
    enemy13L3 = EnemyMushroom(1900, 825, 1810, 1860, 825)
    enemy14L3 = EnemyMushroom(2300, 825, 2210, 2260, 825)
    enemy15L3 = EnemyMushroom(2500, 825, 2410, 2460, 825)
    enemy16L3 = EnemyMushroom(4560, 825, 4470, 4530, 825)
    enemy17L3 = EnemyMushroom(4660, 825, 4570, 4630, 825)
    enemy18L3 = EnemyMushroom(3030, 825, 2940, 3000, 825)
    enemy19L3 = EnemyMushroom(5310, 575, 5220, 5280, 575)
    enemy20L3 = EnemyMushroom(5330, 575, 5240, 5300, 575)
    enemy21L3 = EnemyMushroom(5260, 575, 5170, 5230, 575)
    enemy22L3 = EnemyMushroom(4690, 575, 4600, 4660, 575)
    enemy23L3 = EnemyMushroom(5940, 825, 5930, 5900, 825)
    enemy24L3 = EnemyMushroom(4730, 575, 4720, 4700, 575)
    enemy25L3 = EnemyMushroom(6140, 825, 6130, 6100, 825)
    enemy26L3 = EnemyMushroom(6090, 375, 6080, 6050, 375)
    enemy27L3 = EnemyMushroom(6040, 375, 6030, 6000, 375)
    enemy28L3 = EnemyMushroom(6450, 525, 6440, 6410, 525)
    enemy29L3 = EnemyMushroom(6550, 525, 6540, 6510, 525)
    enemy30L3 = EnemyMushroom(6650, 525, 6640, 6610, 525)
    enemy31L3 = EnemyMushroom(6650, 525, 6640, 6610, 525)
    enemy32L3 = EnemyMushroom(6690, 525, 6680, 6650, 525)
    enemy33L3 = EnemyMushroom(3800, 325, 3700, 3750, 325)
    
    bEnemyL3 = BEnemyClass(1800, 50, 1710, 1760)
    bEnemy2L3 = BEnemyClass(3800, 475, 3700, 3750)
    bEnemy3L3 = BEnemyClass(3850, 475, 3750, 3800)
    bEnemy4L3 = BEnemyClass(3300, 675, 3200, 3250)
    bEnemy5L3 = BEnemyClass(4760, 725, 4670, 4730)
    bEnemy6L3 = BEnemyClass(5460, 425, 5370, 5430)
    bEnemy7L3 = BEnemyClass(5260, 50, 5170, 5230)
    bEnemy8L3 = BEnemyClass(6300, 50, 6210, 6270)
    
    -- List of all level 3 enemies
    enemiesList3 = {enemyL3, enemy2L3, enemy3L3, enemy4L3, enemy5L3, enemy6L3, enemy7L3, enemy8L3, enemy9L3, enemy10L3, enemy11L3, enemy12L3, enemy13L3, enemy14L3, enemy15L3, enemy16L3, enemy17L3, enemy18L3, enemy19L3, enemy20L3, enemy21L3, enemy22L3, enemy23L3, enemy24L3, enemy25L3, enemy26L3, enemy27L3, enemy28L3, enemy29L3, enemy30L3, enemy31L3, enemy32L3, enemy33L3, bEnemyL3, bEnemy2L3, bEnemy3L3, bEnemy4L3, bEnemy5L3, bEnemy6L3, bEnemy7L3, bEnemy8L3}
    
    -- Boss timer
    bossTimer = Timer()
    bossTimer2 = Timer()
    bossTimer3 = Timer()
    bossTimer4 = Timer()
    
    -- Level 1 timers
    titleEnemyTimer = Timer()
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
    
    -- Title screen animation enemy
    titleEnemyTimer:every(2, function() enemyTitleScreen:movement() end)
    introTimer:after(2, function() startButtonClass:introEnd() end)
    
    -- Level 2 timers
    enemyL2Timer = Timer()
    enemy2L2Timer = Timer()
    enemy3L2Timer = Timer()
    enemy4L2Timer = Timer()
    enemy5L2Timer = Timer()
    enemy6L2Timer = Timer()
    enemy7L2Timer = Timer()
    enemy8L2Timer = Timer()
    enemy9L2Timer = Timer()
    enemy10L2Timer = Timer()
    enemy11L2Timer = Timer()
    enemy12L2Timer = Timer()
    enemy13L2Timer = Timer()
    enemy14L2Timer = Timer()
    enemy15L2Timer = Timer()
    enemy16L2Timer = Timer()
    enemy17L2Timer = Timer()
    enemy18L2Timer = Timer()
    enemy19L2Timer = Timer()
    enemy20L2Timer = Timer()
    
    bEnemyL2Timer = Timer()
    bEnemy2L2Timer = Timer()
    bEnemy3L2Timer = Timer()
    bEnemy4L2Timer = Timer()
    bEnemy5L2Timer = Timer()
    bEnemy6L2Timer = Timer()
    bEnemy7L2Timer = Timer()
    
    -- Level 3 timers
    enemyL3Timer = Timer()
    enemy2L3Timer = Timer()
    enemy3L3Timer = Timer()
    enemy4L3Timer = Timer()
    enemy5L3Timer = Timer()
    enemy6L3Timer = Timer()
    enemy7L3Timer = Timer()
    enemy8L3Timer = Timer()
    enemy9L3Timer = Timer()
    enemy10L3Timer = Timer()
    enemy11L3Timer = Timer()
    enemy12L3Timer = Timer()
    enemy13L3Timer = Timer()
    enemy14L3Timer = Timer()
    enemy15L3Timer = Timer()
    enemy16L3Timer = Timer()
    enemy17L3Timer = Timer()
    enemy18L3Timer = Timer()
    enemy19L3Timer = Timer()
    enemy20L3Timer = Timer()
    enemy21L3Timer = Timer()
    enemy22L3Timer = Timer()
    enemy23L3Timer = Timer()
    enemy24L3Timer = Timer()
    enemy25L3Timer = Timer()
    enemy26L3Timer = Timer()
    enemy27L3Timer = Timer()
    enemy28L3Timer = Timer()
    enemy29L3Timer = Timer()
    enemy30L3Timer = Timer()
    enemy31L3Timer = Timer()
    enemy32L3Timer = Timer()
    enemy33L3Timer = Timer()
    
    bEnemyL3Timer = Timer()
    bEnemy2L3Timer = Timer()
    bEnemy3L3Timer = Timer()
    bEnemy4L3Timer = Timer()
    bEnemy5L3Timer = Timer()
    bEnemy6L3Timer = Timer()
    bEnemy7L3Timer = Timer()
    bEnemy8L3Timer = Timer()
    
    -- Boss timer
    bossTimer:every(4, function() boss:jump(dt) end)
    bossTimer2:every(9, function() boss:movement(dt) end)
    
    -- Level 1 Timers
    -- Mushroom Enemies
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
  
    -- Bee Timers
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
    
    --Level 2 Enemy Timers
    -- Mushroom Enemies
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
        wait(4)
        enemy5L2Timer:every(1.2, function() enemy5L2:movement() end)
    end)
    enemy6L2Timer:script(function(wait)
        wait(2)
        enemy6L2Timer:every(0.6, function() enemy6L2:movement() end)
    end)
    enemy7L2Timer:script(function(wait)
        wait(2.2)
        enemy7L2Timer:every(2, function() enemy7L2:movement() end)
    end)
    enemy8L2Timer:script(function(wait)
        wait(2.2)
        enemy8L2Timer:every(2, function() enemy8L2:movement() end)
    end)
    enemy9L2Timer:script(function(wait)
        wait(2)
        enemy9L2Timer:every(1.2, function() enemy9L2:movement() end)
    end)
    enemy10L2Timer:script(function(wait)
        wait(2.2)
        enemy10L2Timer:every(2, function() enemy10L2:movement() end)
    end)
    enemy11L2Timer:script(function(wait)
        wait(4.5)
        enemy11L2Timer:every(2, function() enemy11L2:movement() end)
    end)
    enemy12L2Timer:script(function(wait)
        wait(1.8)
        enemy12L2Timer:every(2, function() enemy12L2:movement() end)
    end)
    enemy13L2Timer:script(function(wait)
        wait(2.2)
        enemy13L2Timer:every(2, function() enemy13L2:movement() end)
    end)
    enemy14L2Timer:script(function(wait)
        wait(4.4)
        enemy14L2Timer:every(2, function() enemy14L2:movement() end)
    end)
    enemy15L2Timer:script(function(wait)
        wait(3.8)
        enemy15L2Timer:every(2, function() enemy15L2:movement() end)
    end)
    enemy16L2Timer:script(function(wait)
        wait(1.4)
        enemy16L2Timer:every(2, function() enemy16L2:movement() end)
    end)
    enemy17L2Timer:script(function(wait)
        wait(2.8)
        enemy17L2Timer:every(2, function() enemy17L2:movement() end)
    end)
    enemy18L2Timer:script(function(wait)
        wait(1.7)
        enemy18L2Timer:every(2, function() enemy18L2:movement() end)
    end)
    enemy19L2Timer:script(function(wait)
        wait(3)
        enemy19L2Timer:every(0.6, function() enemy19L2:movement() end)
    end)
    enemy20L2Timer:script(function(wait)
        wait(1)
        enemy20L2Timer:every(1.2, function() enemy20L2:movement() end)
    end)
  
    --Bee Timers
    bEnemyL2Timer:script(function(wait)
        wait(2.1)
        bEnemyL2Timer:every(2, function() bEnemyL2:movement() end)
    end)
    bEnemy2L2Timer:script(function(wait)
        wait(3.4)
        bEnemy2L2Timer:every(2, function() bEnemy2L2:movement() end)
    end)
    bEnemy3L2Timer:script(function(wait)
        wait(1.1)
        bEnemy3L2Timer:every(2, function() bEnemy3L2:movement() end)
    end)
    bEnemy4L2Timer:script(function(wait)
        wait(1.8)
        bEnemy4L2Timer:every(2, function() bEnemy4L2:movement() end)
    end)
    bEnemy5L2Timer:script(function(wait)
        wait(3.2)
        bEnemy5L2Timer:every(2, function() bEnemy5L2:movement() end)
    end)
    bEnemy6L2Timer:script(function(wait)
        wait(2.4)
        bEnemy6L2Timer:every(2, function() bEnemy6L2:movement() end)
    end)
    bEnemy7L2Timer:script(function(wait)
        wait(1)
        bEnemy7L2Timer:every(1.5, function() bEnemy7L2:movement() end)
    end)
  
    --Level 3 Enemy Timers
    -- Mushroom Enemies
    enemyL3Timer:script(function(wait)
        wait(2.2)
        enemyL3Timer:every(2, function() enemyL3:movement() end)
    end)
    enemy2L3Timer:script(function(wait)
        wait(3.5)
        enemy2L3Timer:every(2, function() enemy2L3:movement() end)
    end)
    enemy3L3Timer:script(function(wait)
        wait(1.7)
        enemy3L3Timer:every(2, function() enemy3L3:movement() end)
    end)
    enemy4L3Timer:script(function(wait)
        wait(4.1)
        enemy4L3Timer:every(2, function() enemy4L3:movement() end)
    end)
    enemy5L3Timer:script(function(wait)
        wait(2.8)
        enemy5L3Timer:every(2, function() enemy5L3:movement() end)
    end)
    enemy6L3Timer:script(function(wait)
        wait(3.2)
        enemy6L3Timer:every(2, function() enemy6L3:movement() end)
    end)
    enemy7L3Timer:script(function(wait)
        wait(4.1)
        enemy7L3Timer:every(2, function() enemy7L3:movement() end)
    end)
    enemy8L3Timer:script(function(wait)
        wait(1.2)
        enemy8L3Timer:every(2, function() enemy8L3:movement() end)
    end)
    enemy9L3Timer:script(function(wait)
        wait(5.4)
        enemy9L3Timer:every(2, function() enemy9L3:movement() end)
    end)
    enemy10L3Timer:script(function(wait)
        wait(2.8)
        enemy10L3Timer:every(2, function() enemy10L3:movement() end)
    end)
    enemy11L3Timer:script(function(wait)
        wait(1.2)
        enemy11L3Timer:every(2, function() enemy11L3:movement() end)
    end)
    enemy12L3Timer:script(function(wait)
        wait(2.5)
        enemy12L3Timer:every(2, function() enemy12L3:movement() end)
    end)
    enemy13L3Timer:script(function(wait)
        wait(4.2)
        enemy13L3Timer:every(2, function() enemy13L3:movement() end)
    end)
    enemy14L3Timer:script(function(wait)
        wait(1.2)
        enemy14L3Timer:every(2, function() enemy14L3:movement() end)
    end)
    enemy15L3Timer:script(function(wait)
        wait(2.4)
        enemy15L3Timer:every(2, function() enemy15L3:movement() end)
    end)
    enemy16L3Timer:script(function(wait)
        wait(3.8)
        enemy16L3Timer:every(2, function() enemy16L3:movement() end)
    end)
    enemy17L3Timer:script(function(wait)
        wait(4.9)
        enemy17L3Timer:every(2, function() enemy17L3:movement() end)
    end)
    enemy18L3Timer:script(function(wait)
        wait(2.2)
        enemy18L3Timer:every(2, function() enemy18L3:movement() end)
    end)
    enemy19L3Timer:script(function(wait)
        wait(3.5)
        enemy19L3Timer:every(2, function() enemy19L3:movement() end)
    end)
    enemy20L3Timer:script(function(wait)
        wait(5.5)
        enemy20L3Timer:every(2, function() enemy20L3:movement() end)
    end)
    enemy21L3Timer:script(function(wait)
        wait(3.7)
        enemy21L3Timer:every(1.2, function() enemy21L3:movement() end)
    end)
    enemy22L3Timer:script(function(wait)
        wait(2.5)
        enemy22L3Timer:every(1.2, function() enemy22L3:movement() end)
    end)
    enemy23L3Timer:script(function(wait)
        wait(3.1)
        enemy23L3Timer:every(2, function() enemy23L3:movement() end)
    end)
    enemy24L3Timer:script(function(wait)
        wait(4.2)
        enemy24L3Timer:every(0.6, function() enemy24L3:movement() end)
    end)
    enemy25L3Timer:script(function(wait)
        wait(5.7)
        enemy25L3Timer:every(2, function() enemy25L3:movement() end)
    end)
    enemy26L3Timer:script(function(wait)
        wait(2.2)
        enemy26L3Timer:every(1.2, function() enemy26L3:movement() end)
    end)
    enemy27L3Timer:script(function(wait)
        wait(4.2)
        enemy27L3Timer:every(0.6, function() enemy27L3:movement() end)
    end)
    enemy28L3Timer:script(function(wait)
        wait(2.4)
        enemy28L3Timer:every(0.6, function() enemy28L3:movement() end)
    end)
    enemy29L3Timer:script(function(wait)
        wait(3.6)
        enemy29L3Timer:every(1.2, function() enemy29L3:movement() end)
    end)
    enemy30L3Timer:script(function(wait)
        wait(2.6)
        enemy30L3Timer:every(2, function() enemy30L3:movement() end)
    end)
    enemy31L3Timer:script(function(wait)
        wait(3.4)
        enemy31L3Timer:every(1.2, function() enemy31L3:movement() end)
    end)
    enemy32L3Timer:script(function(wait)
        wait(6.7)
        enemy32L3Timer:every(1.2, function() enemy32L3:movement() end)
    end)
    enemy33L3Timer:script(function(wait)
        wait(3.7)
        enemy33L3Timer:every(1.2, function() enemy33L3:movement() end)
    end)
  
    -- Bee Timers
    bEnemyL3Timer:script(function(wait)
        wait(2)
        bEnemyL3Timer:every(1.5, function() bEnemyL3:movement() end)
    end)
    bEnemy2L3Timer:script(function(wait)
        wait(2)
        bEnemy2L3Timer:every(1.5, function() bEnemy2L3:movement() end)
    end)
    bEnemy3L3Timer:script(function(wait)
        wait(4)
        bEnemy3L3Timer:every(1.5, function() bEnemy3L3:movement() end)
    end)
    bEnemy4L3Timer:script(function(wait)
        wait(2)
        bEnemy4L3Timer:every(1.5, function() bEnemy4L3:movement() end)
    end)
    bEnemy5L3Timer:script(function(wait)
        wait(4)
        bEnemy5L3Timer:every(0.8, function() bEnemy5L3:movement() end)
    end)
    bEnemy6L3Timer:script(function(wait)
        wait(2)
        bEnemy6L3Timer:every(1.5, function() bEnemy6L3:movement() end)
    end)
    bEnemy7L3Timer:script(function(wait)
        wait(4)
        bEnemy7L3Timer:every(1.5, function() bEnemy7L3:movement() end)
    end)
    bEnemy8L3Timer:script(function(wait)
        wait(2)
        bEnemy8L3Timer:every(1.5, function() bEnemy8L3:movement() end)
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
    walls3 = {}
    objects = {}
    objects2 = {}
    objects3 = {}
    
    -- Projectiles
    projectileList = {}
    leftProjectileList = {}
    
    inStock = true
    pStock = 6
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
    fadeCurrentFrame6 = 1
    
    -- Enemy animations
    enemyJumpImage = love.graphics.newImage("/art/enemyjumpleft.png")
    enemyJumpImageRight = love.graphics.newImage("/art/enemyjumpright.png")
    bEnemyFlyRight = love.graphics.newImage("/art/benemyflyright.png")
    bEnemyFlyLeft = love.graphics.newImage("/art/benemyfly.png")
    
    eFrames = {}
    bEFrames = {}
    fEStretchFrames = {}
    fEMoveFrames = {}
    bossFramesLeft = {}
    heartFrames = {}
    princessFramesLeft = {}
    princessFramesRight = {}
    
    local eWidth = enemyJumpImage:getWidth()
    local eHeight = enemyJumpImage:getHeight()
    local eQuadW = 60
    local eQuadH = -20
    
    local bossWidth = bossRunLeftImage:getWidth()
    local bossHeight = bossRunLeftImage:getHeight()
    local bossQuadWidth = bossWidth / 2
    
    local heartWidth = enemyJumpImage:getWidth()
    local heartHeight = enemyJumpImage:getHeight()
    local heartQuadW = 60
    local heartQuadH = -20
    
    local princessWidth = princessRunLeftImage:getWidth()
    local princessHeight = princessRunLeftImage:getHeight()
    local princessQuadW = 60
    local princessQuadH = -20
    
    -- Mushroom Class animation frames
    for i=0, 4 do
        table.insert(eFrames, love.graphics.newQuad(10 + i * (eQuadW + 15), 6, eQuadW, (eHeight - 16), eWidth, eHeight))
    end
    
    -- Bee Enemy Class frames
    for i=0, 4 do
        table.insert(bEFrames, love.graphics.newQuad(6 + i * (eQuadW + 15), 9, eQuadW + 8, (eHeight - 16), eWidth, eHeight))
    end
    
    -- Boss run frames
    
    for i=0, 2 do
        table.insert(bossFramesLeft, love.graphics.newQuad(6 + i * (bossQuadWidth + 5), 7, bossQuadWidth - 10, (bossHeight - 16), bossWidth + 10, bossHeight))
    end
    
    -- Heart animation frames
    for i=0, 4 do
        table.insert(heartFrames, love.graphics.newQuad(6 + i * (heartQuadW + 15), 9, heartQuadW + 8, (heartHeight - 16), heartWidth, heartHeight))
    end
    
    -- Princess animation frames
    for i=0, 2 do
        table.insert(princessFramesLeft, love.graphics.newQuad(6 + i * (princessQuadW), 6, princessQuadW - 6, (princessHeight - 11), princessWidth, princessHeight))
    end

    -- Music, background, game over screen, font
    homeSong = love.audio.newSource("/art/voidlandtheme.ogg", "stream")
    controlRoomSong = love.audio.newSource("/vleaudiofx/the-control-room.ogg", "stream")
    endSong = love.audio.newSource("/vleaudiofx/endsong.ogg", "stream")
    
    myBackground = love.graphics.newImage("/art/bg.png")
    myBackground2 = love.graphics.newImage("/art/bg2.png")
    myBackground3 = love.graphics.newImage("/art/bg3.png")
    statsCanvas = love.graphics.newCanvas(600, 800)
    
    r,g,b,a = love.graphics.getColor()
    
    font = love.graphics.newFont("/art/Retro Gaming.ttf", 60)
    love.graphics.setFont(font)
    
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
    
    -- Tilemap for level 2
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
    
    for i,v in ipairs(map3) do
        for j,w in ipairs(v) do
            if w == 1 then
                local a = (j-1)*50
                local b = (i-1)*50
                brickWall = false
                grassBlock2 = false
                grassBlock1 = false
                grassBlock3 = false
                dirtBlock = false
                metalBrick = false
                local newWall = Wall(a, b)
                table.insert(walls3, newWall)
            elseif w == 5 then
                local a = (j-1)*50
                local b = (i-1)*50
                brickWall = false
                grassBlock2 = false
                grassBlock1 = false
                grassBlock3 = false
                dirtBlock = false
                metalBrick = true
                local newWall = Wall(a, b)
                table.insert(walls3, newWall)
            
            -- Game objects (anything that isn't a wall)
            elseif w == 3 then
                local a = (j-1)*50
                local b = (i-1)*50
                grassBlock2 = false
                grassBlock1 = false
                grassBlock3 = false
                brickWall = false
                dirtBlock = false
                metalBrick = false
                local newCoin = Coin(a, b)
                table.insert(objects3, newCoin)
            elseif w == 4 then
                local a = (j-1)*50
                local b = (i-1)*50
                grassBlock2 = false
                grassBlock1 = false
                grassBlock3 = false
                brickWall = false
                dirtBlock = false
                metalBrick = false
                local newWrench = Wrench(a, b)
                table.insert(objects3, newWrench)
            elseif w == 8 then
                local a = (j-1)*50
                local b = (i-1)*50
                grassBlock2 = false
                grassBlock1 = false
                grassBlock3 = false
                brickWall = false
                dirtBlock = false
                metalBrick = false
                local newMushroom = Mushroom(a, b)
                table.insert(objects3, newMushroom)
            elseif w == 9 then
                local a = (j-1)*50
                local b = (i-1)*50
                grassBlock2 = false
                grassBlock1 = false
                grassBlock3 = false
                brickWall = false
                dirtBlock = false
                metalBrick = false
                local newKey = Key(a, b)
                table.insert(objects3, newKey)
            elseif w == 10 then
                local a = (j-1)*50
                local b = (i-1)*50
                grassBlock2 = false
                grassBlock1 = false
                grassBlock3 = false
                brickWall = false
                dirtBlock = false
                metalBrick = false
                local newGate = Gate(a, b)
                table.insert(walls3, newGate)
            end
        end
    end
end

function love.update(dt)
    -- Fixes bug where character would fall off screen when game window was moved
    dt = math.min(dt, 1/10)

    -- Stops/starts audio during certain events
    if gameLevel == 3 then
        homeSong:setLooping(false)
        love.audio.stop(homeSong)
    end
    
    if endBool == true or gameLevel == 2 or gameLevel == 3 or start == false or alive == false or drawLevel3Intro == true or drawLevel2Intro == true or drawIntro == true then
        love.audio.stop(user.eatFx)
        love.audio.stop(user.dashFx)
        love.audio.stop(user.jumpFx)
        love.audio.stop(user.projectileFx)
    end
    
    if alive == true and gameLevel ~= 3 and gameLevel ~= 3.5 then
        homeSong:setLooping(true)
        homeSong:setVolume(0.3)
        homeSong:play()
    elseif alive == true and gameLevel == 3.5 then
        homeSong:setLooping(false)
        love.audio.stop(homeSong)
        l3SongTimer:script(function(wait)
            wait(1)
            l3SongTimer:after(1, function() finalSongPlay() end)
        end)
    end
    
    if endBool == true then
        controlRoomSong:setLooping(false)
        love.audio.stop(controlRoomSong)
    end
    
    if playEndFxBool == true and endBool == true then
        love.audio.stop()
        serverFx:setLooping(false)
        serverFx:setVolume(0.6)
        serverFx:play()
        endSong:setLooping(false)
        endSong:setVolume(0.6)
        endSong:play()
        playEndFxBool = false
    end
    
    --Button updates
    startButton:update(dt)
    controlsButton:update(dt)
    storyButton:update(dt)
    
    enemyTitleScreen:update(dt)
    
    -- Calls to update the state of characters in the game
    user:update(dt)
    princess:update(dt)
    
    actionTimer:update(dt)
    kissEndTimer:update(dt)
    faceRightTimer:update(dt)
    walkOutTimer:update(dt)
    endTextTimer:update(dt)
    reloadTextTimer:update(dt)
    
    l3SongTimer:update(dt)
    gameOverFxTimer:update(dt)
    endRunTimer:update(dt)
    resetGameTimer:update(dt)
    
    -- Destroys timers when resetting from endgame
    if resetGameTimer == true then
        if love.keyboard.isDown('r') then
            resetGameTimer:destroy()
        end
    end
    if endGameFxBool == true then
        gameOverFxTimer:destroy()
    end
    
    -- Updates boss
    if bossBool == true then
        bossTimer:update(dt)
        bossTimer2:update(dt)
        bossTimer3:update(dt)
        bossTimer4:update(dt)
        boss:update(dt)
    end
    
    --Updates various elements of the game
    if gameLevel >= 3 then
        computer:update(dt)
    end
    
    shopKeep:update(dt)
    traveler:update(dt)
    shopButton1:update(dt)
    shopButton2:update(dt)
    
    if user.y ~= user.last.y then
        onGround = false
    end
    
    -- Updates enemies
    if gameLevel == 1 then
        for i,enemy in ipairs(enemiesList) do
            enemy:update(dt)
        end
    elseif gameLevel == 2.5 then
        for i,enemy in ipairs(enemiesList2) do
            enemy:update(dt)
        end
    elseif gameLevel == 3.5 then
        for i,enemy in ipairs(enemiesList3) do
            enemy:update(dt)
        end
    end
    
    if start == false then
        startTimer:update(dt)
        titleEnemyTimer:update(dt)
        level1textTimer:update(dt)
        introTimer:update(dt)
        introFadeOutTimer:update(dt)
    end
    
    if gameLevel == 2 or gameLevel == 2.5 then
        level2TextTimer:update(dt)
        level2ScreenEndTimer:update(dt)
    elseif gameLevel == 3 or gameLevel == 3.5 then
        level3TextTimer:update(dt)
        level3ScreenEndTimer:update(dt)
    end
    
    if gameLevel == 1 then
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
    end
    if gameLevel == 2.5 then
    --lvl 2 timers
        enemyL2Timer:update(dt)
        enemy2L2Timer:update(dt)
        enemy3L2Timer:update(dt)
        enemy4L2Timer:update(dt)
        enemy5L2Timer:update(dt)
        enemy6L2Timer:update(dt)
        enemy7L2Timer:update(dt)
        enemy8L2Timer:update(dt)
        enemy9L2Timer:update(dt)
        enemy10L2Timer:update(dt)
        enemy11L2Timer:update(dt)
        enemy12L2Timer:update(dt)
        enemy13L2Timer:update(dt)
        enemy14L2Timer:update(dt)
        enemy15L2Timer:update(dt)
        enemy16L2Timer:update(dt)
        enemy17L2Timer:update(dt)
        enemy18L2Timer:update(dt)
        enemy19L2Timer:update(dt)
        enemy20L2Timer:update(dt)
        
        bEnemyL2Timer:update(dt)
        bEnemy2L2Timer:update(dt)
        bEnemy3L2Timer:update(dt)
        bEnemy4L2Timer:update(dt)
        bEnemy5L2Timer:update(dt)
        bEnemy6L2Timer:update(dt)
        bEnemy7L2Timer:update(dt)
    end
    if gameLevel == 3.5 then
        enemyL3Timer:update(dt)
        enemy2L3Timer:update(dt)
        enemy3L3Timer:update(dt)
        enemy4L3Timer:update(dt)
        enemy5L3Timer:update(dt)
        enemy6L3Timer:update(dt)
        enemy7L3Timer:update(dt)
        enemy8L3Timer:update(dt)
        enemy9L3Timer:update(dt)
        enemy10L3Timer:update(dt)
        enemy11L3Timer:update(dt)
        enemy12L3Timer:update(dt)
        enemy13L3Timer:update(dt)
        enemy14L3Timer:update(dt)
        enemy15L3Timer:update(dt)
        enemy16L3Timer:update(dt)
        enemy17L3Timer:update(dt)
        enemy18L3Timer:update(dt)
        enemy19L3Timer:update(dt)
        enemy20L3Timer:update(dt)
        enemy21L3Timer:update(dt)
        enemy22L3Timer:update(dt)
        enemy23L3Timer:update(dt)
        enemy24L3Timer:update(dt)
        enemy25L3Timer:update(dt)
        enemy26L3Timer:update(dt)
        enemy27L3Timer:update(dt)
        enemy28L3Timer:update(dt)
        enemy29L3Timer:update(dt)
        enemy30L3Timer:update(dt)
        enemy31L3Timer:update(dt)
        enemy32L3Timer:update(dt)
        enemy33L3Timer:update(dt)
        
        bEnemyL3Timer:update(dt)
        bEnemy2L3Timer:update(dt)
        bEnemy3L3Timer:update(dt)
        bEnemy4L3Timer:update(dt)
        bEnemy5L3Timer:update(dt)
        bEnemy6L3Timer:update(dt)
        bEnemy7L3Timer:update(dt)
        bEnemy8L3Timer:update(dt)
    end
    
    -- Updates player timers with dt
    invincibleTimer:update(dt)
    dashTimer:update(dt)
    cooldownTimer:update(dt)
    
    -- Destroys various timers
    if invincible == false then
        invincibleTimer:destroy()
    end
    
    if start == true then
        titleEnemyTimer:destroy()
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
        l3SongTimer:destroy()
    end
    
    -- Destroys enemy timers
    --Level 1 enemies
    if enemy.eAlive == false then
        enemyTimer:destroy()
    
    elseif enemy2.eAlive == false then
        enemy2Timer:destroy()
    
    elseif enemy3.eAlive == false then
        enemy3Timer:destroy()
    
    elseif bEnemy.eAlive == false then
        bEnemyTimer:destroy()
    
    elseif enemy4.eAlive == false then
        enemy4Timer:destroy()
    
    elseif enemy5.eAlive == false then
        enemy5Timer:destroy()
    
    elseif enemy6.eAlive == false then
        enemy6Timer:destroy()
    
    elseif enemy7.eAlive == false then
        enemy7Timer:destroy()
    
    elseif enemy8.eAlive == false then
        enemy8Timer:destroy()
    
    elseif enemy9.eAlive == false then
        enemy9Timer:destroy()
    
    elseif enemy10.eAlive == false then
        enemy10Timer:destroy()
    
    elseif enemy11.eAlive == false then
        enemy11Timer:destroy()
    
    elseif enemy12.eAlive == false then
        enemy12Timer:destroy()
    
    
    elseif bEnemy2.eAlive == false then
        bEnemy2Timer:destroy()
    
    elseif bEnemy3.eAlive == false then
        bEnemy3Timer:destroy()
    
    elseif bEnemy4.eAlive == false then
        bEnemy4Timer:destroy()
    
    elseif bEnemy5.eAlive == false then
        bEnemy5Timer:destroy()
    
    elseif bEnemy5.eAlive == false then
        bEnemy5Timer:destroy()
    
    elseif bEnemy7.eAlive == false then
        bEnemy7Timer:destroy()
    
    elseif bEnemy8.eAlive == false then
        bEnemy8Timer:destroy()
    end
    
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
    if enemy8L2.eAlive == false then
        enemy8L2Timer:destroy()
    end
    if enemy9L2.eAlive == false then
        enemy9L2Timer:destroy()
    end
    if enemy10L2.eAlive == false then
        enemy10L2Timer:destroy()
    end
    if enemy11L2.eAlive == false then
        enemy11L2Timer:destroy()
    end
    if enemy12L2.eAlive == false then
        enemy12L2Timer:destroy()
    end
    if enemy13L2.eAlive == false then
        enemy13L2Timer:destroy()
    end
    if enemy14L2.eAlive == false then
        enemy14L2Timer:destroy()
    end
    if enemy15L2.eAlive == false then
        enemy15L2Timer:destroy()
    end
    if enemy16L2.eAlive == false then
        enemy16L2Timer:destroy()
    end
    if enemy17L2.eAlive == false then
        enemy17L2Timer:destroy()
    end
    if enemy18L2.eAlive == false then
        enemy18L2Timer:destroy()
    end
    if enemy19L2.eAlive == false then
        enemy19L2Timer:destroy()
    end
    if enemy20L2.eAlive == false then
        enemy20L2Timer:destroy()
    end
    
    if bEnemyL2.eAlive == false then
        bEnemyL2Timer:destroy()
    end
    if bEnemy2L2.eAlive == false then
        bEnemy2L2Timer:destroy()
    end
    if bEnemy3L2.eAlive == false then
        bEnemy3L2Timer:destroy()
    end
    if bEnemy4L2.eAlive == false then
        bEnemy4L2Timer:destroy()
    end
    if bEnemy5L2.eAlive == false then
        bEnemy5L2Timer:destroy()
    end
    if bEnemy6L2.eAlive == false then
        bEnemy6L2Timer:destroy()
    end
    if bEnemy7L2.eAlive == false then
        bEnemy7L2Timer:destroy()
    end
    
    -- Level 3 enemies
    if enemyL3.eAlive == false then
        enemyL3Timer:destroy()
    end
    if enemy2L3.eAlive == false then
        enemy2L3Timer:destroy()
    end
    if enemy3L3.eAlive == false then
        enemy3L3Timer:destroy()
    end
    if enemy4L3.eAlive == false then
        enemy4L3Timer:destroy()
    end
    if enemy5L3.eAlive == false then
        enemy5L3Timer:destroy()
    end
    if enemy6L3.eAlive == false then
        enemy6L3Timer:destroy()
    end
    if enemy7L3.eAlive == false then
        enemy7L3Timer:destroy()
    end
    if enemy8L3.eAlive == false then
        enemy8L3Timer:destroy()
    end
    if enemy9L3.eAlive == false then
        enemy9L3Timer:destroy()
    end
    if enemy10L3.eAlive == false then
        enemy10L3Timer:destroy()
    end
    if enemy11L3.eAlive == false then
        enemy11L3Timer:destroy()
    end
    if enemy12L3.eAlive == false then
        enemy12L3Timer:destroy()
    end
    if enemy13L3.eAlive == false then
        enemy13L3Timer:destroy()
    end
    if enemy14L3.eAlive == false then
        enemy14L3Timer:destroy()
    end
    if enemy15L3.eAlive == false then
        enemy15L3Timer:destroy()
    end
    if enemy16L3.eAlive == false then
        enemy16L3Timer:destroy()
    end
    if enemy17L3.eAlive == false then
        enemy17L3Timer:destroy()
    end
    if enemy18L3.eAlive == false then
        enemy18L3Timer:destroy()
    end
    if enemy19L3.eAlive == false then
        enemy19L3Timer:destroy()
    end
    if enemy20L3.eAlive == false then
        enemy20L3Timer:destroy()
    end
    if enemy21L3.eAlive == false then
        enemy21L3Timer:destroy()
    end
    if enemy22L3.eAlive == false then
        enemy22L3Timer:destroy()
    end
    if enemy23L3.eAlive == false then
        enemy23L3Timer:destroy()
    end
    if enemy24L3.eAlive == false then
        enemy24L3Timer:destroy()
    end
    if enemy25L3.eAlive == false then
        enemy25L3Timer:destroy()
    end
    if enemy26L3.eAlive == false then
        enemy26L3Timer:destroy()
    end
    if enemy27L3.eAlive == false then
        enemy27L3Timer:destroy()
    end
    if enemy28L3.eAlive == false then
        enemy28L3Timer:destroy()
    end
    if enemy29L3.eAlive == false then
        enemy29L3Timer:destroy()
    end
    if enemy30L3.eAlive == false then
        enemy30L3Timer:destroy()
    end
    if enemy31L3.eAlive == false then
        enemy31L3Timer:destroy()
    end
    if enemy32L3.eAlive == false then
        enemy32L3Timer:destroy()
    end
    if enemy33L3.eAlive == false then
        enemy33L3Timer:destroy()
    end
    
    if bEnemyL3.eAlive == false then
        bEnemyL3Timer:destroy()
    end
    if bEnemy2L3.eAlive == false then
        bEnemy2L3Timer:destroy()
    end
    if bEnemy3L3.eAlive == false then
        bEnemy3L3Timer:destroy()
    end
    if bEnemy4L3.eAlive == false then
        bEnemy4L3Timer:destroy()
    end
    if bEnemy5L3.eAlive == false then
        bEnemy5L3Timer:destroy()
    end
    if bEnemy6L3.eAlive == false then
        bEnemy6L3Timer:destroy()
    end
    if bEnemy7L3.eAlive == false then
        bEnemy7L3Timer:destroy()
    end
    if bEnemy8L3.eAlive == false then
        bEnemy8L3Timer:destroy()
    end
    
    -- Dash Timer
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
    elseif gameLevel == 3.5 then
        for i,v in ipairs(walls3) do
            v:update(dt)
        end
        for i,v in ipairs(objects3) do
            v:update(dt)
        end
    end
    
    -- Collision detection for various game elements
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
                    if object.image == coinImage and object.alive == true then
                        love.audio.stop(coinFx)
                        coinFx:setLooping(false)
                        coinFx:setVolume(0.6)
                        coinFx:play()
                    elseif object.image ~= coinImage and object.alive == true then
                        love.audio.stop(itemFx)
                        itemFx:setLooping(false)
                        itemFx:setVolume(0.8)
                        itemFx:play()
                    end
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
                    if object.image == coinImage and object.alive == true then
                        love.audio.stop(coinFx)
                        coinFx:setLooping(false)
                        coinFx:setVolume(0.6)
                        coinFx:play()
                    elseif object.image ~= coinImage and object.alive == true then
                        love.audio.stop(itemFx)
                        itemFx:setLooping(false)
                        itemFx:setVolume(0.8)
                        itemFx:play()
                    end
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
            for i,object in ipairs(objects3) do
                if hitDetect(user, object) then
                    if object.image == coinImage and object.alive == true then
                        love.audio.stop(coinFx)
                        coinFx:setLooping(false)
                        coinFx:setVolume(0.6)
                        coinFx:play()
                    elseif object.image ~= coinImage and object.alive == true then
                        love.audio.stop(itemFx)
                        itemFx:setLooping(false)
                        itemFx:setVolume(0.8)
                        itemFx:play()
                    end
                    object.alive = false
                end
            end
            for i,wall in ipairs(walls3) do
                if walkOutBool == false then
                    collision = user:resolveCollision(wall)
                end
                if wall.image == metalGateImage and wall.alive == false then -- ADD METAL GATE IMAGE HERE
                    bossBool = true
                end
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
    
    -- Keeps projectile count from going below zero and keeps track of if user has any projectiles.
    if pStock <= 0 then
        inStock = false
        if pStock < 0 then
            pStock = 0
        end
    end
    
    -- This allows for gates to be functional and transitions the user from level to level.
    for i,wall in ipairs(walls) do
        if wall.image == gateImage and user.x > wall.x - 150 and user.y > wall.y - 20 and bossBool == false then
            drawGatePrompt = true
            if gameLevel == 3.5 and user.y < 500 then
                drawGatePrompt = false
            end
            if hasKey == true and love.keyboard.isDown("q") and user.x > wall.x - 150 and user.y > wall.y - 150 then
                if gameLevel == 1 then
                    love.audio.stop(doorFx)
                    doorFx:setLooping(false)
                    doorFx:play()
                    gameLevel = 2
                    fadeCurrentFrame = 1
                elseif gameLevel == 2.5 then
                    love.audio.stop(doorFx2)
                    doorFx2:setLooping(false)
                    doorFx2:play()
                    gameLevel = 3
                    fadeCurrentFrame5 = 1
                elseif gameLevel == 3.5 then
                    hasKey = false
                    for i,wall in ipairs (walls3) do
                        if wall.image == metalGateImage or wall.image == gateImage then
                            love.audio.stop(doorFx3)
                            doorFx3:setLooping(false)
                            doorFx3:play()
                            wall.alive = false
                            drawGatePrompt = false
                        end
                    end
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
            love.audio.stop()
            love.event.quit("restart")
        end
    elseif endTextBool == true then
        if love.keyboard.isDown("r") then
            love.event.quit("restart")
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
    fadeCurrentFrame6 = fadeCurrentFrame6 + 45 * dt
    if fadeCurrentFrame6 >= 6 then
        fadeCurrentFrame6 = 6
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
    
    -- Removes all enemies left alive from the previous level
    if gameLevel == 2.5 then
        for i,enemy in ipairs(enemiesList) do
            enemy.eAlive = false
        end
    elseif gameLevel == 3.5 then
        for i,enemy in ipairs(enemiesList2) do
            enemy.eAlive = false
        end
    end
    
    -- Level transition code which animates the fade to black
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
    
    -- Resets game to title screen after endgame animation
    if endBool == true then
        if endTextBool == true then
            user.y = user.y
            resetGameTimer:after(6.8, function() resetGame() end)
        end
    end
    
    -- Plays game over sound
    if alive == false then
        user.gameOverFx:setLooping(false)
        if endGameFxBool == false then
            user.gameOverFx:play()
        end
        love.audio.stop(homeSong)
        love.audio.stop(controlRoomSong)
        gameOverFxTimer:script(function(wait)
            wait(0.2)
            gameOverFxTimer:after(0.2, function() endGameFx() end)
        end)
    end
end

function love.draw()
    --Camera
    if endRunBool == false then
        love.graphics.translate(-user.x + 300, -user.y + 300)
    elseif endRunBool == true then
        love.graphics.translate(-300, -user.y + 300)
    end
    
    -- Draws base game
    if gameLevel == 1 then
        love.graphics.draw(myBackground, -300, -865)
    elseif gameLevel == 2.5 and drawLevel2Text == true then -- potentially causing animatiuon transition interuption
        love.graphics.draw(myBackground2, -300, -760)  
    elseif gameLevel == 3.5 and drawLevel3Text == true and walkOutBool == false then
        love.graphics.draw(myBackground3, -300, -760)
    end
    
    -- Draws shop
    if gameLevel ~= 1 then
        shopKeep:draw()
        shopButton1:draw()
        shopButton2:draw()
    end
    
    -- Draws level 2 npc
    if gameLevel == 2.5 then
        traveler:draw()
    end
    
    -- Draws server at the end of the game
    if gameLevel == 3.5 then
        computer:draw()
    end
    
    -- Draws player character
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
    elseif gameLevel == 3.5 then
        for i,v in ipairs(objects3) do
            if v.alive == true then
                v:draw()
            end
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
    
    -- Draws tilemap
    if gameLevel == 1 then
        for i,v in ipairs(walls) do
            v:draw()
        end
    elseif gameLevel == 2.5 and drawLevel2Text == true then
        for i,v in ipairs(walls2) do
            v:draw()
        end
    elseif gameLevel == 3.5 and drawLevel3Text == true then
        for i,v in ipairs(walls3) do
            if v.alive == true then
                v:draw()
            end
        end
    end
    
    -- Game over screen
    if endBool == true then
        love.graphics.draw(gameOver, 300, 450)
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
    elseif gameLevel == 3.5 then
        for i,enemy in ipairs(enemiesList3) do
            enemy:draw()
        end
        if bossBool == true then
            boss:draw()
        end
    end
    
    -- Draws powerup timer icon
    if user.eating == true then
        love.graphics.draw(mushroomImage, user.x + 10, user.y + 10, 0, 0.6, 0.6)
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
    
    -- Gate prompt
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
        love.graphics.print("v1.0", 385, 568, 0, 0.2, 0.2)
        startButton:draw()
        controlsButton:draw()
        storyButton:draw()
        love.graphics.setColor(r,g,b,a)
        enemyTitleScreen:draw()
    end
    if startFade == true and start == false then
        love.graphics.draw(fadeFrames[math.floor(fadeCurrentFrame)], 0, 0)
    end
    -- Level 1 text
    if level1Text == true and startFade == true then
        love.graphics.print("Area 1", 280, 250)
    end
    
    -- Draws intro
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
    
    -- Level 2 text
    if drawLevel2Intro == true  then
        love.graphics.draw(fadeFrames[math.floor(fadeCurrentFrame4)], user.x -400, user.y - 400)
        if drawLevel2Text == true then
            love.graphics.print("Area 2", user.x - 30, user.y - 60)
        end
    end
    
    -- Level 3 text
    if drawLevel3Intro == true  then
        love.graphics.draw(fadeFrames[math.floor(fadeCurrentFrame5)], user.x -400, user.y - 400)
        if drawLevel3Text == true then
            love.graphics.print("Area 3", user.x - 30, user.y - 80)
            love.graphics.setColor(1, 0, 0)
            love.graphics.print('"The Control Room"', user.x - 90, user.y, 0, 0.5, 0.5)
            love.graphics.setColor(r, g, b, a)
        end
    end
    
    -- Endgame animation
    if endBool == true then
        love.graphics.draw(fadeFrames[math.floor(fadeCurrentFrame6)], user.x -400, user.y - 400)
        endRunTimer:after(2, function() computer:endRun() end)
        if endRunBool == true then
            user:draw()
            princess:draw()
        end
        
        if endTextBool == true then
            love.graphics.setColor(0, 1, 0)
            love.graphics.print("The End", 550, user.y - 50)
        end
    end
    
    -- Shop dialogue
    if drawShopAlert == true and endBool == false then
        love.graphics.draw(textPrompt, user.x, user.y + 190)
        love.graphics.print("Press 'q' to talk.", user.x + 10, user.y + 200, 0, 0.16, 0.16)
    end
    
    -- Npc dialogue
    if drawTravelerAlert == true then
        love.graphics.draw(textPrompt, user.x, user.y + 190)
        love.graphics.print("Press 'q' to talk.", user.x + 10, user.y + 200, 0, 0.16, 0.16)
    end
    
    -- Game over screen
    if alive == false then
          love.graphics.translate(user.x - 300, user.y - 300)
          love.graphics.draw(gameOver, 0, 0)
          love.graphics.setColor(1, 0, 0)
          love.graphics.print("YOU ARE DEAD.", 140, 200)
          love.graphics.print("Press 'r' to reload the game.", 150, 300, 0, 0.5, 0.5)
    end
    
    -- Control Screen
    if controlScreenBool == true then
        love.graphics.draw(gameOver, 0 , 0)
        love.graphics.setColor(0, 1, 0)
        love.graphics.print("'a'/'d' - Walk left or right", 20, 40, 0, 0.2, 0.2)
        love.graphics.print("'space' - Jump", 20, 60, 0, 0.2, 0.2)
        love.graphics.print("'shift' - Dash", 20, 80, 0, 0.2, 0.2)
        love.graphics.print("'k' - Throw wrench", 20, 100, 0, 0.2, 0.2)
        love.graphics.print("'e' - Eat mushroom", 20, 120, 0, 0.2, 0.2)
        love.graphics.print("'q' - Action", 20, 140, 0, 0.2, 0.2)
        love.graphics.print("-Jump directly on top of enemies heads in order to neutralize them.", 20, 160, 0, 0.2, 0.2)
        love.graphics.print("-Hold down 'space' while landing on an enemies head in order to perform", 20, 180, 0, 0.2, 0.2)
        love.graphics.print("a 'super jump'.", 20, 200, 0, 0.2, 0.2)
        love.graphics.print("-Eating makes you unable to harm the creatures; Except for ranged attacks.", 20, 220, 0, 0.2, 0.2)
        love.graphics.print("It also makes you invulnerable to any attacks from the creatures while the mushroom icon is present.", 20, 240, 0, 0.2, 0.2)
        love.graphics.print("-Throw wrenches at creatures to neutralize them.", 20, 260, 0, 0.2, 0.2)
        love.graphics.print("-Collect coins throughout the world to spend at the shop.", 20, 280, 0, 0.2, 0.2)
        love.graphics.print("-Find keys in levels in order to progress through the gate at the end of", 20, 300, 0, 0.2, 0.2)
        love.graphics.print("each area. This allows you to move forward and enter the next area in the game.", 20, 320, 0, 0.2, 0.2)
        love.graphics.print("Press 'escape' to exit the controls screen.", 450, 20, 0, 0.2, 0.2)
    end
    
    -- Story Screen
    if storyScreenBool == true then
        love.graphics.draw(gameOver, 0, 0)
        love.graphics.setColor(0, 1, 0)
        love.graphics.print("The best engineer in Voidland wakes up to a call.", 20, 60, 0, 0.2, 0.2)
        love.graphics.print("The king of Voidland declares a state of emergency, as the server for Voidland's network has ", 20, 80, 0, 0.2, 0.2)
        love.graphics.print("crashed. The server is used by all of Voidland's residents, and is crucial for the resident's", 20, 100, 0, 0.2, 0.2)
        love.graphics.print("day to day lives. The king tells the engineer that after an investigation, it was discovered that", 20, 120, 0, 0.2, 0.2)
        love.graphics.print("the server had been shut down by some of the wild creatures of Voidland.", 20, 140, 0, 0.2, 0.2)
        love.graphics.print("They infiltrated the control room out of protest, because ", 20, 160, 0, 0.2, 0.2)
        love.graphics.print("when the the control room and its server were constructed large portions of", 20, 180, 0, 0.2, 0.2)
        love.graphics.print("the creature's habitats were destroyed.", 20, 200, 0, 0.2, 0.2)
        love.graphics.print("The king reminds the engineer one more time how important this task is.", 20, 220, 0, 0.2, 0.2)
        love.graphics.print("The engineer knows he may get a chance to meet the princess of Voidland", 20, 240, 0, 0.2, 0.2)
        love.graphics.print("if he can do a good job and impress the king.", 20, 260, 0, 0.2, 0.2)
        love.graphics.print("Time to get to work!", 20, 300, 0, 0.2, 0.2)
        love.graphics.print("Press 'escape' to exit the story screen.", 450, 20, 0, 0.2, 0.2)
    end
    
    -- Endgame Screen
    if alive == true and boss.eAlive == false and user.x > 7649 and user .x < 7916 and user.y >= 780 and endBool == false then
        love.graphics.draw(textPrompt, user.x, user.y + 190)
        love.graphics.print("Press 'q' to repair", user.x + 10, user.y + 200, 0, 0.16, 0.16)
        love.graphics.print("the machine.", user.x + 10, user.y + 210, 0, 0.16, 0.16)
    end
end

-- Functions for user input
function love.keypressed(key)
    user:keyInput(key)
    if key == "space" then
        if jumpBool == true then
            user:jump()
        end
    elseif key == "q" then
        if shopTalkBool == true then
            shopTalkCounter = shopTalkCounter + 1
        elseif travelerTalkBool == true then
            travelerCounter = travelerCounter + 1
        end
    end
end

function love.mousepressed(x, y, button)
    if button == 1 and shopTalkCounter == 2 and shopButton1.canBuy == true then
        if coinCount >= 10 then
            coinCount = coinCount - 10
            pStock = pStock + 1
        end
    elseif button == 1 and shopTalkCounter == 2 and shopButton2.canBuy == true then
        if coinCount >= 20 then
            coinCount = coinCount - 20
            mushroomCount = mushroomCount + 1
        end
    end
end

-- Plays level 3 music
function finalSongPlay()
    controlRoomSong:setLooping(true)
    controlRoomSong:setVolume(0.3)
    if endBool == false then
        controlRoomSong:play()
    end
end

-- End game sounds
function endGameFx()
    endGameFxBool = true
    love.audio.stop(doorFx)
    love.audio.stop(controlRoomSong)
end

-- Resets the game to the title screen
function resetGame()
    love.graphics.setColor(r,g,b,a)
    love.audio.stop()
    love.event.quit("restart")
end