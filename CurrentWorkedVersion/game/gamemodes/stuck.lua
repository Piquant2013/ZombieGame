-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads Hardon Collider script
local HC = require 'libs/hardoncollider'

-- Loads gamestate script
game = require 'game/game'

-- Loads diggingsim2015 script
diggingsim2015 = require 'game/diggingsim/menu/start'

-- Creates stuckmode as a new gamestate
stuckmode = Gamestate.new()


function stuckmode:init()

	------ VARIABLES ------
	-- load main game mechanics
	game:init()
	
	-- scores
	self.score = 0
	self.time = 0
	self.wave = 1

	-- For the spawn system
	self.kills = 0
	self.wavedrawtime = 0
	self.wavebreaktimer = 0
	self.waveflash = 2
	self.wavebreak = false
	self.wavestart = true
	self.flashwave = true
	self.wavezombiecount = 14

	-- Gameover vars
	self.gameovery = 800
	self.fadebg = 0
	self.bgtimer = 0

	-- easter egg vars
	self.digeggcount = 0
	self.digeasteregg = false
	------ VARIABLES ------

	------ IMAGES ------
	self.layer1 = love.graphics.newImage("images/maps/endless-layer1.png")
	self.layer2 = love.graphics.newImage("images/maps/endless-layer2.png")
	self.hud1 = love.graphics.newImage("images/hud/hud1.png")
	self.hud2 = love.graphics.newImage("images/hud/hud2.png")
	self.hud3 = love.graphics.newImage("images/hud/hud3.png")
	self.digeggimage = love.graphics.newImage("game/diggingsim/images/game/ach.png")
	------ IMAGES ------
end

function stuckmode:keypressed(key)
	
	-- load game keyborad inputs for welcome screen, gameover, etc
	game:keypressed(key)

	-- dissmiss the game over message
  	if key == "return" and gameover == true and self.bgtimer > 12 or key == " " and gameover == true and self.bgtimer > 12 or key == "escape" and gameover == true and self.bgtimer > 12 then
  		love.audio.play(game.entersound)
    	Gamestate.switch(menu)
    	love.audio.play(start.music)
    	start.music:setLooping(true)
   		love.audio.stop(game.music1)
    	setendless = true
    	gamereset = true
    	game.endless = false
    	game.stuck = false
    	love.audio.stop(plyr.deathaudio)
    	love.audio.stop(plyr.hurtaudio)
    	love.audio.stop(game.music2)
  	end

  	-- skip the game over animation
  	if key == "return" and gameover == true and self.bgtimer < 12 or key == " " and gameover == true and self.bgtimer < 12 or key == "escape" and gameover == true and self.bgtimer < 12 then
  		self.bgtimer = 13
  		self.fadebg = 255
		self.gameovery = 200
  	end

  	-- activate digging easter egg
  	if key == "f" and gameover == false then
  		self.digeggcount = self.digeggcount + 1
  	end

  	-- Swap to Digging Sim 2015
  	if key == "y" and gameover == false and self.digeasteregg == true then
  		Gamestate.switch(diggingsim2015)
  		love.audio.stop(game.music1)
		love.audio.play(diggingsim2015.music)
		diggingsim2015.music:setLooping(true)
		love.mouse.setCursor(cursor)
		setfull = false
  	end

  	-- Dismis dig promt
  	if key == "n" and gameover == false and self.digeasteregg == true then
  		self.digeasteregg = false 
  		self.digeggcount = 0
  	end
end

function stuckmode:mousepressed(mx, my, button)
	
	-- load crpistol mouse input
	crpistol:shooting(mx, my, button)
end

