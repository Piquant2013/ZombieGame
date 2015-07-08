-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads Hardon Collider script
local HC = require 'libs/hardoncollider'

-- Loads gamestate script
game = require 'game/game'

-- Creates endless as a new gamestate
endless = Gamestate.new()


function endless:init()

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
	self.minicount = 1
	self.smgcount = 1
	self.spawnsmg = false
	self.spawnmini = false
	self.minihave = false
	self.smghave = false
	self.minihad = false
	self.smghad = false
	self.gunsflash = 2
	self.flashguns = true

	-- Gameover vars
	self.gameovery = 800
	self.fadebg = 0
	self.bgtimer = 0
	------ VARIABLES ------

	------ IMAGES ------
	self.layer1 = love.graphics.newImage("images/maps/endless-layer1.png")
	self.layer2 = love.graphics.newImage("images/maps/endless-layer2.png")
	self.hud1 = love.graphics.newImage("images/hud/hud1.png")
	self.hud2 = love.graphics.newImage("images/hud/hud2.png")
	self.hud3 = love.graphics.newImage("images/hud/hud3.png")
	------ IMAGES ------
end

function endless:keypressed(key)
	
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
  	if key == "return" and gameover == true and endless.bgtimer < 12 or key == " " and gameover == true and endless.bgtimer < 12 or key == "escape" and gameover == true and endless.bgtimer < 12 then
  		self.bgtimer = 13
  		self.fadebg = 255
		self.gameovery = 200
  	end
end

function endless:mousepressed(mx, my, button)
	
	-- aim assit for pistol
	pistol:aim(mx, my, button)

	-- load game mousepressed inputs for welcome screen, gameover, etc
	game:mousepressed(mx, my, button)
end

function endless:update(dt)

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

		-- Pistol
		pis.y = plyr.y
		pis.x = plyr.x
		pistol.cooldown = 0
		pistol.cooldownplus = 0.25
		pistol.bullets = {}

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
		self.wavezombiecount = 50
		self.minicount = 1
		self.smgcount = 1
		self.spawnsmg = false
		self.spawnmini = false
		self.minihave = false
		self.smghave = false
		self.minihad = false
		self.smghad = false
		self.gunsflash = 2
		self.flashguns = true

		-- Gameover vars
		self.gameovery = 800
		self.fadebg = 0
		self.bgtimer = 0

		-- Globals
		paused = false
		
		-- Zombie
    	zombie.zombs = {}
    	zombie.spawnrate = 0
		zombie.spawnrateplus = 0.4
		zombie.speed = 60
		zombie.health = 1
		zombie.count = 0

		-- Smg
		smg.smgs = {}
    	smg.spawnrate = 0
		smg.spawnrateplus = 1
		smg.count = 0

		-- Minigun
		minigun.miniguns = {}
		minigun.spawnrate = 0
		minigun.spawnrateplus = 1
		minigun.count = 0
		
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
	pistol:update(dt)

	-- set vars for gameover
	if gameover == true then
		pistol.cooldown = 0
		pistol.cooldownplus = 0
		pistol.bullets = {}
		plyr.y = plyr.y
		plyr.x = plyr.x
		love.mouse.setCursor(cursor)
		love.audio.stop(plyr.hurtaudio)
		love.audio.play(plyr.deathaudio)
		love.audio.stop(game.music1)
		love.audio.play(game.music2)
		self.wavestart = false
	end

	-- SPECIAL WEAPONS --
	if self.wave > 1 then
		
		-- if ammo is 0 player loses smg
		for i, o in ipairs(smg.smgs) do
			if self.smghave == true and o.ammo == 0 then
				self.smghave = false
				love.audio.play(menu.backsound)
			end
		end

		-- if ammo is 0 player loses minigun
		for i, o in ipairs(minigun.miniguns) do
			if self.minihave == true and o.ammo == 0 then
				self.minihave = false
				love.audio.play(menu.backsound)
			end
		end

		-- Set fire rates
		if self.smghave == true then
			pistol.cooldownplus = 0.065
			self.minihave = false
			self.pistolhave = false
		end

		if self.minihave == true then
			pistol.cooldownplus = 0.030
			self.smghave = false
			self.pistolhave = false
		end

		if self.pistolhave == true then
			pistol.cooldownplus = 0.25
		end

		-- Set ammo
		if self.minihave == false then
			for i, o in ipairs(minigun.miniguns) do
				o.ammo = 150
			end

			self.pistolhave = true
		end

		if self.smghave == false then		
			for i, o in ipairs(smg.smgs) do
				o.ammo = 80
			end

			self.pistolhave = true
		end

		-- Spawn special weapons
		if self.spawnsmg == true then
			smg:spawn()
		end

		if self.spawnmini == true then
			minigun:spawn()
		end

		-- spawning
		if self.wavebreak == false then
			if minigun.count == self.minicount then
				self.spawnmini = false
			elseif minigun.count < self.minicount then
				self.spawnmini = true
			end

			if smg.count == self.smgcount then
				self.spawnsmg = false
			elseif smg.count < self.smgcount then
				self.spawnsmg = true
			end
		end

		if self.wavebreak == true then
			self.spawnmini = false
			self.spawnsmg = false
		
			if self.smghad == true and self.smghave == false then
				smg.count = 0
				table.remove(smg.smgs, i)
				self.smghad = false
			end

			if self.minihad == true and self.minihave == false then
				minigun.count = 0
				table.remove(minigun.miniguns, i)
				self.minihad = false
			end
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
	end
	-- SPECIAL WEAPONS --

	-- WAVE SYSTEM --
	-- start the score time
	if gameover == false then
		self.time = self.time + dt
		self.wavebreaktimer = self.wavebreaktimer + dt
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
		if self.wavebreaktimer < 8 then
			self.wavestart = false
		elseif self.wavebreaktimer > 8 then
			self.wavestart = true
			self.wavebreak = false
		end
	end

	-- when you kill 100 go to next wave, increase spawn rate, increase spawn amount
	if self.kills > 100 then
		self.kills = 0
		zombie.spawnrateplus = zombie.spawnrateplus - 0.05
		zombie.speed = zombie.speed + 1.5
		self.wavedrawtime = 0
		self.waveflash = 2
		self.wave = self.wave + 1
		self.wavezombiecount = self.wavezombiecount + 8
		self.wavebreaktimer = 0
		self.wavebreak = true
		self.flashwave = true
		love.audio.play(game.wavestart)
	end

	-- lock the spawn rate
	if zombie.spawnrateplus < 0.05 then
		zombie.spawnrateplus = 0.05
	end

	-- lock the wave count
	if zombie.speed > 100 then
		zombie.speed = 100
	end

	-- lock the wave count
	if self.wavezombiecount > 150 then
		self.wavezombiecount = 150
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

	-- update minigun
	minigun:update(dt)
	
	-- update smg
	smg:update(dt)

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

