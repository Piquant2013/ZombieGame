local Gamestate = require 'libs/hump/gamestate'
local camera = require "libs/hump/camera"
local HC = require 'libs/hardoncollider'
pause = require 'game/menus/pause'
player = require 'game/player'
pistol = require 'game/weapons/pistol'
clickratepistol = require 'game/weapons/clickrate-pistol'
zombie = require 'game/zombie'
game = Gamestate.new()

--[[
function game:init()

	------ VARIABLES ------
	-- Set up hardon collider
	Collider = HC(100, on_collision, collision_stop)

	-- Load player and pistol vars
    player:initialize()
    pistol:initialize()
    clickratepistol:initialize()
	
	-- Camera
	self.Cam = camera(plyr.x, plyr.y, 2.5)
	------ VARIABLES ------

	------ AUDIO ------
	self.music1 = love.audio.newSource("audio/music/game.ogg")
	self.intromusic = love.audio.newSource("audio/music/gameintro.ogg")
	self.entersound = love.audio.newSource("audio/buttons/enter.ogg")
	------ AUDIO ------
end


function endless:update(dt)

	-- SET UP GAME --
	-- Reset the game
	if setendless == true then

		-- Player
		plyr.y = 200
		plyr.x = 400
		plyr.speed = 80
		plyr.health = 100
		plyr.hurt = false
		plyr.colliding = false
		player.hurttimer = 0
		player.flashred = false

		-- Pistol
		pis.y = plyr.y
		pis.x = plyr.x
		pistol.cooldown = 0
		pistol.cooldownplus = 0.25
		pistol.bullets = {}

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
	pistol:update(dt)
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
		pistol.cooldown = 0
		pistol.cooldownplus = 0
		pistol.bullets = {}
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

function endless:draw()
	
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
	pistol:bulletdraw()

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
	pistol:draw()

	-- zombies
	zombie:draw()

	-- layer2 of the map
	love.graphics.draw(self.layer2, 0, 0)

	-- draw wall hitboxs
	--self.tree1:draw('line')
	--self.tree2:draw('line')
	--self.tree3:draw('line')
	--self.tree4:draw('line')
	--self.wallL:draw('line')
	--self.wallR:draw('line')
	--self.wallT:draw('line')
	--self.wallB:draw('line')

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
		love.graphics.print("ZOMBIE GAME. THIS GAME MODE HAS YOU", (love.graphics.getWidth()/2 - start.font2:getWidth( "ZOMBIE GAME. THIS GAME MODE HAS YOU" )/2), 180)
		love.graphics.print("BATTLING ZOMBIES IN AN ENDLESS, WAVE", (love.graphics.getWidth()/2 - start.font2:getWidth( "BATTLING ZOMBIES IN AN ENDLESS, WAVE" )/2), 230)
		love.graphics.print("BASED SURVIVAL SHOOTER WITH NAUGHT BUT", (love.graphics.getWidth()/2 - start.font2:getWidth( "BASED SURVIVAL SHOOTER WITH NAUGHT BUT" )/2), 280)
		love.graphics.print("YOUR WIT AND YOUR PISTOL. DON'T DIE!", (love.graphics.getWidth()/2 - start.font2:getWidth( "YOUR WIT AND YOUR PISTOL. DON'T DIE!" )/2), 330)
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

return endless
--]]












































function playercollision(dt, shape_a, shape_b, mtv_x, mtv_y)
	local other

    if shape_a == plyr.bb then
        other = shape_b
    elseif shape_b == plyr.bb then
        other = shape_a
    else
        return
    end

    for i, o in ipairs(zombie.zombs) do
    	if other == o.bb then
    		plyr.health = plyr.health - 0.4
    		plyr.hurt = true
    	end
    end
end

function playercollisionstopped(dt, shape_a, shape_b, mtv_x, mtv_y)
	plyr.hurt = false
	
	if setendless == false then
		plyr.speed = 80
	end
end

function zombiecollision(dt, shape_a, shape_b, mtv_x, mtv_y)
	if setendless == false then
		for i, o in ipairs(zombie.zombs) do
			for c, v in ipairs(pistol.bullets) do

				local other

				if shape_a == o.bb then
					other = shape_b
				elseif shape_b == o.bb then
					other = shape_a
				end

				if other == v.bb then
					o.health = o.health - 10
					Collider:remove(v.bb)
					table.remove(pistol.bullets, c)

					if o.health < 0 then
						o.health = 0
						endless.score = endless.score + 10
						endless.kills = endless.kills + 1
						zombie.count = zombie.count - 1         
						Collider:remove(o.bb)
						table.remove(zombie.zombs, i)
					end
				end
			end
		end
	end

	if gamereset == false then
		for i, o in ipairs(zombie.zombs) do
			for c, v in ipairs(clickratepistol.bullets) do

				local other

				if shape_a == o.bb then
					other = shape_b
				elseif shape_b == o.bb then
					other = shape_a
				end

				if other == v.bb then
					o.health = o.health - 10
					Collider:remove(v.bb)
					table.remove(clickratepistol.bullets, c)

					if o.health < 0 then
						o.health = 0
						stuckmode.score = stuckmode.score + 10
						stuckmode.kills = stuckmode.kills + 1
						zombie.count = zombie.count - 1         
						Collider:remove(o.bb)
						table.remove(zombie.zombs, i)
					end
				end
			end
		end
	end
end

function zombiecollisionstopped(dt, shape_a, shape_b, mtv_x, mtv_y)
	for i, o in ipairs(zombie.zombs) do
		o.speed = zombie.speed
	end
end


function on_collision(dt, shape_a, shape_b, mtv_x, mtv_y)
	player:collision(dt, shape_a, shape_b, mtv_x, mtv_y)
	playercollision(dt, shape_a, shape_b, mtv_x, mtv_y)
	zombiecollision(dt, shape_a, shape_b, mtv_x, mtv_y)
end

function collision_stop(dt, shape_a, shape_b, mtv_x, mtv_y)
	player:collisionstopped(dt, shape_a, shape_b, mtv_x, mtv_y)
	playercollisionstopped(dt, shape_a, shape_b, mtv_x, mtv_y)
	zombiecollisionstopped(dt, shape_a, shape_b, mtv_x, mtv_y)
end












return game