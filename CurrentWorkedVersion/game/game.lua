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

-- Loads pistol script
pistol = require 'game/weapons/pistol'

-- Loads crpistol script
crpistol = require 'game/weapons/clickrate-pistol'

-- Loads zombie script
zombie = require 'game/zombie'

-- Creates game as a new gamestate
game = Gamestate.new()


function game:init()

	------ VARIABLES ------
	-- Set up hardon collider
	Collider = HC(100, on_collision, collision_stop)

	-- Load player, pistol, etc vars
    player:initialize()
    pistol:initialize()
    crpistol:initialize()

    -- gamemodes
    self.endless = false
    self.stuck = false
	
	-- Camera
	self.Cam = camera(plyr.x, plyr.y, 2.5)
	------ VARIABLES ------

	------ AUDIO ------
	self.music1 = love.audio.newSource("audio/music/game.ogg")
	self.music2 = love.audio.newSource("audio/music/credits.ogg")
	self.intromusic = love.audio.newSource("audio/music/gameintro.ogg")
	self.entersound = love.audio.newSource("audio/buttons/enter.ogg")
	------ AUDIO ------
end

function playercollision(dt, shape_a, shape_b, mtv_x, mtv_y)

	-- Set player hitbox to a shape
	local other

    if shape_a == plyr.bb then
        other = shape_b
    elseif shape_b == plyr.bb then
        other = shape_a
    else
        return
    end

    -- Temp collision resposne for walls around map
   	if other == endless.wallT then
   		plyr.yvel = 0
   		plyr.y = plyr.y + 5 + mtv_y
   	elseif other == endless.wallB then
   		plyr.yvel = 0
   		plyr.y = plyr.y - 5 - mtv_y
   	elseif other == endless.wallL then
   		plyr.xvel = 0
   		plyr.x = plyr.x + 5 + mtv_x
   	elseif other == endless.wallR then
   		plyr.xvel = 0
   		plyr.x = plyr.x - 5 - mtv_x
   	end

   	-- If zombie hits player
   	for i, o in ipairs(zombie.zombs) do
    	if other == o.bb then
    		plyr.health = plyr.health - 0.4
    		plyr.hurt = true
    		love.audio.play(plyr.hurtaudio)
    	end
    end
end

function zombiecollision(dt, shape_a, shape_b, mtv_x, mtv_y)
	
	-- COLLISIONS FOR ENDLESS --
	if setendless == false then
		for i, o in ipairs(zombie.zombs) do
			for c, v in ipairs(pistol.bullets) do

				local other

				if shape_a == o.bb then
					other = shape_b
				elseif shape_b == o.bb then
					other = shape_a
				end

				-- Zombie hit
				if other == v.bb then
					o.health = o.health - 10
					love.audio.play(o.damageaudio)
					Collider:remove(v.bb)
					table.remove(pistol.bullets, c)

					-- Kill zombie
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
	-- COLLISIONS FOR ENDLESS --

	-- COLLISIONS FOR STUCK --
	if gamereset == false then
		for i, o in ipairs(zombie.zombs) do
			for c, v in ipairs(crpistol.bullets) do

				local other

				if shape_a == o.bb then
					other = shape_b
				elseif shape_b == o.bb then
					other = shape_a
				end

				-- Zombie Hit
				if other == v.bb then
					o.health = o.health - 10
					love.audio.play(o.damageaudio)
					Collider:remove(v.bb)
					table.remove(crpistol.bullets, c)

					-- Kill zombie
					if o.health < 0 then
						o.health = 0
						stuckmode.score = stuckmode.score + 1
						stuckmode.kills = stuckmode.kills + 1

						if stuckmode.score < 300 then
							zombie.spawnrateplus = zombie.spawnrateplus - 0.004
							zombie.speed = zombie.speed + 0.4
						elseif stuckmode.score > 300 and stuckmode.score < 700 then
							zombie.spawnrateplus = zombie.spawnrateplus - 0.003
							zombie.speed = zombie.speed + 0.3
						elseif stuckmode.score > 700 and stuckmode.score < 1200 then
							zombie.spawnrateplus = zombie.spawnrateplus - 0.0015
							zombie.speed = zombie.speed + 0.15
						elseif stuckmode.score > 1200 then
							zombie.spawnrateplus = zombie.spawnrateplus - 0.0012
							zombie.speed = zombie.speed + 0.12
						end

						--zombie.count = zombie.count - 1         
						Collider:remove(o.bb)
						table.remove(zombie.zombs, i)
					end
				end
			end
		end
	end
	-- COLLISIONS FOR STUCK --