function endless:draw()

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
	pistol:bulletdraw()

	-- Aim
	pistol:aimdraw()

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

	-- minigun
	minigun:draw()
	
	-- smg
	smg:draw()

	-- pistol
	pistol:draw()

	-- zombies
	zombie:draw()

	-- layer2 of the map
	love.graphics.draw(self.layer2, 0, 0)

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

	-- the hud text and images
	if gameover == false then
		love.graphics.draw(self.hud1, 0, -25, 0, 0.5)
		love.graphics.draw(self.hud2, -30, 665, 0, 0.5)
		love.graphics.draw(self.hud3, 500 - 6, 685, 0, 0.5)
		love.graphics.setColor(0, 0, 0)
		love.graphics.setFont( start.font0 )
		love.graphics.setColor(160, 47, 0)
		love.graphics.print("HEALTH:", 10, 10)
		love.graphics.print(tostring(math.floor(plyr.health)).."%", 10, 30)
		love.graphics.print("SCORE:", 1150, 10)
		love.graphics.print(tostring(self.score), 1150, 30)
		love.graphics.print("TIME:"..tostring(math.floor(self.time)), (love.graphics.getWidth()/2 - start.font0:getWidth("TIME:"..tostring(math.floor(self.time)))/2), 700)
		
		-- draw text for ammo for differnt guns
		if self.smghave == false and self.minihave == false then
			love.graphics.print("AMMO: ∞", 10, 680)
			love.graphics.print("PISTOL", 10, 700)
		end
		
		if self.smghave == true then
			for i, o in ipairs(smg.smgs) do
				love.graphics.print("SMG", 10, 700)
				love.graphics.print("AMMO:"..tostring(o.ammo), 10, 680)
			end
		end

		if self.minihave == true then
			for i, o in ipairs(minigun.miniguns) do
				love.graphics.print("MINIGUN", 10, 700)
				love.graphics.print("AMMO:"..tostring(o.ammo), 10, 680)
			end
		end

		-- Wave title in hud
		love.graphics.setFont( start.font1 )
		love.graphics.print("WAVE:"..tostring(self.wave), (love.graphics.getWidth()/2 - start.font1:getWidth("WAVE:")/2), 10)
		love.graphics.setColor(255, 255, 255)

		-- flash the wave text in hud white when the next wave is coming
		if self.wavedrawtime < 5 then
			love.graphics.setFont( start.font1 )
			love.graphics.setColor(255, 255, 255, self.waveflash)
			love.graphics.print("WAVE:"..tostring(self.wave), (love.graphics.getWidth()/2 - start.font1:getWidth("WAVE:")/2), 10)
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
			love.graphics.print("WAVE:"..tostring(self.wave), (love.graphics.getWidth()/2 - start.font3:getWidth("WAVE:"..tostring(self.wave))/2), 400)
			love.graphics.setColor(255, 255, 255)
		end
	end

	-- draw game welcome messages
	game:draw()
	------ TEXT ------
end

return endless