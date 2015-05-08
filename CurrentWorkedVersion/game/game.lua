-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads camera script
local camera = require "libs/hump/camera"

-- Loads Hardon Collider script
local HC = require 'libs/hardoncollider'

-- Loads pause script
pause = require 'game/pause'

-- Loads player script
player = require 'game/player'

-- Loads player script
gun = require 'game/gun'

-- Loads player script
ship = require 'game/ship'

-- Loads astroids script
astroids = require 'game/astroids'

-- Creates game as a new gamestate
game = Gamestate.new()


function game:init()

	-- Set up for hardon collider
	Collider = HC(100, on_collision, collision_stop)

	-- Load player
    player:initialize()
    
    -- Load gun
    gun:initialize()

    -- Load ship
    ship:initialize()
	
	------ VARIABLES ------
	-- Camera and zoom vars
	self.Cam = camera(plyr.x, plyr.y, 2.5)
	self.ZoomCam = false
	
	-- Button and arrow areas
	self.BtnY = 600	
	self.BtnX = 530
	self.ArrowX = 480

	-- Welcome message vars
	self.WelcomeButtonArea = false
	self.WelcomeMouseDetect = 0
	self.WelcomeMouseOnBtn = false
	self.Welcome = true

	-- GameOver vars
	self.GameOver = false
	self.GameOverMouseBackArea = false
	self.GameOverMouseDetect = 0
	self.GameOverMouseOnBtn = false
	self.GameOverArrowX = 450
	------ VARIABLES ------

	------ IMAGES ------
	self.GameBG = love.graphics.newImage("images/largespacebg.png")
	------ IMAGES ------

	------ AUDIO ------
	GameMusic = love.audio.newSource("audio/gamemusic.ogg")
	self.GameSelect1M = love.audio.newSource("audio/sel.ogg")
	self.GameEnter = love.audio.newSource("audio/enter.ogg")
	------ AUDIO ------

	------ FONTS ------
	self.InteractFont = love.graphics.newFont("fonts/PressStart.ttf", 20)
	self.BtnFont = love.graphics.newFont("fonts/PressStart.ttf", 30)
	self.GameOverText = love.graphics.newFont("fonts/PressStart.ttf", 20)
	self.GameOverTitleFont = love.graphics.newFont("fonts/PressStart.ttf", 40)
	self.WelcomeFont = love.graphics.newFont("fonts/PressStart.ttf", 20)
	------ FONTS ------
end


function on_collision(dt, shape_a, shape_b)
	player:collision(dt, shape_a, shape_b)
	ship:collision(dt, shape_a, shape_b)
	astroids:collision(dt, shape_a, shape_b)
end

function collision_stop(dt, shape_a, shape_b)
	player:collisionstopped(dt, shape_a, shape_b)
	ship:collisionstopped(dt, shape_a, shape_b)
	astroids:collisionstopped(dt, shape_a, shape_b)
end

function game:keypressed(key)

  	if key == "return" and game.Welcome == true then
  		
  		-- turn game reset off
  		GameReset = false
  		
  		-- turn welcome screen off
  		game.Welcome = false
  		
  		-- play sound effect for enter
  		love.audio.play(game.GameEnter)
  	end

  	if key == "return" and game.GameOver == true then
  		
  		-- play sound effect for enter
  		love.audio.play(game.GameEnter)
    	
  		-- Tells the game script to switch to the menu script
    	Gamestate.switch(menu)
    	
    	-- Stops game music and plays menu music
    	love.audio.play(MenuMusic)
    	MenuMusic:setLooping(true)
   		love.audio.stop(GameMusic)
    	
   		-- Reset the game
    	GameReset = true
  	end

  	-- Pause the game
  	if key == "escape" and Paused == false and game.Welcome == false then
   		Paused = true
   		Resume = false
   		love.mouse.setCursor(cursor)
  	end

  	-- Zoom game camera in by 1
    if key == "x" then --and game.ZoomCam == false and game.GameOver == false then
		game.Cam:zoom(2)
		--game.ZoomCam = true
	end

	-- Zoom game camera back to default
	if key == "z" then --and game.ZoomCam == true and game.GameOver == false then
		game.Cam:zoom(0.5)
		--game.ZoomCam = false
	end

	-- If you are near the ship and you push "e" enter the ship
	if key == "e" and sship.yes == true then
		sship.entered = true
		sship.owned = true
		
		-- change cursor back to pointer
		love.mouse.setCursor(cursor)
	end

	-- If you are in the ship and you push "e" exit the ship
	if key == "e" and sship.entered == true and sship.exited == true then
		sship.entered = false
		sship.exited = false
		
		-- change cursor back to pointer
		love.mouse.setCursor(cursor)
		
		-- Stop all ship sounds
		love.audio.stop(ship.IdleSound)
		love.audio.stop(ship.ThrustSound)
		love.audio.stop(ship.BoostSound)
	end

	-- If you are near the gun and you push "e" pick up the gun
	if key == "e" and pistol.yes == true then
		pistol.HaveGun = true
	end

	-- If you have the gun and you push "q" then drop the gun
	if key == "q" and pistol.HaveGun == true and sship.entered == false then
		pistol.HaveGun = false
	end
