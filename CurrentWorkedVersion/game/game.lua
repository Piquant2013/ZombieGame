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

-- Loads smg script
smg = require 'game/weapons/smg'

-- Loads minigun script
minigun = require 'game/weapons/minigun'

-- Loads inv script
inv = require 'game/weapons/inv'

-- Loads killall script
killall = require 'game/weapons/killall'

-- Loads shoe script
shoe = require 'game/weapons/shoe'

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

	-- Flashing text vars
	self.flashbutton = true
	self.buttonflash = 0
	------ VARIABLES ------

	------ AUDIO ------
	self.music1 = love.audio.newSource("audio/music/game.ogg")
	self.music2 = love.audio.newSource("audio/music/credits.ogg")
	self.intromusic = love.audio.newSource("audio/music/gameintro.ogg")
	self.entersound = love.audio.newSource("audio/buttons/enter.ogg")
	self.pickupsound = love.audio.newSource("audio/weapons/pickup.ogg")
	self.wavestart = love.audio.newSource("audio/wave/start.ogg")
	self.waveend = love.audio.newSource("audio/wave/end.ogg")
	------ AUDIO ------
end

function playercollision(dt, shape_a, shape_b, mtv_x, mtv_y)

	local other

	-- Set soild objects for player
    if shape_a == plyr.bb then
        
        -- set to shape	
        other = shape_b

        if gameover == false then
        	
        	-- if player hits wall
        	if other == endless.wallT or other == endless.wallB or other == endless.wallL or other == endless.wallR then
        		plyr.yvel = 0
        		plyr.xvel = 0
        		shape_a:move(mtv_x, mtv_y)
        		plyr.y = plyr.y + mtv_y
        		plyr.x = plyr.x + mtv_x
      		end

      		-- If player hits tree
      		if other == endless.tree1 or other == endless.tree2 or other == endless.tree3 or other == endless.tree4 then
        		plyr.yvel = 0
        		plyr.xvel = 0
        		shape_a:move(mtv_x, mtv_y)
        		plyr.y = plyr.y + mtv_y
        		plyr.x = plyr.x + mtv_x
      		end
      	end
    
    elseif shape_b == plyr.bb then
        
        -- set to shape	
        other = shape_a
       	
       	if gameover == false then
       		
       		-- if player hits wall
       		if other == endless.wallT or other == endless.wallB or other == endless.wallL or other == endless.wallR then
       			plyr.yvel = 0
        		plyr.xvel = 0
       			shape_b:move(-mtv_x, -mtv_y)
       			plyr.y = plyr.y + -mtv_y
        		plyr.x = plyr.x + -mtv_x
    		end

    		-- If player hits tree
    		if other == endless.tree1 or other == endless.tree2 or other == endless.tree3 or other == endless.tree4 then
       			plyr.yvel = 0
        		plyr.xvel = 0
       			shape_b:move(-mtv_x, -mtv_y)
       			plyr.y = plyr.y + -mtv_y
        		plyr.x = plyr.x + -mtv_x
    		end
    	end
    
    else
        return
    end




    if gamereset == false then
       		
       	-- if player hits zombie
   		for i, o in ipairs(zombie.zombs) do
    		if other == o.bb then
    			plyr.health = plyr.health - 0.4
    			plyr.hurt = true
    			love.audio.play(plyr.hurtaudio)
    		end
    	end
    end




  	if setendless == false then

   		-- if player hits zombie
   		for i, o in ipairs(zombie.zombs) do
    		if other == o.bb then
    		
    			if endless.invhave == false then
    				plyr.health = plyr.health - 0.4
    				plyr.hurt = true
    				love.audio.play(plyr.hurtaudio)
    			end

    			if endless.invhave == true then
					o.health = o.health - 10
					love.audio.play(o.damageaudio)
					Collider:remove(o.bb)

					-- kill zombies
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
    
    	-- if player hits smg
    	for i, o in ipairs(smg.smgs) do
    		if other == o.bb then
    			endless.smghad = true
    			endless.smghave = true
    			endless.minihave = false
    			endless.invhave = false
    			endless.killallhave = false
    			Collider:remove(o.bb)
    			love.audio.play(game.pickupsound)
    		end
    	end

    	-- if player hits minigun
    	for i, o in ipairs(minigun.miniguns) do
    		if other == o.bb then
    			endless.minihad = true
    			endless.minihave = true
    			endless.smghave = false
    			endless.invhave = false
    			endless.killallhave = false
    			Collider:remove(o.bb)
    			love.audio.play(game.pickupsound)
    		end
    	end

    	-- if player hits inv
    	for i, o in ipairs(inv.invs) do
    		if other == o.bb then
    			endless.invhad = true
    			endless.invhave = true
    			endless.smghave = false
    			endless.minihave = false
    			endless.killallhave = false
    			Collider:remove(o.bb)
    			love.audio.play(game.pickupsound)
    		end
    	end

    	-- if player hits killall
    	for i, o in ipairs(killall.killalls) do
    		if other == o.bb then
    			endless.killallhad = true
    			endless.killallhave = true
    			Collider:remove(o.bb)
    			love.audio.play(game.pickupsound)
    		end
    	end

    	-- if player hits shoe
    	for i, o in ipairs(shoe.shoes) do
    		if other == o.bb then
    			endless.shoehad = true
    			endless.shoehave = true
    			Collider:remove(o.bb)
    			love.audio.play(game.pickupsound)
    		end
    	end
	end
