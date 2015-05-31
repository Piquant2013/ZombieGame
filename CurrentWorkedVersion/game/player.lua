-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates game as a new gamestate
player = Gamestate.new()


function player:initialize()

	------ VARIABLES ------
	-- Player damage and health
	self.hurttimer = 0
	self.flashred = false
	player.autoheal = false

	-- Players weapon position
	self.weapony = 0
	self.weaponx = 0

	-- Player table
	self.plyr = {}
	plyr = self.plyr

	-- The contents of the player table
	plyr.y = 0
	plyr.x = 0
	plyr.h = 16
	plyr.w = 12
	plyr.health = 0
	plyr.speed = 0
	plyr.colliding = false
	plyr.hurt = false
	plyr.bb = Collider:addRectangle(plyr.x, plyr.y, plyr.w, plyr.h)
	plyr.sprite = love.graphics.newImage("images/player/player.png")
	plyr.arm = love.graphics.newImage("images/player/arm.png")
	plyr.hurtaudio = love.audio.newSource("audio/player/hurt.ogg")
	plyr.deathaudio = love.audio.newSource("audio/player/death.ogg")





	plyr.speed1 = 28
	plyr.xvel = 0
	plyr.yvel = 0
	plyr.friction = 20
	------ VARIABLES ------
end

function player:collision(dt, shape_a, shape_b, mtv_x, mtv_y)

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
    	plyr.bb:move(mtv_x, mtv_y)
   		plyr.y = plyr.y + 5 + mtv_y
   		plyr.speed = 0
   	elseif other == endless.wallB then
    	plyr.bb:move(mtv_x, mtv_y)
   		plyr.y = plyr.y - 5 + mtv_y
   		plyr.speed = 0
   	elseif other == endless.wallL then
   		plyr.bb:move(mtv_x, mtv_y)
   		plyr.x = plyr.x + 5 + mtv_x
   		plyr.speed = 0
   	elseif other == endless.wallR then
   		plyr.bb:move(mtv_x, mtv_y)
   		plyr.x = plyr.x - 5 + mtv_x
   		plyr.speed = 0
   	end
end

function player:health(dt)

	-- Player death
	if plyr.health <= 0 then
		plyr.health = 0
		gameover = true
	end

	-- AUTO HEAL --
	if player.autoheal == true then

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
  	end
  	-- AUTO HEAL --
end

function player:movement(dt)


	
	plyr.x = plyr.x + plyr.xvel
	plyr.y = plyr.y + plyr.yvel

	plyr.xvel = plyr.xvel * (1 - math.min(dt * plyr.friction, 1))
	plyr.yvel = plyr.yvel * (1 - math.min(dt * plyr.friction, 1))

	if love.keyboard.isDown("a") and plyr.xvel > -100 and gameover == false then
		plyr.xvel = plyr.xvel - plyr.speed1 * dt
	end
    
    if love.keyboard.isDown("d") and plyr.xvel < 100 and gameover == false then
		plyr.xvel = plyr.xvel + plyr.speed1 * dt
    end

    if love.keyboard.isDown("w") and plyr.yvel > -100 and gameover == false then
		plyr.yvel = plyr.yvel - plyr.speed1 * dt
	end
    
    if love.keyboard.isDown("s") and plyr.yvel < 100 and gameover == false then
		plyr.yvel = plyr.yvel + plyr.speed1 * dt
    end
	





	--[[
	-- Player movement
	if love.keyboard.isDown("a") and gameover == false then
		plyr.x = plyr.x - plyr.speed * dt
	end
    
    if love.keyboard.isDown("d") and gameover == false then
		plyr.x = plyr.x + plyr.speed * dt
    end

    if love.keyboard.isDown("w") and gameover == false then
		plyr.y = plyr.y - plyr.speed * dt
    end

    if love.keyboard.isDown("s") and gameover == false then
		plyr.y = plyr.y + plyr.speed * dt
    end
	]]--

    -- Player rotation
	plyr.rotation = math.atan2(mx1 - plyr.x, plyr.y - my1) - math.pi / 2
end

function player:update(dt)
	
	-- Set player weapon postion
	if game.endless == true then
		self.weapony = pis.y
		self.weaponx = pis.x
	end

	if game.stuck == true then
		self.weapony = crp.y
		self.weaponx = crp.x
	end

	-- update player and add plyr.bb to players group
	Collider:addToGroup("players", plyr.bb)
	player:movement(dt)
end

function player:draw()
	
	------ FILTERS ------
	plyr.sprite:setFilter( 'nearest', 'nearest' )
	plyr.arm:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	------ IMAGES ------
	if gameover == false then
		
		-- Move the arm towards the crosshair if the crosshair is atleast 20 pixels away from the player
		if (mx1 > (plyr.x + 20) or (mx1 < (plyr.x - 20 ))) or (my1 > (plyr.y + 20 ) or (my1 < (plyr.y - 20 ))) then
			amx = mx1 - 6 * math.sin(math.atan2(my1 - self.weapony, mx1 - self.weaponx))
			amy = my1 + 6 * math.cos(math.atan2(my1 - self.weapony, mx1 - self.weaponx))
			self.armrot = math.atan2(amy - self.weapony, amx - self.weaponx)
			love.graphics.draw(plyr.arm, plyr.x, plyr.y, self.armrot, 1, 1, plyr.sprite:getWidth() - 32, plyr.sprite:getHeight() - 24)
		
		-- Rotate the arm with normal player rotate when the crosshair is within 20 pixels of the player
		elseif (mx1 > (plyr.x - 20) or (mx1 < (plyr.x + 20 ))) or (my1 > (plyr.y - 20 ) or (my1 < (plyr.y + 20 ))) then
			love.graphics.draw(plyr.arm, plyr.x, plyr.y, plyr.rotation, 1, 1, plyr.sprite:getWidth() - 32, plyr.sprite:getHeight() - 24)
		end
		
		-- Draw the player, move the plyr.bb with player, set plyr.bb rotation and set the rotation for death
		love.graphics.draw(plyr.sprite, plyr.x, plyr.y, plyr.rotation, 1, 1, plyr.sprite:getWidth()/2, plyr.sprite:getHeight()/2)
		plyr.bb:moveTo(plyr.x, plyr.y)
		plyr.bb:setRotation(plyr.rotation)
		plyr.deadrotation = math.atan2(mx1 - plyr.x, plyr.y - my1) - math.pi / 2

	elseif gameover == true then
		
		-- lock the players draw position when death
		love.graphics.draw(plyr.sprite, plyr.x, plyr.y, plyr.deadrotation, 1, 1, plyr.sprite:getWidth()/2, plyr.sprite:getHeight()/2)
		love.graphics.draw(plyr.arm, plyr.x, plyr.y, plyr.deadrotation, 1, 1, plyr.sprite:getWidth() - 32, plyr.sprite:getHeight() - 24)
	end
	------ IMAGES ------
end

return player