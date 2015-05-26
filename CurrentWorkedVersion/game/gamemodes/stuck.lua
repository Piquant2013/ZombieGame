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
clickratepistol = require 'game/weapons/clickrate-pistol'

-- Loads astroids script
zombie = require 'game/zombie'

-- Loads game script
game = require 'game/game'

-- Creates game as a new gamestate
stuckmode = Gamestate.new()


function stuckmode:init()

	------ VARIABLES ------
	-- Set up hardon collider
	Collider = HC(100, on_collision, collision_stop)

	-- Load player and pistol vars
    player:initialize()
    clickratepistol:initialize()
	
	-- Camera
	self.Cam = camera(plyr.x, plyr.y, 2.5)

	-- scores
	self.score = 0
	self.time = 0
	self.wave = 1

	-- For the spawn system
	self.kills = 0
	self.wavedrawtime = 0
	self.wavestart = true
	self.wavezombiecount = 14
	------ VARIABLES ------

	------ IMAGES ------
	self.layer1 = love.graphics.newImage("images/maps/endless-layer1.png")
	self.layer2 = love.graphics.newImage("images/maps/endless-layer2.png")
	------ IMAGES ------

	------ AUDIO ------
	--self.music = love.audio.newSource("audio/music/game.ogg")
	--self.intromusic = love.audio.newSource("audio/music/gameintro.ogg")
	--self.entersound = love.audio.newSource("audio/buttons/enter.ogg")
	------ AUDIO ------
end

function stuckmode:keypressed(key)

	-- dissmiss the welcome message
  	if key == "return" and welcomescreen == true or key == " " and welcomescreen == true then
  		gamereset = false
  		welcomescreen = false
  		--love.audio.play(self.entersound)
		--love.audio.stop(endless.intromusic)
		--love.audio.play(endless.music)
		--endless.music:setVolume(1.0)
		--endless.music:setLooping(true)
  	end

  	-- dissmiss the game over message
  	if key == "return" and gameover == true or key == " " and gameover == true then
  		--love.audio.play(self.entersound)
    	Gamestate.switch(menu)
    	love.audio.play(start.music)
    	start.music:setLooping(true)
   		--love.audio.stop(self.music)
    	gamereset = true
  	end

  	-- Pause the game
  	if key == "escape" and paused == false and welcomescreen == false then
   		paused = true
   		resume = false
   		love.mouse.setCursor(cursor)
  	end
end

function stuckmode:mousepressed(mx, my, button)
	clickratepistol:shooting(mx, my, button)
end