end

function zombiecollision(dt, shape_a, shape_b, mtv_x, mtv_y)

	-- ADD ANOTHER DAY --
	--for i = 1, #zombie.zombs do
		--for j = i + 1, #zombie.zombs do

			--local other

			--if shape_a == zombie.zombs[i].bb then
					
				--other = shape_b

				--if other == zombie.zombs[j].bb then
					--shape_a:move(mtv_x, mtv_y)
        			--zombie.zombs[i].y = zombie.zombs[i].y + mtv_y
        			--zombie.zombs[i].x = zombie.zombs[i].x + mtv_x
				--end

			--elseif shape_b == zombie.zombs[i].bb then
				
				--other = shape_a

				--if other == zombie.zombs[j].bb then
					--shape_a:move(-mtv_x, -mtv_y)
        			--zombie.zombs[i].y = zombie.zombs[i].y + -mtv_y
        			--zombie.zombs[i].x = zombie.zombs[i].x + -mtv_x
				--end
			--end
		--end
	--end
	-- ADD ANOTHER DAY --

	-- ENDLESS --
	if setendless == false then
		for i, o in ipairs(zombie.zombs) do

			local other

			-- Set soild objects for zombies
			if shape_a == o.bb then
				
				-- set to shape	
				other = shape_b

				-- if zombie hits tress
      			if other == endless.tree1 or other == endless.tree2 or other == endless.tree3 or other == endless.tree4 then
        			shape_a:move(mtv_x, mtv_y)
        			o.y = o.y + mtv_y
        			o.x = o.x + mtv_x
      			end

      			-- if zombie hits player
      			if gameover == false then
      				if other == plyr.bb then
        				shape_a:move(mtv_x, mtv_y)
        				o.y = o.y + mtv_y
        				o.x = o.x + mtv_x
      				end
      			end

			elseif shape_b == o.bb then
				
				-- set to shape
				other = shape_a

				-- if zombie hits tress
				if other == endless.tree1 or other == endless.tree2 or other == endless.tree3 or other == endless.tree4 then
        			shape_b:move(-mtv_x, -mtv_y)
        			o.y = o.y + -mtv_y
        			o.x = o.x + -mtv_x
      			end

      			-- if zombie hits player
      			if gameover == false then
      				if other == plyr.bb then
        				shape_a:move(-mtv_x, -mtv_y)
        				o.y = o.y + -mtv_y
        				o.x = o.x + -mtv_x
      				end
      			end
			end
		end
	end

	if setendless == false then
		for i, o in ipairs(zombie.zombs) do
			for c, v in ipairs(pistol.bullets) do

				-- Set zombie hitbox to a shape
				local other

				if shape_a == o.bb then
					other = shape_b
				elseif shape_b == o.bb then
					other = shape_a
				end

				-- if bullet hits zombie
				if other == v.bb then
					o.health = o.health - 10
					love.audio.play(o.damageaudio)
					Collider:remove(v.bb)
					table.remove(pistol.bullets, c)

					-- kill zombies
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
	-- ENDLESS --

	-- STUCK --
	if gamereset == false then
		for i, o in ipairs(zombie.zombs) do
			for c, v in ipairs(crpistol.bullets) do

				-- Set zombies hitbox to a shape
				local other

				if shape_a == o.bb then
					other = shape_b
				elseif shape_b == o.bb then
					other = shape_a
				end

				-- if bullet hits zombie
				if other == v.bb then
					o.health = o.health - 10
					love.audio.play(o.damageaudio)
					Collider:remove(v.bb)
					table.remove(crpistol.bullets, c)

					-- kill zombies
					if o.health < 0 then
						o.health = 0
						stuckmode.score = stuckmode.score + 1
						stuckmode.kills = stuckmode.kills + 1

						-- increase difficulty as zombies die
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
							zombie.speed = zombie.speed + 0.12
						end
       
       					-- remove zombie if dies
						Collider:remove(o.bb)
						table.remove(zombie.zombs, i)
					end
				end
			end
		end
	end
	-- STUCK --
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

    -- stop player from getting hurt when not hitting zombies
	plyr.hurt = false
