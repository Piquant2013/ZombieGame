-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads Hardon Collider script
local HC = require 'libs/hardoncollider'

-- Loads gamestate script
game = require 'game/game'

-- Creates arcade as a new gamestate
endless = Gamestate.new()


function endless:init()

	------ VARIABLES ------
	-- load main game mechanics
	game:init()

	-- scores
	self.money = 0
	self.time = 0
	self.wave = 1
	self.kills = 0
	self.killamount = 100

	-- For the spawn system
	self.wavedrawtime = 0
	self.wavebreak = false
	self.wavestart = true
	self.wavezombiecount = 14
	
	-- flashes
	self.flashwave = true
	self.waveflash = 2
	self.gunsflash = 2
	self.flashguns = true

	-- player
	self.health1 = 0
	self.playerspeed = 0
	self.healthcolor1 = 0
	self.healthcolor2 = 0
	self.healthcolor3 = 0
	
	-- Gameover vars
	self.gameovery = 800
	self.fadebg = 0
	self.bgtimer = 0
	------ VARIABLES ------

	------ IMAGES ------
	self.layer1 = love.graphics.newImage("images/maps/endless-layer1.png")
	self.layer2 = love.graphics.newImage("images/maps/arcade-layer2.png")
	------ IMAGES ------

	------ FILTERS ------
	self.layer1:setFilter( 'nearest', 'nearest' )
	self.layer2:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	-- HIGHSCORE SAVING VARS AND SETTINGS --
	-- vars
	self.highscore = 0
	endlesshighscores = {}

	--- Create or load file depending on if it exsits
	if love.filesystem.exists("endlessscores.lua") then
	
		for lines in love.filesystem.lines("endlessscores.lua") do
			table.insert(endlesshighscores, lines)
			self.highscore = endlesshighscores[3]
		end
	
	elseif not love.filesystem.exists("endlessscores.lua") then
		scores = love.filesystem.newFile("endlessscores.lua")
	end
	-- HIGHSCORE SAVING VARS AND SETTINGS --
end

function endless:keypressed(key)
	
	-- load game keyborad inputs for welcome screen, gameover, etc
	game:keypressed(key)

	-- dissmiss the game over message
  	if key == "return" and gameover == true and self.bgtimer > 12 or key == "space" and gameover == true and self.bgtimer > 12 or key == "escape" and gameover == true and self.bgtimer > 12 then
  		love.audio.play(game.entersound)
    	Gamestate.switch(menu)
    	love.audio.play(start.music)
    	start.music:setLooping(true)
   		love.audio.stop(game.music1)
    	setarcade = true
    	setendless = true
    	gamereset = true
    	game.arcade = false
    	game.stuck = false
    	game.endless = false
    	love.audio.stop(plyr.deathaudio)
    	love.audio.stop(plyr.hurtaudio)
    	love.audio.stop(game.music2)
  	end

  	-- skip the game over animation
  	if key == "return" and gameover == true and self.bgtimer < 12 or key == "space" and gameover == true and self.bgtimer < 12 or key == "escape" and gameover == true and self.bgtimer < 12 then
  		self.bgtimer = 13
  		self.fadebg = 255
		self.gameovery = 200
  	end

  	if key == "space" and self.time > 0 and self.wavebreak == true then
  		self.time = 0
  	end
end

function endless:mousepressed(mx, my, button)
	
	-- dissmiss the game over message
  	if button == 1 and gameover == true and self.bgtimer > 12 or button == 2 and gameover == true and self.bgtimer > 12 then
  		love.audio.play(game.entersound)
    	Gamestate.switch(menu)
    	love.audio.play(start.music)
    	start.music:setLooping(true)
   		love.audio.stop(game.music1)
    	setarcade = true
    	setendless = true
    	gamereset = true
    	game.arcade = false
    	game.stuck = false
    	game.endless = false
    	love.audio.stop(plyr.deathaudio)
    	love.audio.stop(plyr.hurtaudio)
    	love.audio.stop(game.music2)
  	end

	-- aim assit for pistol
	handgun:aim(mx, my, button)

	-- load game mousepressed inputs for welcome screen, gameover, etc
	game:mousepressed(mx, my, button)
end