function stuckmode:update(dt)

	-- update main game mechanics
	game:update(dt)

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
		player.autoheal = true

		-- Pistol
		crpistol.crp.y = plyr.y
		crpistol.crp.x = plyr.x
		crpistol.cooldown = 0
		crpistol.cooldownplus = 0
		crpistol.bullets = {}

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
		self.wavebreaktimer = 0
		self.waveflash = 2
		self.wavebreak = false
		self.wavestart = true
		self.flashwave = true
		self.wavezombiecount = 100--8

		-- Gameover vars
		self.gameovery = 800
		self.fadebg = 0
		self.bgtimer = 0

		-- easter egg vars
		self.digeggcount = 0
		self.digeasteregg = false

		-- Globals
		paused = false
		
		-- Zombie
    	zombie.zombs = {}
    	zombie.spawnrate = 0
		zombie.spawnrateplus = 0.8
		zombie.speed = 10
		zombie.health = 1
		zombie.count = 0

		-- hardon collider
		Collider = HC(100, on_collision, collision_stop)
		plyr.bb = Collider:addRectangle(plyr.x, plyr.y, plyr.w, plyr.h)

		-- stop audio
    	love.audio.stop(plyr.hurtaudio)
    	love.audio.stop(plyr.deathaudio)
	end
	-- SET UP GAME --

	-- set digging easter egg to true if you have 10 in the count
	if self.digeggcount == 10 then
		self.digeasteregg = true
	end

	-- update gun
	crpistol:update(dt)

	-- set vars for gameover
	if gameover == true then
		crpistol.cooldown = 0
		crpistol.cooldownplus = 0
		crpistol.bullets = {}
		plyr.y = 465
		plyr.x = 800
		love.mouse.setCursor(cursor)
		love.audio.stop(plyr.hurtaudio)
		love.audio.play(plyr.deathaudio)
		love.audio.stop(game.music1)
		love.audio.play(game.music2)
		self.wavezombiecount = 100
	end

	-- keep player in place
	if gameover == false then
		plyr.y = 465
		plyr.x = 800
	end

	-- WAVE SYSTEM --
	-- start the score time
	if gameover == false then
		self.time = self.time + dt
	end

	-- Start the wave draw timer
	if gameover == false then
		self.wavedrawtime = self.wavedrawtime + dt
		self.wavebreaktimer = self.wavebreaktimer + dt
	end

	-- spawn zombies
	if self.wavestart == true then
		zombie:spawn()
	end

	-- stop spawning if zombie.count gets to high 
	if self.wavebreak == false then
		if zombie.count == self.wavezombiecount then
			self.wavestart = false
		elseif zombie.count < self.wavezombiecount then
			self.wavestart = true
		end
	end

	-- small break between waves
	if self.wavebreak == true then
		if self.wavebreaktimer < 5 then
			self.wavestart = false
		elseif self.wavebreaktimer > 5 then
			self.wavestart = true
			self.wavebreak = false
			love.audio.play(game.waveend)
		end
	end

	-- when you kill 100 go to next wave
	if self.kills > 99 then
		self.kills = 0
		zombie.count = 0
		self.wavedrawtime = 0
		self.waveflash = 2
		self.wavebreaktimer = 0
		self.wavebreak = true
		self.flashwave = true
		love.audio.play(game.wavestart)
	end

	-- difficulty increases
	if self.score > 99 and self.score < 101 then
		zombie.spawnrateplus = 0.75
		zombie.speed = 20
	elseif self.score > 199 and self.score < 201 then
		zombie.spawnrateplus = 0.7
		zombie.speed = 30
	elseif self.score > 299 and self.score < 301 then
		zombie.spawnrateplus = 0.65
		zombie.speed = 40
	elseif self.score > 399 and self.score < 401 then
		zombie.spawnrateplus = 0.6
		zombie.speed = 50
	elseif self.score > 499 and self.score < 501 then
		zombie.spawnrateplus = 0.55
		zombie.speed = 60
	elseif self.score > 599 and self.score < 601 then
		zombie.spawnrateplus = 0.5
		zombie.speed = 70
	elseif self.score > 699 and self.score < 701 then
		zombie.spawnrateplus = 0.45
		zombie.speed = 80
	elseif self.score > 799 and self.score < 801 then
		zombie.spawnrateplus = 0.4
		zombie.speed = 90
	elseif self.score > 899 and self.score < 901 then
		zombie.spawnrateplus = 0.38
		zombie.speed = 95
	elseif self.score > 999 and self.score < 1001 then
		zombie.spawnrateplus = 0.36
		zombie.speed = 100
	elseif self.score > 1099 and self.score < 1101 then
		zombie.spawnrateplus = 0.34
		zombie.speed = 105
	elseif self.score > 1199 and self.score < 1201 then
		zombie.spawnrateplus = 0.32
		zombie.speed = 115
	elseif self.score > 1299 and self.score < 1301 then
		zombie.spawnrateplus = 0.31
		zombie.speed = 120
	elseif self.score > 1399 and self.score < 1401 then
		zombie.spawnrateplus = 0.3
		zombie.speed = 122
	elseif self.score > 1499 and self.score < 1501 then
		zombie.spawnrateplus = 0.29
		zombie.speed = 124
	elseif self.score > 1599 and self.score < 1601 then
		zombie.spawnrateplus = 0.28
		zombie.speed = 126
	elseif self.score > 1699 and self.score < 1701 then
		zombie.spawnrateplus = 0.27
		zombie.speed = 128
	elseif self.score > 1799 and self.score < 1801 then
		zombie.spawnrateplus = 0.26
		zombie.speed = 130
	elseif self.score > 1899 and self.score < 1901 then
		zombie.spawnrateplus = 0.25
		zombie.speed = 132
	elseif self.score > 1999 and self.score < 2001 then
		zombie.spawnrateplus = 0.24
		zombie.speed = 134
	elseif self.score > 2099 and self.score < 2101 then
		zombie.spawnrateplus = 0.23
		zombie.speed = 136
	elseif self.score > 2199 and self.score < 2201 then
		zombie.spawnrateplus = 0.22
		zombie.speed = 138
	elseif self.score > 2299 and self.score < 2301 then
		zombie.spawnrateplus = 0.21
		zombie.speed = 140
	elseif self.score > 2399 and self.score < 2401 then
		zombie.spawnrateplus = 0.2
		zombie.speed = 142
	elseif self.score > 2499 and self.score < 2501 then
		zombie.spawnrateplus = 0.19
		zombie.speed = 144
	elseif self.score > 2599 and self.score < 2601 then
		zombie.spawnrateplus = 0.18
		zombie.speed = 146
	elseif self.score > 2699 and self.score < 2701 then
		zombie.spawnrateplus = 0.17
		zombie.speed = 148
	elseif self.score > 2799 and self.score < 2801 then
		zombie.spawnrateplus = 0.16
		zombie.speed = 150
	elseif self.score > 2899 and self.score < 2901 then
		zombie.spawnrateplus = 0.15
		zombie.speed = 152
	elseif self.score > 2999 and self.score < 3001 then
		zombie.spawnrateplus = 0.14
		zombie.speed = 154
	end

	-- flash the wave title in hud when a new wave is starting
	if self.wavedrawtime < 5 then
		if self.flashwave == true then
			self.waveflash = self.waveflash + dt + 3
		elseif self.flashwave == false then
			self.waveflash = self.waveflash + dt - 3
		end
	
		if self.waveflash > 150 then
			self.flashwave = false
		elseif self.waveflash < 2 then
			self.flashwave = true
		end
	end
	-- WAVE SYSTEM --

	-- update zombies
	zombie:update(dt)

	--- MOVE GAMEOVER TEXT ---
	if gameover == true then
		
		-- set timer and title mover
		self.gameovery = self.gameovery + dt - 1
		self.bgtimer = self.bgtimer + dt

		-- fade in the background after 10secs
		if self.bgtimer > 10 then
			self.fadebg = self.fadebg + dt + 3
		end

		-- stop death audio
		if self.bgtimer > 3 then
			love.audio.stop(plyr.deathaudio)
		end

		-- unspawn zombies
		if self.bgtimer > 12 then
			Collider:remove(zombie.bb)
			table.remove(zombie.zombs)
		end

		-- keep fade on the background off once its faded in
		if self.fadebg > 255 then
			self.fadebg = 255
		end

		-- move title to 200 and stop
		if self.gameovery < 200 then
			self.gameovery = 200
		end
	end
	--- MOVE GAMEOVER TEXT ---