end

function zombiecollisionstopped(dt, shape_a, shape_b)
end

function on_collision(dt, shape_a, shape_b, mtv_x, mtv_y)
	
	-- if collisions start
	playercollision(dt, shape_a, shape_b, mtv_x, mtv_y)
	zombiecollision(dt, shape_a, shape_b, mtv_x, mtv_y)
end

function collision_stop(dt, shape_a, shape_b, mtv_x, mtv_y)
	
	-- if collisions stop
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
end

function game:mousepressed(mx, my, button)

	-- dissmiss the welcome message for endless mode
  	if button == "l" and welcomescreen == true and self.endless == true then
  		welcomescreen = false
  		setendless = false
  		love.audio.play(self.entersound)
		love.audio.stop(self.intromusic)
		love.audio.play(self.music1)
		self.music1:setVolume(1.0)
		self.music1:setLooping(true)
  	end

  	-- dissmiss the welcome message for stuck mode
  	if button == "l" and welcomescreen == true and self.stuck == true then
		welcomescreen = false
  		gamereset = false
  		love.audio.play(self.entersound)
		love.audio.stop(self.intromusic)
		love.audio.play(self.music1)
		self.music1:setVolume(1.0)
		self.music1:setLooping(true)
  	end
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

	-- add to the the crpistol bullet to players group
	for i, o in ipairs(crpistol.bullets) do
		Collider:addToGroup("players", o.bb)
	end

	-- Update player, pistol, hardon collider, etc
	player:update(dt)
	player:health(dt)
	Collider:update(dt)

    -- if game is paused switch to the pause screen
	if paused == true then
		Gamestate.push(pause)
	end

	-- Flash start button text
	if self.flashbutton == true then
		self.buttonflash = self.buttonflash + dt + 2
	elseif self.flashbutton == false then
		self.buttonflash = self.buttonflash + dt - 2
	end
	
	if self.buttonflash > 100 then
		self.flashbutton = false
	elseif self.buttonflash < 2 then
		self.flashbutton = true
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
		love.graphics.print("WELCOME! THANK YOU FOR TAKING THE TIME", 60, 70)
		love.graphics.print("TO TEST PIQUANT INTERACTIVE'S PROJECT,", 60, 110)
		love.graphics.print("ZOMBIE GAME. THIS GAME MODE HAS YOU", 60, 150)
		love.graphics.print("BATTLING ZOMBIES IN AN ENDLESS, WAVE", 60, 190)
		love.graphics.print("BASED SURVIVAL SHOOTER WITH NAUGHT BUT", 60, 230)
		love.graphics.print("YOUR WIT AND YOUR PISTOL. DON'T DIE!", 60, 270)
		love.graphics.setFont( start.font1 )
		love.graphics.print("CONTORLS:", 60, 360)
		love.graphics.print("SHOOT: LEFT-CLICK", 60, 385)
		love.graphics.print("AIMASSIST: RIGHT-CLICK", 60, 410)
		love.graphics.print("MOVEMENT: WASD", 60, 435)
		love.graphics.print("PAUSE: ESC", 60, 455)
		love.graphics.print("LEAVE ANY FEEDBACK YOU", 60, 540)
		love.graphics.print("MAY HAVE AT", 60, 565)
		love.graphics.print("[REDDIT.COM/R/PIQUANT2013/]", 60, 585)
		love.graphics.print("AS WE LOVE PLAYER", 60, 610)
		love.graphics.print("INTERACTION.", 60, 635)
		love.graphics.setFont( start.font2 )
		love.graphics.print("PRESS START", 765, 465)
		love.graphics.print("BUTTON", 765 + start.font2:getWidth( "PRESS START" )/2 - start.font2:getWidth( "BUTTON" )/2, 505)
		love.graphics.setColor(255, 255, 255, self.buttonflash)
		love.graphics.print("PRESS START", 765, 465)
		love.graphics.print("BUTTON", 765 + start.font2:getWidth( "PRESS START" )/2 - start.font2:getWidth( "BUTTON" )/2, 505)
		love.graphics.setColor(255, 255, 255)
	end

	-- draw the welcome text and bacground for stuck mode
	 if welcomescreen == true and self.stuck == true then
    	love.mouse.setCursor(cursor)
    	love.graphics.draw(start.bg, 0, -1000, 0, 3)
    	love.graphics.setColor(160, 47, 0)
    	love.graphics.setFont( start.font2 )
		love.graphics.print("THANK YOU FOR TAKING THE TIME TO TEST", 60, 70)
		love.graphics.print("PIQUANT INTERACTIVE'S PROJECT, ZOMBIE", 60, 110)
		love.graphics.print("GAME. THIS MODE DOESNT ALLOW PLAYER", 60, 150)
		love.graphics.print("MOVEMENT; HENCE THE NAME. YOU WILL", 60, 190)
		love.graphics.print("REQUIRE 3 THINGS: FAST REFLEXES, QUICK", 60, 230)
		love.graphics.print("TIGGER FINGER, AND THE WILL TO SURVIVE.", 60, 270)
		love.graphics.setFont( start.font1 )
		love.graphics.print("CONTORLS:", 60, 360)
		love.graphics.print("SHOOT: LEFT-CLICK", 60, 385)
		love.graphics.print("AIMASSIST: RIGHT-CLICK", 60, 410)
		love.graphics.print("MOVEMENT: WASD", 60, 435)
		love.graphics.print("PAUSE: ESC", 60, 455)
		love.graphics.print("LEAVE ANY FEEDBACK YOU", 60, 540)
		love.graphics.print("MAY HAVE AT", 60, 565)
		love.graphics.print("[REDDIT.COM/R/PIQUANT2013/]", 60, 585)
		love.graphics.print("AS WE LOVE PLAYER", 60, 610)
		love.graphics.print("INTERACTION.", 60, 635)
		love.graphics.setFont( start.font2 )
		love.graphics.print("PRESS START", 765, 465)
		love.graphics.print("BUTTON", 765 + start.font2:getWidth( "PRESS START" )/2 - start.font2:getWidth( "BUTTON" )/2, 505)
		love.graphics.setColor(255, 255, 255, self.buttonflash)
		love.graphics.print("PRESS START", 765, 465)
		love.graphics.print("BUTTON", 765 + start.font2:getWidth( "PRESS START" )/2 - start.font2:getWidth( "BUTTON" )/2, 505)
		love.graphics.setColor(255, 255, 255)
	end
	------ TEXT ------
end

return game