function endless:update(dt)

	-- set volume
	game.music1:setVolume(musicvolume)
	game.music2:setVolume(musicvolume)
	game.music3:setVolume(musicvolume)

	-- update main game mechanics
	game:update(dt)

	-- SET UP GAME --
	-- Reset the game
	if setendless == true then

		-- Player
		plyr.y = 200
		plyr.x = 400
		plyr.speed = 28
		plyr.health = 100
		plyr.hurt = false
		plyr.colliding = false
		player.hurttimer = 0
		player.flashred = false
		player.autoheal = true
		player.maxhealth = 100
		player.minihealthbar = false

		-- Pistol
		hand.y = plyr.y
		hand.x = plyr.x
		handgun.cooldown = 0
		handgun.cooldownplus = 0.25
		handgun.bullets = {}

		-- scores
		self.money = 0
		self.time = 45
		self.wave = 0
		self.kills = 0
		self.killamount = 100

		-- For the spawn system
		self.wavedrawtime = 5
		self.wavebreak = true
		self.wavestart = false
		self.wavezombiecount = 14
	
		-- flashes
		self.flashwave = true
		self.waveflash = 2
		self.gunsflash = 2
		self.flashguns = true

		-- player
		self.health1 = 0
		self.playerspeed = 0
		self.healthcolor1 = 0
		self.healthcolor2 = 0
		self.healthcolor3 = 0

		-- Gameover vars
		self.gameovery = 800
		self.fadebg = 0
		self.bgtimer = 0

		-- Globals
		paused = false
		welcomescreen = true
		gameover = false

		-- Zombie
    	zombie.zombs = {}
    	zombie.spawnrate = 0
		zombie.spawnrateplus = 1
		zombie.speed = 20
		zombie.health = 1
		zombie.count = 0
		
		-- hardon collider
		Collider = HC(100, on_collision, collision_stop)
		plyr.bb = Collider:addRectangle(plyr.x, plyr.y, plyr.w, plyr.h)
		self.wallT = Collider:addRectangle(188, 120, 850, 16)
    	self.wallB = Collider:addRectangle(188, 580, 850, 16)
    	self.wallL = Collider:addRectangle(170, 120, 16, 476)
    	self.wallR = Collider:addRectangle(1040, 120, 16, 476)
    	self.tree1 = Collider:addCircle(334, 282, 10)
    	self.tree2 = Collider:addCircle(817, 259, 10)
    	self.tree3 = Collider:addCircle(900, 457, 10)
    	self.tree4 = Collider:addCircle(610, 356, 80)

    	-- stop audio
    	love.audio.stop(plyr.hurtaudio)
    	love.audio.stop(plyr.deathaudio)
	end
	-- SET UP GAME --

	-- update the gun
	handgun:update(dt)

	-- set vars for gameover
	if gameover == true then
		handgun.cooldown = 0
		handgun.cooldownplus = 0
		handgun.bullets = {}
		plyr.y = plyr.y
		plyr.x = plyr.x
		love.mouse.setCursor(cursor)
		love.audio.stop(plyr.hurtaudio)
		love.audio.play(plyr.deathaudio)
		love.audio.stop(game.music1)
		love.audio.play(game.music2)
		self.wavestart = false
	end

	-- Flash special weapons
	if self.flashguns == true then
		self.gunsflash = self.gunsflash + dt + 1.5
	elseif self.flashguns == false then
		self.gunsflash = self.gunsflash + dt - 1.5
	end
	
	if self.gunsflash > 100 then
		self.flashguns = false
	elseif self.gunsflash < 2 then
		self.flashguns = true
	end

	-- WAVE SYSTEM --
	-- start the score time
	if gameover == false then
		self.time = self.time - dt
	end

	-- Start the wave draw timer
	if gameover == false then
		self.wavedrawtime = self.wavedrawtime + dt
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
		if self.time < 0 then
			self.time = 60
			self.killamount = self.killamount + 10
			self.kills = 0
			self.wavestart = true
			self.wavebreak = false
			zombie.spawnrateplus = zombie.spawnrateplus - 0.05
			zombie.speed = zombie.speed + 1.5
			self.wavedrawtime = 0
			self.waveflash = 2
			self.wave = self.wave + 1
			self.wavezombiecount = self.wavezombiecount + 8
			self.flashwave = true
			love.audio.play(game.wavestart)

			if self.wave > 3 and self.wave < 7 then
				zombie.health = 11
			end

			if self.wave > 6 and self.wave < 10 then
				zombie.health = 21
			end

			if self.wave > 9 and self.wave < 13 then
				zombie.health = 31
			end

			if self.wave > 12 and self.wave < 16 then
				zombie.health = 41
			end
		end
	end

	-- when you kill 100 go to next wave, increase spawn rate, increase spawn amount
	if self.time < 0 then
		self.time = 0

		if self.kills > self.killamount then
			self.wavestart = false
		end
	end

	if zombie.count == 0 and self.time == 0 and self.wavestart == false then
		self.time = 45
		self.wavebreak = true
	end

	-- lock the spawn rate
	if zombie.spawnrateplus < 0.05 then
		zombie.spawnrateplus = 0.05
	end

	-- lock the wave count
	if zombie.speed > 200 then
		zombie.speed = 200
	end

	-- lock the wave count
	if self.wavezombiecount > 300 then
		self.wavezombiecount = 300
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

	-- set and update heath draw varibles
	self.health1 = plyr.health

	-- keep health one at no higher then 100
	if self.health1 > 100 then
		self.health1 = 100
	end

	-- update zombies
	zombie:update(dt)

	--- MOVE GAMEOVER TEXT ---
	if gameover == true then
		
		-- make zombies slowmo at death
		for i, o in ipairs(zombie.zombs) do
			if o.health > 0 then
				o.speed = 10
			end
		end

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

