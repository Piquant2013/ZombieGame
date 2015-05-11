-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads Hardon Collider script
local HC = require 'libs/hardoncollider'

-- Loads player script
gun = require 'game/gun'

-- Loads player script
ship = require 'game/ship'

-- Creates game as a new gamestate
player = Gamestate.new()


function player:initialize()

	-- Player table and its varibles
	self.plyr = {}

	-- So dont have to keep writing player at the start of every player var
	plyr = self.plyr

	-- The contents of the player table
	plyr.y = 400
	plyr.x = 800
	plyr.w = 12
	plyr.h = 16
	plyr.health = 1000
	plyr.speed = 100
	plyr.movementstop = false
	plyr.sprite = love.graphics.newImage("images/man.png")
	plyr.arm = love.graphics.newImage("images/arm.png")
	plyr.bb = Collider:addRectangle(plyr.x, plyr.y, plyr.w, plyr.h)
	
	-- Sprint varibles
	self.Tired = false
	self.TiredTime = 0 
	self.Sprint = false
	self.SprintTime = 0
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

    plyr.bb:move(mtv_x, mtv_y)
    plyr.x, plyr.y = plyr.x - mtv_x, plyr.y - mtv_y
    plyr.speed = 0

    -- what the player is colliding with
    if other == sship.bb then
    	
    	-- Ship
    	sship.yes = true
    end

    -- Rock
    for i, o in ipairs(rocks) do
    	if other == o.bb then
    		plyr.health = plyr.health - 1
    	end
    end
end

function player:collisionstopped(dt, shape_a, shape_b, mtv_x, mtv_y)
	
	-- turn to false when the collisions stop
	sship.yes = false
	plyr.speed = 100
end

function player:health(dt)

	-- If player health is less then 0 keep it at 0
	if plyr.health < 0 then
		plyr.health = 0
	end

	-- if player health is 0 then player dies and you get a gameover 
	if plyr.health == 0 then
		game.GameOver = true
	end
end

function player:movement(dt)

	if love.keyboard.isDown("a") and sship.entered == false and plyr.movementstop == false then
		
		-- Move the player left
		plyr.x = plyr.x - plyr.speed * dt

		-- If the player has the gun it follows the player
		pistol.GunX = pistol.GunX - plyr.speed * dt
		pistol.GunX = plyr.x
		pistol.GunY = plyr.y
    end

	if love.keyboard.isDown("d") and sship.entered == false and plyr.movementstop == false then
		
		-- Move the player right
		plyr.x = plyr.x + plyr.speed * dt

		-- If the player has the gun it follows the player
		pistol.GunX = pistol.GunX + plyr.speed * dt
		pistol.GunX = plyr.x
		pistol.GunY = plyr.y
    end

	if love.keyboard.isDown("w") and sship.entered == false and plyr.movementstop == false then
		
		-- Move the player up
		plyr.y = plyr.y - plyr.speed * dt

		-- If the player has the gun it follows the player
		pistol.GunY = pistol.GunY - plyr.speed * dt
		pistol.GunY = plyr.y
		pistol.GunX = plyr.x
    end

	if love.keyboard.isDown("s") and sship.entered == false and plyr.movementstop == false then
		
		-- Move the player down
		plyr.y = plyr.y + plyr.speed * dt

		-- If the player has the gun it follows the player
		pistol.GunY = pistol.GunY + plyr.speed * dt
		pistol.GunY = plyr.y
		pistol.GunX = plyr.x
    end

    -- Player rotation with the mouse pointer
	plyr.rotation = math.atan2(mx1 - plyr.x, plyr.y - my1) - math.pi / 2
end

function player:update(dt)
	
	-- update player
	Collider:addToGroup("players", plyr.bb)
	player:movement(dt)
end

function player:draw()
	
	------ FILTERS ------
	plyr.sprite:setFilter( 'nearest', 'nearest' )
	plyr.arm:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	if sship.entered == true then
	
		-- Moves the player and player hit box with the ship
		plyr.bb:moveTo(plyr.x, plyr.y)

		-- Rotates the player hit box with the mouse
		plyr.bb:setRotation(plyr.rotation)
	
	elseif sship.entered == false then

		if (mx1 > (plyr.x + 20) or (mx1 < (plyr.x - 20 ))) or (my1 > (plyr.y + 20 ) or (my1 < (plyr.y - 20 ))) then
			
			-- Set arm rotation
			ArmMX = mx1 - 6 * math.sin(math.atan2(my1 - pistol.GunY, mx1 - pistol.GunX))
			ArmMY = my1 + 6 * math.cos(math.atan2(my1 - pistol.GunY, mx1 - pistol.GunX))
			self.armrot = math.atan2(ArmMY - pistol.GunY, ArmMX - pistol.GunX)

			-- draw player arm
			love.graphics.draw(plyr.arm, plyr.x, plyr.y, self.armrot, 1, 1, plyr.sprite:getWidth() - 32, plyr.sprite:getHeight() - 24)
		
		elseif (mx1 > (plyr.x - 20) or (mx1 < (plyr.x + 20 ))) or (my1 > (plyr.y - 20 ) or (my1 < (plyr.y + 20 ))) then

			-- draw player arm
			love.graphics.draw(plyr.arm, plyr.x, plyr.y, plyr.rotation, 1, 1, plyr.sprite:getWidth() - 32, plyr.sprite:getHeight() - 24)

		end



		plyr.bb:draw('line')


		-- draw player
		love.graphics.draw(plyr.sprite, plyr.x, plyr.y, plyr.rotation, 1, 1, plyr.sprite:getWidth()/2, plyr.sprite:getHeight()/2)
		
		-- Moves the player hit box with the player graphic
		plyr.bb:moveTo(plyr.x, plyr.y)
		
		-- Rotates the player hit box with the player graphic
		plyr.bb:setRotation(plyr.rotation)
	end
end

return player