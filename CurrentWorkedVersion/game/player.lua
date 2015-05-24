-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates game as a new gamestate
player = Gamestate.new()


function player:initialize()

	------ VARIABLES ------
	-- Player damage
	self.hurttimer = 0
	self.flashred = false

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
	plyr.bb = Collider:addRectangle(plyr.x, plyr.y, plyr.w, plyr.h)
	plyr.sprite = love.graphics.newImage("images/player/player.png")
	plyr.arm = love.graphics.newImage("images/player/arm.png")
	plyr.hurt = false
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

function player:collisionstopped(dt, shape_a, shape_b, mtv_x, mtv_y)
end

function player:health(dt)

	-- Player death
	if plyr.health <= 0 then
		plyr.health = 0
		endless.gameover = true
	end
end

function player:movement(dt)

	-- Player movement
	if love.keyboard.isDown("a") and endless.gameover == false then
		plyr.x = plyr.x - plyr.speed * dt
	end
    
    if love.keyboard.isDown("d") and endless.gameover == false then
		plyr.x = plyr.x + plyr.speed * dt
    end

    if love.keyboard.isDown("w") and endless.gameover == false then
		plyr.y = plyr.y - plyr.speed * dt
    end

    if love.keyboard.isDown("s") and endless.gameover == false then
		plyr.y = plyr.y + plyr.speed * dt
    end

    -- Player rotation
	plyr.rotation = math.atan2(mx1 - plyr.x, plyr.y - my1) - math.pi / 2
end

function player:update(dt)
	
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
	if endless.gameover == false then
		
		-- Move the arm towards the crosshair if the crosshair is atleast 20 pixels away from the player
		if (mx1 > (plyr.x + 20) or (mx1 < (plyr.x - 20 ))) or (my1 > (plyr.y + 20 ) or (my1 < (plyr.y - 20 ))) then
			amx = mx1 - 6 * math.sin(math.atan2(my1 - pis.y, mx1 - pis.x))
			amy = my1 + 6 * math.cos(math.atan2(my1 - pis.y, mx1 - pis.x))
			self.armrot = math.atan2(amy - pis.y, amx - pis.x)
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

	elseif endless.gameover == true then
		
		-- lock the players draw position when death
		love.graphics.draw(plyr.sprite, plyr.x, plyr.y, plyr.deadrotation, 1, 1, plyr.sprite:getWidth()/2, plyr.sprite:getHeight()/2)
		love.graphics.draw(plyr.arm, plyr.x, plyr.y, plyr.deadrotation, 1, 1, plyr.sprite:getWidth() - 32, plyr.sprite:getHeight() - 24)
	end
	------ IMAGES ------
end

return player