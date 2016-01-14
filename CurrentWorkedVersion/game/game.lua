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
pistol = require 'game/weapons/shotgun' --pistol

-- Loads crpistol script
crpistol = require 'game/weapons/crpistol'

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

-- Loads heart script
heart = require 'game/weapons/heart'

-- Loads heart script
oneup = require 'game/weapons/oneup'

-- Loads heart script
questionmark = require 'game/weapons/questionmark'

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
    self.arcade = false
    self.stuck = false
	
	-- Camera
	self.Cam = camera(plyr.x, plyr.y, 2.5)

	-- Flashing text vars
	self.flashbutton = true
	self.buttonflash = 0
	------ VARIABLES ------

	self.quenumber = 0
	self.queinv = false

	------ AUDIO ------
	self.music1 = love.audio.newSource("audio/music/game.ogg")
	self.music2 = love.audio.newSource("audio/music/credits.ogg")
	self.music3 = love.audio.newSource("audio/music/game1.ogg")
	self.music4 = love.audio.newSource("audio/music/game2.ogg")
	self.intromusic = love.audio.newSource("audio/music/gameintro.ogg")
	self.entersound = love.audio.newSource("audio/buttons/enter.ogg")
	self.pickupsound = love.audio.newSource("audio/weapons/pickup.ogg")
	self.wavestart = love.audio.newSource("audio/wave/start.ogg")
	self.waveend = love.audio.newSource("audio/wave/end.ogg")
	self.invidle = love.audio.newSource("audio/weapons/invidle.ogg")
	self.invhit = love.audio.newSource("audio/weapons/invhit.ogg")
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
        	if other == arcade.wallT or other == arcade.wallB or other == arcade.wallL or other == arcade.wallR then
        		plyr.yvel = 0
        		plyr.xvel = 0
        		shape_a:move(mtv_x, mtv_y)
        		plyr.y = plyr.y + mtv_y
        		plyr.x = plyr.x + mtv_x
      		end

      		-- If player hits tree
      		if other == arcade.tree1 or other == arcade.tree2 or other == arcade.tree3 or other == arcade.tree4 then
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
       		if other == arcade.wallT or other == arcade.wallB or other == arcade.wallL or other == arcade.wallR then
       			plyr.yvel = 0
        		plyr.xvel = 0
       			shape_b:move(-mtv_x, -mtv_y)
       			plyr.y = plyr.y + -mtv_y
        		plyr.x = plyr.x + -mtv_x
    		end

    		-- If player hits tree
    		if other == arcade.tree1 or other == arcade.tree2 or other == arcade.tree3 or other == arcade.tree4 then
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

  	if setarcade == false then

   		-- if player hits zombie
   		for i, o in ipairs(zombie.zombs) do
    		if other == o.bb then
    		
    			-- if player hits zombie and doesnt have inv
    			if arcade.invhave == false then
    				plyr.health = plyr.health - 0.4
    				plyr.hurt = true
    				love.audio.play(plyr.hurtaudio)

    				if gameover == false then
    					arcade.totalscore = arcade.totalscore - 0.4
    				end
    			end

    			-- if player hits zombie and has inv
    			if arcade.invhave == true then
					o.health = o.health - 10
					love.audio.play(game.invhit)
					Collider:remove(o.bb)

					-- kill zombies
					if o.health < 0 then
						o.health = 0
						arcade.score = arcade.score + 10
						arcade.kills = arcade.kills + 1
						zombie.count = zombie.count - 1
						arcade.smgspawnscore = arcade.smgspawnscore + 10
						arcade.minispawnscore = arcade.minispawnscore + 10
						arcade.invspawnscore = arcade.invspawnscore + 10
						arcade.killallspawnscore = arcade.killallspawnscore + 10
						arcade.oneupspawnscore = 	arcade.oneupspawnscore + 10
						arcade.totalscore = arcade.totalscore + 10
						Collider:remove(o.bb)
						table.remove(zombie.zombs, i)
					end
				end
    		end
    	end
    
    	-- if player hits smg
    	for i, o in ipairs(smg.smgs) do
    		if other == o.bb then
    			arcade.smghad = true
    			arcade.smghave = true
    			arcade.minihave = false
    			arcade.killallhave = false
    			Collider:remove(o.bb)
    			love.audio.play(game.pickupsound)
    			arcade.totalscore = arcade.totalscore - 10
    		end
    	end

    	-- if player hits minigun
    	for i, o in ipairs(minigun.miniguns) do
    		if other == o.bb then
    			arcade.minihad = true
    			arcade.minihave = true
    			arcade.smghave = false
    			arcade.killallhave = false
    			Collider:remove(o.bb)
    			love.audio.play(game.pickupsound)
    			arcade.totalscore = arcade.totalscore - 10
    		end
    	end

    	-- if player hits inv
    	for i, o in ipairs(inv.invs) do
    		if other == o.bb then
    			arcade.invhad = true
    			arcade.invhave = true
    			Collider:remove(o.bb)
    			love.audio.play(game.pickupsound)
    			arcade.totalscore = arcade.totalscore - 10
    		end
    	end

    	-- if player hits killall
    	for i, o in ipairs(killall.killalls) do
    		if other == o.bb then
    			arcade.killallhad = true
    			arcade.killallhave = true
    			Collider:remove(o.bb)
    			love.audio.play(game.pickupsound)
    			arcade.totalscore = arcade.totalscore - 10
    		end
    	end

    	-- if player hits shoe
    	for i, o in ipairs(shoe.shoes) do
    		if other == o.bb then
    			arcade.shoehad = true
    			arcade.shoehave = true

    			-- increase player speed
    			if plyr.speed < 50 then
					plyr.speed = plyr.speed + 2	
				end
    		
    			Collider:remove(o.bb)
    			love.audio.play(game.pickupsound)
    			arcade.totalscore = arcade.totalscore - 10
    		end
    	end

    	-- if player hits heart
    	for i, o in ipairs(heart.hearts) do
    		if other == o.bb then
    			arcade.hearthad = true
    			arcade.hearthave = true

    			-- increase the player health
    			if plyr.health < 160 then
					player.maxhealth = player.maxhealth	+ 10
				end

    			Collider:remove(o.bb)
    			love.audio.play(game.pickupsound)
    			arcade.totalscore = arcade.totalscore - 10
    		end
    	end

    	-- if player hits oneup
    	for i, o in ipairs(oneup.oneups) do
    		if other == o.bb then
    			arcade.oneuphad = true
    			arcade.oneuphave = true

    			-- increase the player lives
    			if player.lives < 3 then
					player.lives = player.lives + 1
				end

    			Collider:remove(o.bb)
    			love.audio.play(game.pickupsound)
    			arcade.totalscore = arcade.totalscore - 10
    		end
    	end

    	-- if player hits questionmark
    	for i, o in ipairs(questionmark.questionmarks) do
    		if other == o.bb then
    			arcade.questionmarkhad = true
    			arcade.questionmarkhave = true
    			arcade.minihave = false
    			arcade.smghave = false
				game.quenumber = love.math.random(1, 15)

				-- differnt question mark options
				if game.quenumber == 1 then
					arcade.totalscore = arcade.totalscore - 1000
					love.audio.play(menu.backsound)
				elseif game.quenumber == 2 then
					arcade.totalscore = arcade.totalscore + 1000
					love.audio.play(game.pickupsound)
				elseif game.quenumber == 3 then
					arcade.totalscore = arcade.totalscore - 200
					love.audio.play(menu.backsound)
				elseif game.quenumber == 4 then
					arcade.totalscore = arcade.totalscore + 200
					love.audio.play(game.pickupsound)
				elseif game.quenumber == 5 then
					arcade.totalscore = arcade.totalscore - 100
					love.audio.play(menu.backsound)
				elseif game.quenumber == 6 then
					arcade.totalscore = arcade.totalscore - 100
					love.audio.play(menu.backsound)
				elseif game.quenumber == 7 then
					love.audio.play(game.pickupsound)
					arcade.quesmghave = true
				elseif game.quenumber == 8 then
					love.audio.play(game.pickupsound)
					arcade.quesmghave = true
				elseif game.quenumber == 9 then
					love.audio.play(game.pickupsound)
					arcade.queminihave = true
				elseif game.quenumber == 10 then
					love.audio.play(game.pickupsound)
					arcade.queminihave = true
				elseif game.quenumber == 11 then
					love.audio.play(game.pickupsound)
					arcade.totalscore = arcade.totalscore + 100
				elseif game.quenumber == 12 then
					love.audio.play(game.pickupsound)
    				arcade.totalscore = arcade.totalscore + 100
				elseif game.quenumber == 13 then
					if player.lives < 3 then
						player.lives = player.lives + 1
						arcade.oneupflashtimer = 0
						love.audio.play(game.pickupsound)
					elseif player.lives > 2 then
						love.audio.play(game.pickupsound)
						arcade.totalscore = arcade.totalscore + 1000
					end
				elseif game.quenumber == 14 then
					love.audio.play(menu.backsound)
				elseif game.quenumber == 15 then
					love.audio.play(game.pickupsound)
					arcade.totalscore = arcade.totalscore + 5000
				end 
			
    			Collider:remove(o.bb)
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

	-- ARCADE --
	if setarcade == false then
		for i, o in ipairs(zombie.zombs) do

			local other

			-- Set soild objects for zombies
			if shape_a == o.bb then
				
				-- set to shape	
				other = shape_b

				-- if zombie hits tress
      			if other == arcade.tree1 or other == arcade.tree2 or other == arcade.tree3 or other == arcade.tree4 then
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
				if other == arcade.tree1 or other == arcade.tree2 or other == arcade.tree3 or other == arcade.tree4 then
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

	if setarcade == false then
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
					o.damageaudio:setVolume(sfxvolume)

					if arcade.wave < 10 or arcade.minihave == true or arcade.smghave == true or arcade.queminihave == true or arcade.quesmghave == true then 
						Collider:remove(v.bb)
						table.remove(pistol.bullets, c)
					end
				
					-- kill zombies
					if o.health < 0 then
						o.health = 0
						
						-- scores
						arcade.score = arcade.score + 10
						arcade.kills = arcade.kills + 1
						zombie.count = zombie.count - 1     
						arcade.smgspawnscore = arcade.smgspawnscore + 10
						arcade.minispawnscore = arcade.minispawnscore + 10
						arcade.invspawnscore = arcade.invspawnscore + 10
						arcade.killallspawnscore = arcade.killallspawnscore + 10
						arcade.oneupspawnscore = 	arcade.oneupspawnscore + 10
						arcade.totalscore = arcade.totalscore + 10
						
						-- count the bullets for shot gun double kills
						if arcade.wave > 9 and arcade.smghave == false or arcade.wave > 9 and arcade.minihave == false or arcade.wave > 9 and arcade.quesmghave == false or arcade.wave > 9 and arcade.queminihave == false then
							v.dead = v.dead + 1
						end

						-- allow 2 kill per bullet for shotgun
						if v.dead == 2 and arcade.wave > 9 and arcade.smghave == false or v.dead == 2 and arcade.wave > 9 and arcade.minihave == false or v.dead == 2 and arcade.wave > 9 and arcade.quesmghave == false or v.dead == 2 and arcade.wave > 9 and arcade.queminihave == false then
							Collider:remove(v.bb)
							table.remove(pistol.bullets, c)
						end
						
						-- remove zombie
						Collider:remove(o.bb)
						table.remove(zombie.zombs, i)
					end
				end
			end
		end
	end
	-- ARCADE --

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
					o.damageaudio:setVolume(sfxvolume)
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

	-- dissmiss the welcome message for arcade mode
  	if key == "return" and welcomescreen == true and self.arcade == true or key == "space" and welcomescreen == true and self.arcade == true then
  		welcomescreen = false
  		setarcade = false
  		love.audio.play(self.entersound)
		love.audio.stop(self.intromusic)
		love.audio.play(self.music1)
		self.music1:setVolume(musicvolume)
		self.music1:setLooping(true)
  	end

  	-- dissmiss the welcome message for stuck mode
  	if key == "return" and welcomescreen == true and self.stuck == true or key == "space" and welcomescreen == true and self.stuck == true then
		welcomescreen = false
  		gamereset = false
  		love.audio.play(self.entersound)
		love.audio.stop(self.intromusic)
		love.audio.play(self.music4)
		self.music4:setVolume(musicvolume)
		self.music4:setLooping(true)
  	end

  	-- Pause the game
  	if key == "escape" and paused == false and welcomescreen == false and gameover == false then
   		paused = true
   		resume = false
   		love.mouse.setCursor(cursor)
  	end