end

function game:mousepressed(mx, my, button)

	-- Update the mousepressed of the gun
	gun:shooting(mx, my, button)
end

function game:update(dt)

	------ CAMERA ------
	dx,dy = (plyr.x) - game.Cam.x, (plyr.y) - game.Cam.y
	game.Cam:move(dx/2, dy/2)
	mx1,my1 = game.Cam:mousepos()
	------ CAMERA ------

	-- Update player
	player:update(dt)
	player:health(dt)
	
	-- Update gun
	gun:update(dt)

	-- Update ship
	ship:update(dt)
	ship:health(dt)

	Collider:update(dt)

    -- if game is paused switch to the pause screen
	if Paused == true then
		Gamestate.switch(pause)

		-- Stop the ship idle sound for when you go to pause screen
		love.audio.stop(ship.IdleSound)
	end 

	-- Reset the game back to default for when you start a new game
	if GameReset == true then

		-- Reset player
		plyr.y = 400
		plyr.x = 800
		plyr.movementstop = false
		plyr.speed = 70
		plyr.health = 100
		player.Tired = false
		player.TiredTime = 0 
		player.Sprint = false
		player.SprintTime = 0

		-- Reset gun
		pistol.GunY = plyr.y
		pistol.GunX = plyr.x
		pistol.HaveGun = false
		pistol.yes = false
		pistol.itemx = 750
		pistol.itemy = 380
		gun.ShotTime = 0
		gun.ShotTimePlus = 0
		gun.Bullets = {}
		gun.GunShot = false
		gun.GunShot1 = false

		-- Reset ship
		sship.x = 456
		sship.y = 490
		sship.health = 200
		sship.entered = false
		sship.yes = false
		sship.owned = false
		sship.exited = false
		sship.dead = false
		ship.BoostTired = false
		ship.BoostTiredTime = 0 
		ship.Boost = false
		ship.BoostTime = 0

		-- Reset game vars
		game.Cam = camera(plyr.x, plyr.y, 2.5)
		game.ZoomCam = false
		Paused = false
		game.Welcome = true
		game.GameOver = false
		game.GameOverMouseBackArea = false
		game.GameOverMouseDetect = 0
		game.GameOverMouseOnBtn = false
		game.GameOverArrowX = 450
		
		-- Reset hardon collider hit boxes
		Collider = HC(100, on_collision, collision_stop)
		plyr.bb = Collider:addRectangle(plyr.x, plyr.y, plyr.w, plyr.h)
		sship.bb = Collider:addRectangle(sship.x, sship.y, sship.w, sship.h)
		pistol.bb = Collider:addRectangle(pistol.itemx, pistol.itemy,24,24)

		wallT = Collider:addRectangle(274, 192, 924, 16)
    	wallB = Collider:addRectangle(274, 1136, 924, 16)
    	wallL = Collider:addRectangle(256, 192, 16, 960)
    	wallR = Collider:addRectangle(1200, 192, 16, 960)

		-- Reset/spawn astroids
		astroids:initialize()
		rock1 = astroids:spawn()
		rock2 = astroids:spawn()
		rock3 = astroids:spawn()
		rock4 = astroids:spawn()
		rock5 = astroids:spawn()
		rock6 = astroids:spawn()
		rock7 = astroids:spawn()
		rock8 = astroids:spawn()
		rock9 = astroids:spawn()
		rock10 = astroids:spawn()
		rock11 = astroids:spawn()
		rock12 = astroids:spawn()
		rock13 = astroids:spawn()
		rock14 = astroids:spawn()
		rock15 = astroids:spawn()
		rock16 = astroids:spawn()
		rock17 = astroids:spawn()
		rock18 = astroids:spawn()
		rock19 = astroids:spawn()
		rock20 = astroids:spawn()
		rock21 = astroids:spawn()
		rock22 = astroids:spawn()
		rock23 = astroids:spawn()
		rock24 = astroids:spawn()
		rock25 = astroids:spawn()
		rock26 = astroids:spawn()
		rock27 = astroids:spawn()
		rock28 = astroids:spawn()
		rock29 = astroids:spawn()
		rock30 = astroids:spawn()
	end

	astroids:update(dt)

	-- MOUSE WELCOME BUTTON AREA
	if love.mouse.getX() > (love.graphics.getWidth()/2 - 320/2) and love.mouse.getX() < ((love.graphics.getWidth()/2 - 320/2) + 320) and love.mouse.getY() > 440 and love.mouse.getY() < 485 and game.Welcome == true then
		game.WelcomeButtonArea = true
	end
	-- MOUSE WELCOME BUTTON AREA

	-- Anything between the "MOUSE WELCOME BUTTON AREA" comments:
	-- This tells the game if the mouse is over a certain button
	------ WELCOME MOUSE ------


	-- MOUSE GAME OVER BUTTON AREA
	if love.mouse.getX() > (love.graphics.getWidth()/2 - 410/2) and love.mouse.getX() < ((love.graphics.getWidth()/2 - 410/2) + 410) and love.mouse.getY() > 440 and love.mouse.getY() < 485 and game.GameOver == true then
		game.GameOverMouseBackArea = true
	end
	-- MOUSE GAME OVER BUTTON AREA

	-- Anything between the "MOUSE GAME OVER BUTTON AREA" comments:
	-- This tells the game if the mouse is over a certain button
	------ GAME OVER MOUSE ------
