-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads camera script
local camera = require "libs/hump/camera"

-- Loads Hardon Collider script
local HC = require 'libs/hardoncollider'

-- Loads pause script
pause = require 'game/menus/pause'

-- Loads player script
player = require 'game/player'

-- Loads player script
gun = require 'game/weapons/pistol'

-- Loads astroids script
astroids = require 'game/zombies'

-- Creates game as a new gamestate
game = Gamestate.new()


function game:init()

	-- Set up for hardon collider
	Collider = HC(100, on_collision, collision_stop)

	-- Load player
    player:initialize()
    
    -- Load gun
    gun:initialize()

   	--astroids:initialize()
	
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

	self.score = 0
	self.time = 0
	self.wave = 1
	self.wavedrawtime = 0
	self.wavestart = true
	wavecount = 14
	zombies = 0
	wavebreak = 0
	kills = 0
	zombspeed = 10
	zombhealth = 1
	healthlock = false
	spawnratelock = false
	speedlock = false
	wavebreaktime = 6
	------ VARIABLES ------

	------ IMAGES ------
	self.GameBG = love.graphics.newImage("images/maps/endless-layer1.png")
	self.treesBG = love.graphics.newImage("images/maps/endless-layer2.png")
	------ IMAGES ------

	------ AUDIO ------
	GameMusic = love.audio.newSource("audio/music/game.ogg")
	self.GameSelect1M = love.audio.newSource("audio/buttons/select.ogg")
	self.GameEnter = love.audio.newSource("audio/buttons/enter.ogg")
	------ AUDIO ------

	------ FONTS ------
	self.InteractFont = love.graphics.newFont("fonts/PressStart.ttf", 20)
	self.BtnFont = love.graphics.newFont("fonts/PressStart.ttf", 30)
	self.GameOverText = love.graphics.newFont("fonts/PressStart.ttf", 20)
	self.GameOverTitleFont = love.graphics.newFont("fonts/PressStart.ttf", 40)
	self.WelcomeFont = love.graphics.newFont("fonts/PressStart.ttf", 20)
	------ FONTS ------
end

function on_collision(dt, shape_a, shape_b, mtv_x, mtv_y)
	player:collision(dt, shape_a, shape_b, mtv_x, mtv_y)
	astroids:collision(dt, shape_a, shape_b, mtv_x, mtv_y)
	astroids:wallcollision(dt, shape_a, shape_b, mtv_x, mtv_y)
end

function collision_stop(dt, shape_a, shape_b, mtv_x, mtv_y)
	player:collisionstopped(dt, shape_a, shape_b, mtv_x, mtv_y)
	astroids:collisionstopped(dt, shape_a, shape_b, mtv_x, mtv_y)
end

function game:keypressed(key)

  	if key == "return" and game.Welcome == true or key == " " and game.Welcome == true then
  		
  		-- turn game reset off
  		gamereset = false
  		
  		-- turn welcome screen off
  		game.Welcome = false
  		
  		-- play sound effect for enter
  		love.audio.play(game.GameEnter)
  	end

  	if key == "return" and game.GameOver == true or key == " " and game.GameOver == true then
  		
  		-- play sound effect for enter
  		love.audio.play(game.GameEnter)
    	
  		-- Tells the game script to switch to the menu script
    	Gamestate.switch(menu)
    	
    	-- Stops game music and plays menu music
    	love.audio.play(MenuMusic)
    	MenuMusic:setLooping(true)
   		love.audio.stop(GameMusic)
    	
   		-- Reset the game
    	gamereset = true
  	end

  	-- Pause the game
  	if key == "escape" and Paused == false and game.Welcome == false then
   		Paused = true
   		Resume = false
   		love.mouse.setCursor(cursor)
  	end

  	-- Zoom game camera in by 1
    if key == "x" then
		game.Cam:zoomTo(3.2)--game.Cam:zoom(2)
	end

	-- Zoom game camera back to default
	if key == "z" then
		game.Cam:zoom(0.5)
	end
end