end

function stuckmode:draw()
	
	------ FILTERS ------
	self.layer1:setFilter( 'nearest', 'nearest' )
	self.layer2:setFilter( 'nearest', 'nearest' )
	self.hud1:setFilter( 'nearest', 'nearest' )
	self.hud2:setFilter( 'nearest', 'nearest' )
	self.hud3:setFilter( 'nearest', 'nearest' )
	start.font0:setFilter( 'nearest', 'nearest' )
	start.font1:setFilter( 'nearest', 'nearest' )
	start.font2:setFilter( 'nearest', 'nearest' )
	start.font3:setFilter( 'nearest', 'nearest' )
	start.font4:setFilter( 'nearest', 'nearest' )
	start.font5:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------
	
	------ CAMERA ------
	game.Cam:attach()

	-- layer1 of the map
	love.graphics.draw(self.layer1, 0, 0)

	-- bullet
	crpistol:bulletdraw()

	-- Aim
	crpistol:aimdraw()

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
	crpistol:draw()

	-- zombies
	zombie:draw()

	-- layer2 of the map
	love.graphics.draw(self.layer2, 0, 0)

	game.Cam:detach()
	------ CAMERA ------
	
	------ TEXT ------
	-- the hud and the hud text
	if gameover == false and gameover == false then
		love.graphics.draw(self.hud1, 0, -25, 0, 0.5)
		love.graphics.setColor(0, 0, 0)
		love.graphics.setFont( start.font0 )
		love.graphics.setColor(160, 47, 0)
		love.graphics.print("HEALTH:", 10, 10)
		love.graphics.print(tostring(math.floor(plyr.health)).."%", 10, 30)
		
		love.graphics.print("TIME:", 1150, 10)
		love.graphics.print(tostring(math.floor(self.time)), 1150, 30)
		
		love.graphics.setFont( start.font1 )
		love.graphics.print("SCORE:"..tostring(self.score), (love.graphics.getWidth()/2 - start.font1:getWidth("SCORE:"..tostring(self.score))/2), 10)
		love.graphics.setColor(255, 255, 255)

		-- flash the wave text in hud white when the next wave is coming
		if self.wavedrawtime < 5 then
			love.graphics.setFont( start.font1 )
			love.graphics.setColor(255, 255, 255, self.waveflash)
			love.graphics.print("SCORE:"..tostring(self.score), (love.graphics.getWidth()/2 - start.font1:getWidth("SCORE:"..tostring(self.score))/2), 10)
			love.graphics.setColor(255, 255, 255)
		end

	-- Game over title and the scores at the end of the game
	elseif gameover == true then
    	
		-- darw game over backgorund
    	love.graphics.setColor(160, 47, 0, self.fadebg)
		love.graphics.draw(start.bg, 0, -1000, 0, 3)
		love.graphics.setColor(255, 255, 255)

		-- draw game over title
    	love.graphics.setFont( start.font5 )
    	love.graphics.setColor(160, 47, 0)
    	love.graphics.print('GAME OVER', (love.graphics.getWidth()/2 - start.font5:getWidth( "GAME OVER" )/2), self.gameovery)
    	love.graphics.setColor(255, 255, 255)
		
		-- display game score
    	if self.bgtimer > 12 then
			love.graphics.setFont( start.font3 )
    		love.graphics.setColor(160, 47, 0)
			love.graphics.print("TIME:"..tostring(math.floor(self.time)), (love.graphics.getWidth()/2 - start.font3:getWidth("TIME:"..tostring(math.floor(self.time)))/2), 300)
			love.graphics.print("SCORE:"..tostring(self.score), (love.graphics.getWidth()/2 - start.font3:getWidth("SCORE:"..tostring(self.score))/2), 350)
			love.graphics.setColor(255, 255, 255)
		end
	end

	-- Draw digging easter egg image
	if self.digeasteregg == true then
		love.graphics.setFont( start.font6 )
		love.graphics.draw(self.digeggimage, 10, 10)
		love.graphics.print("WANNA GO FOR A DIG?", 30, 50)
		love.graphics.print("Y = YES, N = NO", 30, 70)
	end

	-- draw game welcome messages
	game:draw()
	------ TEXT ------
end

return stuckmode