function endless:draw()
	
	------ CAMERA ------
	game.Cam:attach()

	-- layer1 of the map
	love.graphics.draw(self.layer1, 0, 0)

	-- draw zombie blood
	zombie:drawblood()

	-- bullet
	handgun:bulletdraw()

	-- Aim
	handgun:aimdraw()

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
	handgun:draw()

	-- zombies
	zombie:draw()

	-- layer2 of the map
	love.graphics.setColor(255, 255, 255, 235)
	love.graphics.draw(self.layer2, 0, 0)
	love.graphics.setColor(255, 255, 255, 255)

	-- display mini health bar
	if plyr.hurt == true and gameover == false or player.minihealthbar == true and gameover == false or minihealthalwayson == true and gameover == false then
		love.graphics.setColor(160, 47, 0, 200)
		love.graphics.rectangle("line", plyr.x - 13, plyr.y + 14, 27, 3)
		love.graphics.setColor(0, 0, 0, 200)
		love.graphics.rectangle("line", plyr.x - 12, plyr.y + 15, 25, 1)
		love.graphics.setColor(self.healthcolor1, self.healthcolor2, self.healthcolor3, 200)
		love.graphics.rectangle("fill", plyr.x - 12, plyr.y + 15, self.health1/4, 1)
		love.graphics.setColor(255, 255, 255, 255)
	end

	-- reset health flash timer
	if plyr.health < player.maxhealth and player.hurttimer > 3 then
		self.healthflashtimer = 0
	end

	-- stop health flash timer
	if plyr.health == player.maxhealth then
		self.healthflashtimer = 10
	end

	-- stop health flash timer till your not hurt
	if plyr.hurt == true then
		self.healthflashtimer = 10
	end

	game.Cam:detach()
	------ CAMERA ------
	
	------ TEXT ------
	-- wave title
	if self.wavedrawtime < 3 and gameover == false then
		love.graphics.setFont( start.font3 )
   		love.graphics.setColor(160, 47, 0)
		love.graphics.print("WAVE "..tostring(self.wave), (love.graphics.getWidth()/2 - start.font3:getWidth("WAVE "..tostring(self.wave))/2), 200)
		love.graphics.setColor(255, 255, 255)
	end

	if self.time > 0 and self.wavebreak == true then
		love.graphics.setFont( start.font1 )
		love.graphics.setColor(160, 47, 0)
		love.graphics.print("'SPACE' TO START NEXT WAVE", (love.graphics.getWidth()/2 - start.font1:getWidth("'SPACE' TO START NEXT WAVE")/2), 200)
		love.graphics.setColor(255, 255, 255)
	end

	if self.time == 0 then
		love.graphics.setFont( start.font1 )
		love.graphics.setColor(160, 47, 0)
		love.graphics.print("KILLS LEFT:"..tostring(math.floor(zombie.count)), (love.graphics.getWidth()/2 - start.font1:getWidth("KILLS LEFT:"..tostring(math.floor(zombie.count)))/2), 200)
		love.graphics.setColor(255, 255, 255)
	end

	if gameover == false then

		-- HUD
		love.graphics.setColor(0, 0, 0, 150)
		love.graphics.rectangle("fill", 7, 7, 486, 22 )
		love.graphics.setColor(160, 47, 0, 255)
		love.graphics.rectangle("line", 6, 6, 488, 24 )
		love.graphics.setColor(0, 0, 0, 150)
		love.graphics.rectangle("fill", 501, 7, 278, 22 )
		love.graphics.setColor(160, 47, 0, 255)
		love.graphics.rectangle("line", 500, 6, 280, 24 )
		love.graphics.setColor(0, 0, 0, 150)
		love.graphics.rectangle("fill", 787, 7, 200, 22 )
		love.graphics.setColor(160, 47, 0, 255)
		love.graphics.rectangle("line", 786, 6, 202, 24 )
		love.graphics.setColor(0, 0, 0, 150)
		love.graphics.rectangle("fill", 995, 7, 278, 22 )
		love.graphics.setColor(160, 47, 0, 255)
		love.graphics.rectangle("line", 994, 6, 280, 24 )

		-- HEALTH --
		-- Set health colors
		if self.health1 > 50 then
			self.healthcolor1 = 0
			self.healthcolor2 = 170
			self.healthcolor3 = 0
		end

		if self.health1 < 50 then
			self.healthcolor1 = 255
			self.healthcolor2 = 200
			self.healthcolor3 = 0
		end

		if self.health1 < 25 then
			self.healthcolor1 = 229
			self.healthcolor2 = 40
			self.healthcolor3 = 0
		end

		-- health text
		love.graphics.setFont( start.font0 )
		love.graphics.setColor(160, 47, 0)
		love.graphics.print("HEALTH:", 15, 15)
		
		-- health bars
		love.graphics.setColor(self.healthcolor1, self.healthcolor2, self.healthcolor3)
		love.graphics.rectangle("fill", 125, 12, self.health1 * 3.6, 13)
		love.graphics.setColor(0, 170, 240)

		-- flash health on autoheal
		if self.healthflashtimer < 8 then
			love.graphics.setColor(0, 170, 240, self.gunsflash + 20)
			love.graphics.rectangle("fill", 125, 12, self.health1 * 3.6, 13)
			love.graphics.setColor(255, 255, 255, 255)
		end

		-- draw percentage
		love.graphics.setFont( start.font9 )
		love.graphics.setColor(255, 255, 255)
		love.graphics.print(tostring(math.floor(plyr.health)).."%", 280, 15)
		-- HEALTH --

		-- draw hud item. score, time, wave
		love.graphics.setColor(160, 47, 0)
		love.graphics.setFont( start.font0 )
		love.graphics.print("$"..tostring(math.floor(self.money)), 510, 15)
		love.graphics.print("TIMELEFT:"..tostring(math.floor(self.time)), 1002, 15)
		love.graphics.print("WAVE:"..tostring(self.wave), 795.5, 15)
		love.graphics.setColor(255, 255, 255)

		-- flash the wave text in hud white when the next wave is coming
		if self.wavedrawtime < 5 then
			love.graphics.setFont( start.font0 )
			love.graphics.setColor(255, 255, 255, self.waveflash)
			love.graphics.print("WAVE:"..tostring(self.wave), 795.5, 15)
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
			love.graphics.setFont( start.font2 )
    		love.graphics.setColor(160, 47, 0)
			love.graphics.print("TIME:"..tostring(math.floor(self.time)), (love.graphics.getWidth()/2 - start.font2:getWidth("TIME:"..tostring(math.floor(self.time)))/2), 300)
			--love.graphics.print("KILLS:"..tostring(self.score/10), (love.graphics.getWidth()/2 - start.font2:getWidth("KILLS:"..tostring(self.score/10))/2), 340)
			love.graphics.print("WAVE:"..tostring(self.wave), (love.graphics.getWidth()/2 - start.font2:getWidth("WAVE:"..tostring(self.wave))/2), 380)
			love.graphics.setFont( start.font3 )
			love.graphics.print("$:"..tostring(math.floor(self.money)), (love.graphics.getWidth()/2 - start.font3:getWidth("SCORE:"..tostring(math.floor(self.money)))/2), 440)
			love.graphics.setColor(255, 255, 255)

			-- if the players score is greater then the highscore then make the players score the high score
			if self.money > tonumber(self.highscore) then
				self.highscore = self.money
				love.filesystem.write("endlessscores.lua", "endless.highscore\n=\n"..self.highscore)
			end

			-- print the highscore at the end of the game
			love.graphics.setColor(160, 47, 0)
			love.graphics.print("HIGHSCORE:"..tostring(math.floor(self.highscore)), (love.graphics.getWidth()/2 - start.font3:getWidth("HIGHSCORE:"..tostring(math.floor(self.highscore)))/2), 490)
			love.graphics.setColor(255, 255, 255)
		end
	end

	-- draw game welcome messages
	game:draw()
	------ TEXT ------
end

function love.quit()
	
	-- write to the highscore file before quiting
	love.event.quit()
	love.filesystem.write("endlessscores.lua", "endless.highscore\n=\n"..self.highscore)
end

return endless