end

function playercollisionstopped(dt, shape_a, shape_b)
	
	-- Set player hitbox to a shape
	local other

    if shape_a == plyr.bb then
        other = shape_b
    elseif shape_b == plyr.bb then
        other = shape_a
    else
        return
    end

    -- Turn player hurt off
	plyr.hurt = false
end

function zombiecollisionstopped(dt, shape_a, shape_b)
end

function on_collision(dt, shape_a, shape_b, mtv_x, mtv_y)
	playercollision(dt, shape_a, shape_b, mtv_x, mtv_y)
	zombiecollision(dt, shape_a, shape_b, mtv_x, mtv_y)
end

function collision_stop(dt, shape_a, shape_b, mtv_x, mtv_y)
	playercollisionstopped(dt, shape_a, shape_b)
	zombiecollisionstopped(dt, shape_a, shape_b)
end

function game:keypressed(key)

	-- dissmiss the welcome message for endless mode
  	if key == "return" and welcomescreen == true and self.endless == true or key == " " and welcomescreen == true and self.endless == true then
  		welcomescreen = false
  		setendless = false
  		love.audio.play(self.entersound)
		love.audio.stop(self.intromusic)
		love.audio.play(self.music1)
		self.music1:setVolume(1.0)
		self.music1:setLooping(true)
  	end

  	-- dissmiss the welcome message for stuck mode
  	if key == "return" and welcomescreen == true and self.stuck == true or key == " " and welcomescreen == true and self.stuck == true then
		welcomescreen = false
  		gamereset = false
  		love.audio.play(self.entersound)
		love.audio.stop(self.intromusic)
		love.audio.play(self.music1)
		self.music1:setVolume(1.0)
		self.music1:setLooping(true)
  	end

  	-- Pause the game
  	if key == "escape" and paused == false and welcomescreen == false and gameover == false then
   		paused = true
   		resume = false
   		love.mouse.setCursor(cursor)
  	end

  	-- for debug
  	--if key == "z" then
  		--self.Cam:zoom(0.5)
  	--end

  	-- key == "x" then
  		--self.Cam:zoom(2)
  	--end
end

function game:update(dt)

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

	-- Update player, pistol, hardon collider, etc
	player:update(dt)
	player:health(dt)
	Collider:update(dt)

    -- if game is paused switch to the pause screen
	if paused == true then
		Gamestate.push(pause)
	end
end

function love.focus(f)
	
	-- pause the game if window loses focus
	if not f then
		if paused == false and welcomescreen == false and game.endless == true or game.stuck == true and gameover == false then  
			paused = true
			resume = false
   			love.mouse.setCursor(cursor)
   		end 
	end
end

function game:draw()
	
	------ FILTERS ------
	start.font1:setFilter( 'nearest', 'nearest' )
	start.font2:setFilter( 'nearest', 'nearest' )
	start.font3:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------
	
	------ TEXT ------
	-- draw the welcome text and background for endless mode
	 if welcomescreen == true and self.endless == true then
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
		love.graphics.setColor(255, 255, 255)
	end

	-- draw the welcome text and bacground for stuck mode
	 if welcomescreen == true and self.stuck == true then
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
		love.graphics.setColor(255, 255, 255)
	end
	------ TEXT ------
end

return game