function game:update(dt)

	------ CAMERA ------
	dx,dy = (plyr.x) - game.Cam.x, (plyr.y) - game.Cam.y
	mx1,my1 = game.Cam:mousepos()

	-- make sure the camera stops at the top and bottom of map
	--if plyr.y > 288 and plyr.x > 202 and plyr.x < 600 then
	--	game.Cam:move(dx/2, 0)
	--elseif plyr.y < 100 and plyr.x > 202 and plyr.x < 600 then
	--	game.Cam:move(dx/2, 0)
	--end
	
	-- make sure the camera stops at  the sides of map
	--if plyr.x < 202 and plyr.y > 100 and plyr.y < 288 then
	--	game.Cam:move(0, dy/2)
	--elseif plyr.x > 600 and plyr.y > 100 and plyr.y < 288 then
	--	game.Cam:move(0, dy/2)
	--end

	-- make sure the camera stops at the corners of map
	--if plyr.x < 202 and plyr.y < 100 then
		--game.Cam:move(0, 0)
	--elseif plyr.x > 600 and plyr.y > 288 then
		--game.Cam:move(0, 0)
	--elseif plyr.x > 600 and plyr.y < 100 then
		--game.Cam:move(0, 0)
	--elseif plyr.x < 202 and plyr.y > 288 then
		--game.Cam:move(0, 0)
	--end

	-- makes sure that if the player is in the center area of the map that the camera follows
	--if plyr.x < 600 and plyr.x > 202 and plyr.y > 100 and plyr.y < 288 then
		game.Cam:move(dx/2, dy/2)
	--end

	-- Zoom camera in when gameover but make sure it stays default when not
    if game.GameOver == true then
		game.Cam:zoomTo(5)
	elseif game.GameOver == false then
		game.Cam:zoomTo(3.2)
	end
	------ CAMERA ------

	-- Update player
	player:update(dt)
	player:health(dt)
	
	-- Update gun
	gun:update(dt)

	Collider:update(dt)

    -- if game is paused switch to the pause screen
	if Paused == true then
		Gamestate.switch(pause)
	end

	if game.GameOver == false then
		self.time = self.time + dt
	end

	-- Reset the game back to default for when you start a new game
	if gamereset == true then

		-- Reset player
		plyr.y = 200
		plyr.x = 600
		plyr.movementstop = false
		plyr.speed = 80
		plyr.health = 100

		-- Reset gun
		pistol.GunY = plyr.y
		pistol.GunX = plyr.x
		pistol.yes = false
		pistol.itemx = 750
		pistol.itemy = 380
		ShotTime = 0
		ShotTimePlus = 0.25
		gun.Bullets = {}
		gun.GunShot = false
		gun.GunShot1 = false

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
		
		-- new vars
		self.score = 0
		self.time = 0
		self.wave = 1
		
		self.wavedrawtime = 0
		self.wavestart = true
		wavecount = 50
		zombies = 0
		wavebreak = 0
		kills = 0
		zombspeed = 60
		zombhealth = 1
		healthlock = false
		spawnratelock = false
		speedlock = false
		wavebreaktime = 2
		
		-- Reset hardon collider hit boxes
		Collider = HC(100, on_collision, collision_stop)
		plyr.bb = Collider:addRectangle(plyr.x, plyr.y, plyr.w, plyr.h)
		wallT = Collider:addRectangle(188, 120, 850, 16)
    	wallB = Collider:addRectangle(188, 580, 850, 16)
    	wallL = Collider:addRectangle(170, 120, 16, 476)
    	wallR = Collider:addRectangle(1040, 120, 16, 476)
    	
    	tree1 = Collider:addCircle(334, 282, 10)
    	tree2 = Collider:addCircle(817, 259, 10)
    	tree3 = Collider:addCircle(900, 457, 10)
    	tree4 = Collider:addCircle(610, 356, 80)


    	-- zombie
    	rocks = {}
    	SpawnTime = 0
		SpawnTimePlus = 0.4

		-- new player vars 
		hitmove = 600
		plyr.hurt = false
		hurttimer = 0
		stopred = false
	end










	
	if game.GameOver == false then
		self.wavedrawtime = self.wavedrawtime + dt
	end

	if self.wavestart == true then
		astroids:spawn()
	end

	if zombies == wavecount then
		self.wavestart = false
	end

	if zombies < wavecount then
		self.wavestart = true
	end

	if kills > 100 then
		kills = 0
		SpawnTimePlus = SpawnTimePlus - 0.01
		self.wavedrawtime = 0
		game.wave = game.wave + 1
		wavecount = wavecount + 6
	end

	if SpawnTimePlus < 0.1 then
		SpawnTimePlus = 0.1
	end

	if wavecount > 150 then
		wavecount = 150
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
	if not f then
		
		if Paused == false and game.Welcome == false then  
			Paused = true
			Resume = false
   			love.mouse.setCursor(cursor)
   		end 
	end
