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
	plyr.health = 100
	plyr.speed = 70
	plyr.movementstop = false
	plyr.sprite = love.graphics.newImage("images/man.png")
	plyr.bb = Collider:addRectangle(plyr.x, plyr.y, plyr.w, plyr.h)
	
	-- Sprint varibles
	self.Tired = false
	self.TiredTime = 0 
	self.Sprint = false
	self.SprintTime = 0
end

function player:collision(dt, shape_a, shape_b)

	-- Set player hitbox to a shape
	local other

    if shape_a == plyr.bb then
        other = shape_b
    elseif shape_b == plyr.bb then
        other = shape_a
    else
        return
    end

    -- what the player is colliding with
    if other == pistol.bb then
    	
    	-- Gun
    	pistol.yes = true
    elseif other == sship.bb then
    	
    	-- Ship
    	sship.yes = true
    end



    if other == wallT then
    	plyr.y = plyr.y + 0.3
    	plyr.speed = 0
    elseif other == wallB then
    	plyr.y = plyr.y - 0.3
    	plyr.speed = 0
    elseif other == wallL then
    	plyr.x = plyr.x + 0.3
    	plyr.speed = 0
    elseif other == wallR then
    	plyr.x = plyr.x - 0.3
    	plyr.speed = 0
    end



    -- Rock
    for i, o in ipairs(rocks) do
    	if other == o.bb then
    		plyr.health = plyr.health - 1
    	end
    end
end

function player:collisionstopped(dt, shape_a, shape_b)
	
	-- turn to false when the collisions stop
	sship.yes = false
	pistol.yes = false
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

function player:sprint(dt)

	-- Start sprint timer
	self.SprintTime = self.SprintTime + dt

	-- If holding shift then player sprints
	if love.keyboard.isDown("lshift") and sship.entered == false and plyr.movementstop == false then
		
		-- Set player speed
		plyr.speed = 130
		
		-- Sprint is enabled
		self.Sprint = true
	end

	-- If not holding down shift then dont sprint
	if not love.keyboard.isDown("lshift") and sship.entered == false and plyr.movementstop == false then
		
		-- Set player speed
		plyr.speed = 70
		
		-- Sprint is enabled
		self.Sprint = false
	end

	-- If you have been sprinting for over 5 seconds then sprinting false
	if self.Sprint == true and self.SprintTime > 5 and sship.entered == false then
		self.Tired = true
		plyr.speed = 70
	end

	-- Reset the sprint timer if your not sprinting
	if self.Sprint == false then
		self.SprintTime = 0
	end

	-- If your tired and you stop sprinting start the tried timer
	if self.Tired == true and self.Sprint == false and sship.entered == false then
		plyr.speed = 70
		self.TiredTime = self.TiredTime + dt
		self.SprintTime = 0
	end

	-- If the tired timer goes over 1.7 seconds tired turns off and you can sprint again
	if self.TiredTime > 1.7 then
		self.Tired = false
		self.TiredTime = 0
	end

	-- Resets timers and set player back to default speed
	if self.Tired == true and self.Sprint == true and sship.entered == false then
		plyr.speed = 70
		self.SprintTime = 0
		self.TiredTime = 0
	end
end

function player:update(dt)
	
	-- update player
	player:movement(dt)
	player:sprint(dt)
end

function player:draw()
	
	------ FILTERS ------
	plyr.sprite:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	if sship.entered == true then
	
		-- Moves the player and player hit box with the ship
		plyr.bb:moveTo(plyr.x, plyr.y)

		-- Rotates the player hit box with the mouse
		plyr.bb:setRotation(plyr.rotation)
	
	elseif sship.entered == false then 

		-- draw player
		love.graphics.draw(plyr.sprite, plyr.x, plyr.y, plyr.rotation, 1, 1, plyr.sprite:getWidth()/2, plyr.sprite:getHeight()/2)
		
		-- Moves the player hit box with the player graphic
		plyr.bb:moveTo(plyr.x, plyr.y)
		
		-- Rotates the player hit box with the player graphic
		plyr.bb:setRotation(plyr.rotation)
	end
end

return player