function stuckmode:update(dt)

	-- SET UP GAME --
	-- Reset the game
	if gamereset == true then

		-- Player
		plyr.y = 465
		plyr.x = 800
		plyr.speed = 0
		plyr.health = 100
		plyr.hurt = false
		plyr.colliding = false
		player.hurttimer = 0
		player.flashred = false

		-- Pistol
		clickratepistol.crp.y = plyr.y
		clickratepistol.crp.x = plyr.x
		clickratepistol.cooldown = 0
		clickratepistol.cooldownplus = 0
		clickratepistol.bullets = {}

		-- Camera
		self.Cam = camera(plyr.x, plyr.y, 2.5)

		-- gameover or welcome screens
		welcomescreen = true
		gameover = false

		-- scores
		self.score = 0
		self.time = 0
		self.wave = 1
		
		-- For the spawn system
		self.kills = 0
		self.wavedrawtime = 0
		self.wavestart = true
		self.wavezombiecount = 50

		-- Globals
		paused = false
		
		-- Zombie
    	zombie.zombs = {}
    	zombie.spawnrate = 0
		zombie.spawnrateplus = 0.4
		zombie.speed = 60
		zombie.health = 1
		zombie.count = 0
	end
	-- SET UP GAME --

	-- CAMERA --
	-- set up camera
	dx,dy = (plyr.x) - self.Cam.x, (plyr.y) - self.Cam.y
	mx1,my1 = self.Cam:mousepos()
	self.Cam:move(dx/2, dy/2)

	-- Zoom camera in when gameover but make sure it stays default when not
    if gameover == true then
		self.Cam:zoomTo(5)
	elseif gameover == false then
		self.Cam:zoomTo(3.2)
	end
	-- CAMERA --

	-- Update player, pistol and hardon collider
	player:update(dt)
	player:health(dt)
	clickratepistol:update(dt)
	Collider:update(dt)

	-- PLAYER HEALTH --
	-- start the hurt timer
	player.hurttimer = player.hurttimer + dt

	-- flash red is player is hurt
  	if plyr.hurt == true then
    	player.hurttimer = 0
    	player.flashred = true
  	end

  	-- Stop the flashing
  	if player.hurttimer > 0.3 then
   	 	player.flashred = false
  	end

  	-- Autoheal the player if hasnt been hurt for 4secs
  	if player.hurttimer > 4 and plyr.hurt == false then
    	plyr.health = plyr.health + 1
  	end

  	-- stop player health at 100
  	if plyr.health > 100 then
    	plyr.health = 100
    	player.hurttimer = 0
  	end
  	-- PLAYER HEALTH --

    -- if game is paused switch to the pause screen
	if paused == true then
		Gamestate.push(pause)
	end

	-- start the score time
	if gameover == false then
		self.time = self.time + dt
	end

	-- set vars for gameover
	if gameover == true then
		clickratepistol.cooldown = 0
		clickratepistol.cooldownplus = 0
		clickratepistol.bullets = {}
		plyr.y = plyr.y
		plyr.x = plyr.x
		love.mouse.setCursor(cursor)
	end

	-- WAVE SYSTEM --
	-- Start the wave draw timer
	if gameover == false then
		self.wavedrawtime = self.wavedrawtime + dt
	end

	-- spawn zombies
	if self.wavestart == true then
		zombie:spawn()
	end

	-- stop spawning if zombie.count gets to high 
	if zombie.count == self.wavezombiecount then
		self.wavestart = false
	elseif zombie.count < self.wavezombiecount then
		self.wavestart = true
	end

	-- when you kill 100 go to next wave, increase spawn rate, increase spawn amount
	if self.kills > 100 then
		self.kills = 0
		zombie.spawnrateplus = zombie.spawnrateplus - 0.01
		self.wavedrawtime = 0
		self.wave = self.wave + 1
		self.wavezombiecount = self.wavezombiecount + 6
	end

	-- lock the spawn rate
	if zombie.spawnrateplus < 0.1 then
		zombie.spawnrateplus = 0.1
	end

	-- lock the wave count
	if self.wavezombiecount > 150 then
		self.wavezombiecount = 150
	end
	-- WAVE SYSTEM --

	-- update zombies
	zombie:update(dt)
end

function love.focus(f)
	
	-- pause the game if window loses focus
	if not f then
		if paused == false and welcomescreen == false and setendless == false or gamereset == false then  
			paused = true
			resume = false
   			love.mouse.setCursor(cursor)
   		end 
	end
end