end

function game:draw()
	
	------ FILTERS ------
	game.GameBG:setFilter( 'nearest', 'nearest' )
	game.treesBG:setFilter( 'nearest', 'nearest' )
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

	love.graphics.draw(game.GameBG, 0, 0)

	-- draw bullets
	gun:bulletdraw()

	if stopred == true then
		love.graphics.setColor(255, 57, 0)
		player:draw()
	elseif stopred == false then
		love.graphics.setColor(255, 255, 255)
		player:draw()
	end

	-- Draw gun
	gun:draw()

	-- Draw astroids
	astroids:draw()

	love.graphics.draw(self.treesBG, 0, 0)

	tree1:draw('line')
	tree2:draw('line')
	tree3:draw('line')
	tree4:draw('line')
	wallL:draw('line')
	wallR:draw('line')
	wallT:draw('line')
	wallB:draw('line')

	-- End of camera
	game.Cam:detach()
	------ IN CAMERA -----

	if self.wavedrawtime < 3 then

		love.graphics.setFont( game.GameOverTitleFont )
   		love.graphics.setColor(160, 47, 0)
		love.graphics.print("WAVE "..tostring(self.wave), (love.graphics.getWidth()/2 - game.GameOverTitleFont:getWidth( "WAVE " )/2), 200)
		love.graphics.setColor(255, 255, 255)
	
	end

	if game.GameOver == false then
	
		love.graphics.setFont( start.font )
	
		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), 30)
	
		love.graphics.setColor(160, 47, 0)
		love.graphics.print("HP:"..tostring(math.floor(plyr.health)), 100, 10)
		love.graphics.print("TIME:"..tostring(math.floor(self.time)), 350, 10)
		love.graphics.print("SCORE:"..tostring(self.score), 710, 10)
		love.graphics.print("WAVE:"..tostring(self.wave), 1020, 10)
		love.graphics.setColor(255, 255, 255)






		if SetFPS == true then
			love.graphics.print("Zombs "..tostring(zombies), love.graphics.getWidth() + 20 - game.GameOverTitleFont:getWidth( "Zombs " ), 200)
			love.graphics.print("Count "..tostring(wavecount), love.graphics.getWidth() + 20 - game.GameOverTitleFont:getWidth( "Count " ), 250)
			love.graphics.print("Kills  "..tostring(kills), love.graphics.getWidth() + 20 - game.GameOverTitleFont:getWidth( "Kills " ), 300)
			love.graphics.print("Speed  "..tostring(rock.speed), love.graphics.getWidth() + 20 - game.GameOverTitleFont:getWidth( "Speed " ), 350)
			love.graphics.print("healh  "..tostring(zombhealth), love.graphics.getWidth() + 20 - game.GameOverTitleFont:getWidth( "healh " ), 400)
			love.graphics.print("Spawn  "..tostring(SpawnTimePlus), love.graphics.getWidth() + 20 - game.GameOverTitleFont:getWidth( "Spawn " ), 450)
		end
	





	end

	if game.GameOver == true then

		-- If you get a game over limt these varibles from change
		gun.ShotTime = 0
		gun.ShotTimePlus = 0
		gun.Bullets = { }
		gun.GunShot = false
		gun.GunShot1 = false
		plyr.movementstop = true
		plyr.y = plyr.y
		plyr.x = plyr.x
		love.mouse.setCursor(cursor)

		-- Game over text, box and button
		love.mouse.setCursor(cursor)
    	love.graphics.setFont( game.GameOverTitleFont )
    	love.graphics.setColor(160, 47, 0)
    	love.graphics.print('GAME OVER', (love.graphics.getWidth()/2 - game.GameOverTitleFont:getWidth( "GAME OVER" )/2), 200)
			
    	--love.graphics.setFont( FPSfont )
		love.graphics.print("TIME:"..tostring(math.floor(self.time)), (love.graphics.getWidth()/2 - game.GameOverTitleFont:getWidth( "TIME:" )/2), 300)
		love.graphics.print("SCORE:"..tostring(self.score), (love.graphics.getWidth()/2 - game.GameOverTitleFont:getWidth( "SCORE:" )/2), 350)
		love.graphics.print("WAVE:"..tostring(self.wave), (love.graphics.getWidth()/2 - game.GameOverTitleFont:getWidth( "WAVE:" )/2), 400)

		love.graphics.setColor(255, 255, 255)
	end

    if game.Welcome == true then
    	
    	-- Welcome text, box and button
    	love.mouse.setCursor(cursor)
    	
    	love.graphics.draw(start.bg, 0, -1000, 0, 3)
    	
    	love.graphics.setColor(160, 47, 0)
    	love.graphics.setFont( start.font )
		
		--love.graphics.rectangle("fill", 500, game.BtnY - 8, 28, 28)

		love.graphics.print('WELCOME!', (love.graphics.getWidth()/2 - start.font:getWidth( "WELCOME!" )/2), 80)
		love.graphics.print("THANK YOU FOR TAKING THE TIME TO TEST", (love.graphics.getWidth()/2 - start.font:getWidth( "THANK YOU FOR TAKING THE TIME TO TEST" )/2), 180)
		love.graphics.print("PIQUANT INTERACTIVE'S PROJECT,", (love.graphics.getWidth()/2 - start.font:getWidth( "PIQUANT INTERACTIVE'S PROJECT," )/2), 230)
		love.graphics.print("ZOMBIE GAME. THIS GAME MODE HAS YOU", (love.graphics.getWidth()/2 - start.font:getWidth( "ZOMBIE GAME. THIS GAME MODE HAS YOU" )/2), 280)
		love.graphics.print("BATTLING ZOMBIES IN AN ENDLESS, WAVE", (love.graphics.getWidth()/2 - start.font:getWidth( "BATTLING ZOMBIES IN AN ENDLESS, WAVE" )/2), 330)
		love.graphics.print("BASED SURVIVAL SHOOTER WITH NAUGHT", (love.graphics.getWidth()/2 - start.font:getWidth( "BASED SURVIVAL SHOOTER WITH NAUGHT" )/2), 380)
		love.graphics.print("BUT YOUR WIT AND YOUR PISTOL. DON'T DIE!", (love.graphics.getWidth()/2 - start.font:getWidth( "BUT YOUR WIT AND YOUR PISTOL. DON'T DIE!" )/2), 430)
		
		love.graphics.print("LEAVE ANY FEEDBACK YOU MAY HAVE AT", (love.graphics.getWidth()/2 - start.font:getWidth( "LEAVE ANY FEEDBACK YOU MAY HAVE AT" )/2), 530)
		love.graphics.print("[HTTP://WWW.REDDIT.COM/R/PIQUANT2013/]", (love.graphics.getWidth()/2 - start.font:getWidth( "[HTTP://WWW.REDDIT.COM/R/PIQUANT2013/]" )/2), 580)
		love.graphics.print("AS WE LOVE PLAYER INTERACTION.", (love.graphics.getWidth()/2 - start.font:getWidth( "AS WE LOVE PLAYER INTERACTION." )/2), 630)
		
		--love.graphics.setFont( start.font )
		--love.graphics.print('START', (love.graphics.getWidth()/2 - start.font:getWidth( "START" )/2), game.BtnY)
	end
end

return game