end

function love.focus(f)
	
	-- If the mouse loses focus from the game window pause the game
	if not f and not Paused and not game.Welcome then
		Paused = true
		Resume = false
   		love.mouse.setCursor(cursor)
	end
end

function game:draw()
	
	------ FILTERS ------
	game.GameBG:setFilter( 'nearest', 'nearest' )
	game.InteractFont:setFilter( 'nearest', 'nearest' )
	game.InteractFont:setFilter( 'nearest', 'nearest' )
	game.BtnFont:setFilter( 'nearest', 'nearest' )
	game.GameOverText:setFilter( 'nearest', 'nearest' )
	game.GameOverTitleFont:setFilter( 'nearest', 'nearest' )
	game.WelcomeFont:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------
	
	------ IN CAMERA ------
	-- Start of camera
	game.Cam:attach()
	
	-- Draws space background
	love.graphics.draw(game.GameBG, 0, 0)
	
	wallL:draw('line')
	wallR:draw('line')
	wallT:draw('line')
	wallB:draw('line')

	-- draw bullets
	gun:bulletdraw()

	-- Draw ship
	ship:draw()

	-- Draw player
	player:draw()

	-- Draw gun
	gun:draw()

	-- Draw astroids
	astroids:draw()
	
	-- End of camera
	game.Cam:detach()
	------ IN CAMERA -----

	love.graphics.setFont( FPSfont )
	
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), 30)
	
	love.graphics.setColor(160, 47, 0)
	love.graphics.print("HP:"..tostring(plyr.health), 100, 10)
	love.graphics.print("TIME:"..tostring(plyr.health), 350, 10)
	love.graphics.print("SCORE:"..tostring(plyr.health), 710, 10)
	love.graphics.print("WAVE:"..tostring(plyr.health), 1020, 10)
	love.graphics.setColor(255, 255, 255)

	if game.GameOver == true then

		-- If you get a game over limt these varibles from change
		gun.ShotTime = 0
		gun.ShotTimePlus = 0
		gun.Bullets = { }
		gun.GunShot = false
		gun.GunShot1 = false
		plyr.movementstop = true
		sship.entered = false
		sship.yes = false
		sship.exited = false
		gun.HaveGun = false

		-- Game over text, box and button
		love.mouse.setCursor(cursor)
    	love.graphics.setFont( game.GameOverTitleFont )
    	love.graphics.setColor(160, 47, 0)
    	love.graphics.print('GAME OVER', (love.graphics.getWidth()/2 - game.GameOverTitleFont:getWidth( "GAME OVER" )/2), (love.graphics.getHeight()/2 - game.GameOverTitleFont:getHeight( "GAME OVER" )/2))
		love.graphics.setColor(255, 255, 255)
	end

    if game.Welcome == true then
    	
    	-- Welcome text, box and button
    	love.mouse.setCursor(cursor)
    	
    	love.graphics.setColor(0, 0, 0)
    	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(),love.graphics.getHeight())
    	
    	love.graphics.setColor(160, 47, 0)
    	love.graphics.setFont( game.WelcomeFont )
		
		love.graphics.rectangle("fill", 500, game.BtnY - 8, 28, 28)

		love.graphics.print('WELCOME!', (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "WELCOME!" )/2), 50)
		love.graphics.print("THANK YOU FOR TAKING THE TIME TO TEST", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "THANK YOU FOR TAKING THE TIME TO TEST" )/2), 80)
		love.graphics.print("PIQUANT INTERACTIVE'S PROJECT, ZOMBIE GAME.", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "PIQUANT INTERACTIVE'S PROJECT, ZOMBIE GAME." )/2), 110)
		love.graphics.print("THE CURRENT VERSION SOLELY INVOLVES A MINIGAME", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "THE CURRENT VERSION SOLELY INVOLVES A MINIGAME" )/2), 140)
		love.graphics.print("WHICH HAS YOU BATTLE INANIMATE", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "WHICH HAS YOU BATTLE INANIMATE" )/2), 170)
		love.graphics.print("ASTEROIDS IN A STAR FIELD. EXHILARATING, RIGHT??", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "ASTEROIDS IN A STAR FIELD. EXHILARATING, RIGHT??" )/2), 200)
		love.graphics.print("LEAVE ANY FEEDBACK YOU MAY HAVE AT", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "LEAVE ANY FEEDBACK YOU MAY HAVE AT" )/2), 230)
		love.graphics.print("[HTTP://WWW.REDDIT.COM/R/PIQUANT2013/] AS WE LOVE", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "[HTTP://WWW.REDDIT.COM/R/PIQUANT2013/] AS WE LOVE" )/2), 260)
		love.graphics.print("PLAYER INTERACTION.", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "PLAYER INTERACTION." )/2), 290)
		
		love.graphics.print("CONTROLS:", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "Controls:" )/2), 350)
		love.graphics.print("MOVEMENT - W = UP, S = DOWN, A = LEFT, D = RIGHT", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "MOVEMENT - W = UP, S = DOWN, A = LEFT, D = RIGHT" )/2), 380)
		love.graphics.print("GUN - MOUSE = AIM, LEFTCLICK = SHOOT", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "GUN - MOUSE = AIM, LEFTCLICK = SHOOT" )/2), 410)
		love.graphics.print("CAMERA - X = ZOOM IN, Z = ZOOM OUT", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "CAMERA - X = ZOOM IN, Z = ZOOM OUT" )/2), 440)
		love.graphics.print("INTERACTION - E = ACTIVATE, Q = DROP", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "INTERACTION - E = ACTIVATE, Q = DROP" )/2), 470)
		love.graphics.print("OTHER - ESC = PAUSE, LEFTSHIFT = SPRINT/BOOST", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "OTHER - ESC = PAUSE, LEFTSHIFT = SPRINT/BOOST" )/2), 500)
		love.graphics.setFont( game.BtnFont )
		love.graphics.print('START', (love.graphics.getWidth()/2 - game.BtnFont:getWidth( "START" )/2), game.BtnY)
	end
end

return game