end

function game:mousepressed(mx, my, button)

	-- dissmiss the welcome message for arcade mode
  	if button == 1 and welcomescreen == true and self.arcade == true then
  		welcomescreen = false
  		setarcade = false
  		love.audio.play(self.entersound)
		love.audio.stop(self.intromusic)
		love.audio.play(self.music1)
		self.music1:setVolume(musicvolume)
		self.music1:setLooping(true)
  	end

  	-- dissmiss the welcome message for stuck mode
  	if button == 1 and welcomescreen == true and self.stuck == true then
		welcomescreen = false
  		gamereset = false
  		love.audio.play(self.entersound)
		love.audio.stop(self.intromusic)
		love.audio.play(self.music4)
		self.music4:setVolume(musicvolume)
		self.music4:setLooping(true)
  	end
end

function game:update(dt)


		-- set volume
	self.music1:setVolume(musicvolume)
	self.music2:setVolume(musicvolume)
	self.music3:setVolume(musicvolume)
	self.music4:setVolume(musicvolume)
	self.intromusic:setVolume(musicvolume)
	plyr.hurtaudio:setVolume(sfxvolume)
	plyr.deathaudio:setVolume(sfxvolume)
	plyr.deathaudio1:setVolume(sfxvolume)
	self.entersound:setVolume(sfxvolume)
	self.pickupsound:setVolume(sfxvolume)
	self.wavestart:setVolume(sfxvolume)
	self.waveend:setVolume(sfxvolume)
	self.invidle:setVolume(sfxvolume)
	self.invhit:setVolume(sfxvolume)



	-- CAMERA --
	-- set up camera
	dx,dy = (plyr.x) - self.Cam.x, (plyr.y) - self.Cam.y
	mx1,my1 = self.Cam:mousepos()
	self.Cam:move(dx/2, dy/2)

	-- Zoom camera in when gameover but make sure it stays default when not
    if gameover == true then
		if resselections == 1 then
			self.Cam:zoomTo(5)
		end

		if resselections == 2 then
			self.Cam:zoomTo(6.4)
		end

		if resselections == 3 then
			self.Cam:zoomTo(6.8)
		end
	elseif gameover == false then
		if resselections == 1 then
			self.Cam:zoomTo(3.2)
		end

		if resselections == 2 then
			self.Cam:zoomTo(4.6)
		end

		if resselections == 3 then
			self.Cam:zoomTo(5)
		end
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
		love.audio.pause(game.invidle)
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
		if paused == false and welcomescreen == false and game.arcade == true or game.stuck == true and gameover == false then  
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
	-- draw the welcome text and background for arcade mode
	 if welcomescreen == true and self.arcade == true then
    	love.mouse.setCursor(cursor)
    	love.graphics.draw(start.bg, 0, -1000, 0, 3)
    	love.graphics.setColor(160, 47, 0)
    	love.graphics.setFont( start.font2 )
		love.graphics.print("WELCOME! THANK YOU FOR TAKING THE TIME", (love.graphics.getWidth()/2 - start.font2:getWidth( "WELCOME! THANK YOU FOR TAKING THE TIME" )/2) - 10, (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) - 275)
		love.graphics.print("TO TEST PIQUANT INTERACTIVE'S PROJECT,", (love.graphics.getWidth()/2 - start.font2:getWidth( "TO TEST PIQUANT INTERACTIVE'S PROJECT," )/2) - 14, (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) - 235)
		love.graphics.print("ZOMBIE GAME. THIS GAME MODE HAS YOU", (love.graphics.getWidth()/2 - start.font2:getWidth( "ZOMBIE GAME. THIS GAME MODE HAS YOU" )/2) - 54, (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) - 195)
		love.graphics.print("BATTLING ZOMBIES IN AN ENDLESS, WAVE", (love.graphics.getWidth()/2 - start.font2:getWidth( "BATTLING ZOMBIES IN AN ENDLESS, WAVE" )/2) - 39, (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) - 155)
		love.graphics.print("BASED SURVIVAL SHOOTER WITH NAUGHT BUT", (love.graphics.getWidth()/2 - start.font2:getWidth( "BASED SURVIVAL SHOOTER WITH NAUGHT BUT" )/2) - 10, (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) - 115)
		love.graphics.print("YOUR WIT AND YOUR PISTOL. DON'T DIE!", (love.graphics.getWidth()/2 - start.font2:getWidth( "YOUR WIT AND YOUR PISTOL. DON'T DIE!" )/2) - 44, (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) - 75)
		
		love.graphics.setFont( start.font1 )
		love.graphics.print("CONTORLS:", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 15)
		love.graphics.print("SHOOT: LEFT-CLICK", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 40)
		love.graphics.print("AIMASSIST: RIGHT-CLICK", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 65)
		love.graphics.print("MOVEMENT: WASD", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 90)
		love.graphics.print("PAUSE: ESC", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 115)
		love.graphics.print("LEAVE ANY FEEDBACK YOU", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 200)
		love.graphics.print("MAY HAVE AT", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 225)
		love.graphics.print("[REDDIT.COM/R/PIQUANT2013/]", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 250)
		love.graphics.print("AS WE LOVE PLAYER", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 275)
		love.graphics.print("INTERACTION.", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 300)
		
		love.graphics.setFont( start.font2 )
		love.graphics.print("PRESS START", (love.graphics.getWidth()/2 + 125), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 119)
		love.graphics.print("BUTTON", (love.graphics.getWidth()/2 + 125) + start.font2:getWidth( "PRESS START" )/2 - start.font2:getWidth( "BUTTON" )/2, (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 159)
		love.graphics.setColor(255, 255, 255, self.buttonflash)
		love.graphics.print("PRESS START", (love.graphics.getWidth()/2 + 125), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 119)
		love.graphics.print("BUTTON", (love.graphics.getWidth()/2 + 125) + start.font2:getWidth( "PRESS START" )/2 - start.font2:getWidth( "BUTTON" )/2, (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 159)
		love.graphics.setColor(255, 255, 255)
	end

	-- draw the welcome text and bacground for stuck mode
	 if welcomescreen == true and self.stuck == true then
    	love.mouse.setCursor(cursor)
    	love.graphics.draw(start.bg, 0, -1000, 0, 3)
    	love.graphics.setColor(160, 47, 0)
    	love.graphics.setFont( start.font2 )
		love.graphics.print("THANK YOU FOR TAKING THE TIME TO TEST", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) - 275)
		love.graphics.print("PIQUANT INTERACTIVE'S PROJECT, ZOMBIE", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) - 235)
		love.graphics.print("GAME. THIS MODE DOESNT ALLOW PLAYER", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) - 195)
		love.graphics.print("MOVEMENT; HENCE THE NAME. YOU WILL", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) - 155)
		love.graphics.print("REQUIRE 3 THINGS: FAST REFLEXES, QUICK", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) - 115)
		love.graphics.print("TIGGER FINGER, AND THE WILL TO SURVIVE.", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) - 75)
		
		love.graphics.setFont( start.font1 )
		love.graphics.print("CONTORLS:", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 15)
		love.graphics.print("SHOOT: LEFT-CLICK", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 40)
		love.graphics.print("AIMASSIST: RIGHT-CLICK", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 65)
		love.graphics.print("MOVEMENT: WASD", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 90)
		love.graphics.print("PAUSE: ESC", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 115)
		love.graphics.print("LEAVE ANY FEEDBACK YOU", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 200)
		love.graphics.print("MAY HAVE AT", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 225)
		love.graphics.print("[REDDIT.COM/R/PIQUANT2013/]", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 250)
		love.graphics.print("AS WE LOVE PLAYER", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 275)
		love.graphics.print("INTERACTION.", (love.graphics.getWidth()/2 - 580), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 300)
		
		love.graphics.setFont( start.font2 )
		love.graphics.print("PRESS START", (love.graphics.getWidth()/2 + 125), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 119)
		love.graphics.print("BUTTON", (love.graphics.getWidth()/2 + 125) + start.font2:getWidth( "PRESS START" )/2 - start.font2:getWidth( "BUTTON" )/2, (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 159)
		love.graphics.setColor(255, 255, 255, self.buttonflash)
		love.graphics.print("PRESS START", (love.graphics.getWidth()/2 + 125), (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 119)
		love.graphics.print("BUTTON", (love.graphics.getWidth()/2 + 125) + start.font2:getWidth( "PRESS START" )/2 - start.font2:getWidth( "BUTTON" )/2, (love.graphics.getHeight()/2 - start.font2:getHeight( "WELCOME" )/2) + 159)
		love.graphics.setColor(255, 255, 255)
	end
	------ TEXT ------
end

return game