function stuckmode:draw()
	
	------ FILTERS ------
	self.layer1:setFilter( 'nearest', 'nearest' )
	self.layer2:setFilter( 'nearest', 'nearest' )
	start.font1:setFilter( 'nearest', 'nearest' )
	start.font2:setFilter( 'nearest', 'nearest' )
	start.font3:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------
	
	------ CAMERA ------
	self.Cam:attach()

	-- layer1 of the map
	love.graphics.draw(self.layer1, 0, 0)

	-- bullet
	clickratepistol:bulletdraw()

	-- player (red flash when player is hurt)
	if player.flashred == true then
		love.graphics.setColor(255, 57, 0)
		player:draw()
		love.graphics.setColor(255, 255, 255)
	elseif player.flashred == false then
		love.graphics.setColor(255, 255, 255)
		player:draw()
		love.graphics.setColor(255, 255, 255)
	end

	-- pistol
	clickratepistol:draw()

	-- zombies
	zombie:draw()

	-- layer2 of the map
	love.graphics.draw(self.layer2, 0, 0)

	self.Cam:detach()
	------ CAMERA ------
	
	------ TEXT ------
	-- wave title
	if self.wavedrawtime < 3 then
		love.graphics.setFont( start.font3 )
   		love.graphics.setColor(160, 47, 0)
		love.graphics.print("WAVE "..tostring(self.wave), (love.graphics.getWidth()/2 - start.font3:getWidth("WAVE "..tostring(self.wave))/2), 200)
		love.graphics.setColor(255, 255, 255)
	end

	-- the hud and the hud text
	if gameover == false then
		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), 30)
		love.graphics.setFont( start.font1 )
		love.graphics.setColor(160, 47, 0)
		love.graphics.print("HP:"..tostring(math.floor(plyr.health)), 100, 10)
		love.graphics.print("TIME:"..tostring(math.floor(self.time)), 350, 10)
		love.graphics.print("SCORE:"..tostring(self.score), 710, 10)
		love.graphics.print("WAVE:"..tostring(self.wave), 1020, 10)
		love.graphics.setColor(255, 255, 255)

	-- Game over title and the scores at the end of the game
	elseif gameover == true then
    	love.graphics.setFont( start.font3 )
    	love.graphics.setColor(160, 47, 0)
    	love.graphics.print('GAME OVER', (love.graphics.getWidth()/2 - start.font3:getWidth( "GAME OVER" )/2), 200)
		love.graphics.print("TIME:"..tostring(math.floor(self.time)), (love.graphics.getWidth()/2 - start.font3:getWidth("TIME:"..tostring(math.floor(self.time)))/2), 300)
		love.graphics.print("SCORE:"..tostring(self.score), (love.graphics.getWidth()/2 - start.font3:getWidth("SCORE:"..tostring(self.score))/2), 350)
		love.graphics.print("WAVE:"..tostring(self.wave), (love.graphics.getWidth()/2 - start.font3:getWidth("WAVE:"..tostring(self.wave))/2), 400)
		love.graphics.setColor(255, 255, 255)
	end

	-- draw the welcome text and bacground
	 if welcomescreen == true then
    	love.mouse.setCursor(cursor)
    	love.graphics.draw(start.bg, 0, -1000, 0, 3)
    	love.graphics.setColor(160, 47, 0)
    	love.graphics.setFont( start.font2 )
		love.graphics.print("WELCOME! THANK YOU FOR TAKING THE TIME", (love.graphics.getWidth()/2 - start.font2:getWidth( "WELCOME! THANK YOU FOR TAKING THE TIME" )/2), 80)
		love.graphics.print("TO TEST PIQUANT INTERACTIVE'S PROJECT,", (love.graphics.getWidth()/2 - start.font2:getWidth( "TO TEST PIQUANT INTERACTIVE'S PROJECT," )/2), 130)
		love.graphics.print("ZOMBIE GAME. THIS GAME MODE DOESNT ALLOW", (love.graphics.getWidth()/2 - start.font2:getWidth( "ZOMBIE GAME. THIS GAME MODE DOESNT ALLOW" )/2), 180)
		love.graphics.print("PLAYER MOVEMENT; HENCE THE NAME. YOU WILL", (love.graphics.getWidth()/2 - start.font2:getWidth( "PLAYER MOVEMENT; HENCE THE NAME. YOU WILL" )/2), 230)
		love.graphics.print("REQUIRE 3 THINGS: FAST REFLEXES, A QUICK", (love.graphics.getWidth()/2 - start.font2:getWidth( "REQUIRE 3 THINGS: FAST REFLEXES, A QUICK" )/2), 280)
		love.graphics.print("TIGGER FINGER, AND THE WILL TO SURVIVE.", (love.graphics.getWidth()/2 - start.font2:getWidth( "TIGGER FINGER, AND THE WILL TO SURVIVE." )/2), 330)
		love.graphics.print("LEAVE ANY FEEDBACK YOU MAY HAVE AT", (love.graphics.getWidth()/2 - start.font2:getWidth( "LEAVE ANY FEEDBACK YOU MAY HAVE AT" )/2), 430)
		love.graphics.print("[HTTP://WWW.REDDIT.COM/R/PIQUANT2013/]", (love.graphics.getWidth()/2 - start.font2:getWidth( "[HTTP://WWW.REDDIT.COM/R/PIQUANT2013/]" )/2), 480)
		love.graphics.print("AS WE LOVE PLAYER INTERACTION.", (love.graphics.getWidth()/2 - start.font2:getWidth( "AS WE LOVE PLAYER INTERACTION." )/2), 530)
		love.graphics.print("PRESS START BUTTON", (love.graphics.getWidth()/2 - start.font2:getWidth( "PRESS START BUTTON" )/2), 630)
	end
	------ TEXT ------

	-- REMOVE LATER! ------ DEBUG ------ REMOVE LATER!
	if setfps == true then
		love.graphics.setFont( start.font1 )
		love.graphics.print("ZOMBS "..tostring(zombie.count), 1000, 200)
		love.graphics.print("COUNT "..tostring(self.wavezombiecount), 1000, 250)
		love.graphics.print("KILLS "..tostring(self.kills), 1000, 300)
		love.graphics.print("SPEED "..tostring(zombie.speed), 1000, 350)
		love.graphics.print("HEALH "..tostring(zombie.health), 1000, 400)
		love.graphics.print("SPAWN "..tostring(zombie.spawnrateplus), 1000, 450)
	end
	-- REMOVE LATER! ------ DEBUG ------ REMOVE LATER!
end

return stuckmode