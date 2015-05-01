-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads Hardon Collider script
local HC = require 'libs/hardoncollider'

-- Creates game as a new gamestate
ship = Gamestate.new()


function ship:initialize()

	-- Ship table and its varibles
	self.sship = {}

	-- So dont have to keep writing ship at the start of every ship var
	sship = self.sship

	-- The contents of the ship table
	sship.x = 456
	sship.y = 490
	sship.w = 78
	sship.h = 48
	sship.health = 200
	--sship.colliding = false
	sship.entered = false
	sship.yes = false
	sship.owned = false
	sship.exited = false
	sship.dead = false
	sship.sprite = love.graphics.newImage("images/ship1.png")
	sship.bb = Collider:addRectangle(sship.x, sship.y, sship.w, sship.h)
	
	-- Boost varibles
	self.BoostTired = false
	self.BoostTiredTime = 0 
	self.Boost = false
	self.BoostTime = 0

	-- Ship sounds
	self.BoostSound = love.audio.newSource("audio/boost.ogg")
	self.ThrustSound = love.audio.newSource("audio/thrust.ogg")
	self.IdleSound = love.audio.newSource("audio/idle.ogg")

	-- Interact font
	self.InteractFont = love.graphics.newFont("fonts/xen3.ttf", 10)
end

function ship:collision(dt, shape_a, shape_b)

	-- Set ship hitbox to a shape
	local other
    
    if shape_a == sship.bb then
        other = shape_b
    elseif shape_b == sship.bb then
        other = shape_a
    else
        return
    end

    -- what the ship is colliding with and what to do
    for i, o in ipairs(gun.Bullets) do
    	
    	-- Bullet
    	if other == o.bb then
    		sship.health = sship.health - 10
    		table.remove(gun.Bullets, i)
    	end
    end

    for i, o in ipairs(rocks) do
    	
    	-- Rock
    	if other == o.bb then
    		sship.health = sship.health - 20
    		table.remove(rocks, i)
    	end
    end
end

function ship:collisionstopped(dt, shape_a, shape_b)
end

function ship:health()

	-- If ship health is less then 0 keep it at 0
	if sship.health < 0 then
		sship.health = 0
	end

	-- if ship health is 0 then ship dies
	if sship.health == 0 then
		sship.dead = true
	end
end

function ship:movement(dt)
	
	if sship.entered == true and Paused == false then
		
		-- If your in the ship set the cursor to the pointer
		love.mouse.setCursor(cursor)
	elseif sship.entered == false and pistol.HaveGun == true and Paused == false then
		
		-- If your not in the ship and have the gun then set the cursor to crosshair
		love.mouse.setCursor(crosshair)
	end

	if sship.dead == true then
		
		-- Set the postion for when the ship dies to its current postion and lock it
		sship.x = sship.x + math.cos(self.ShipDir) * 10 * dt
		sship.y = sship.y + math.sin(self.ShipDir) * 10 * dt
	end

	-- If your in ship and its dead stop all the audio and set player and gun to the ship
	if sship.entered == true and sship.dead == true and Paused == false then
		sship.exited = true
		plyr.x = sship.x
    	plyr.y = sship.y
    	pistol.GunX = sship.x
    	pistol.GunY = sship.y
    	love.audio.stop(self.IdleSound)
    	love.audio.stop(self.ThrustSound)
		love.audio.stop(self.BoostSound)
    end

    -- If your in ship play idle audio and set player and gun to the ship
	if sship.entered == true and sship.health > 0 and Paused == false then
		plyr.x = sship.x
    	plyr.y = sship.y
    	pistol.GunX = sship.x
    	pistol.GunY = sship.y
    	sship.exited = true
    	love.audio.play(self.IdleSound)
    end

    -- If your not in the ship stop audio
    if sship.entered == false then
    	love.audio.stop(self.IdleSound)
    end

    -- Move ship direction with the mouse
	if sship.health > 0 then
		self.ShipDir = math.atan2(my1 - plyr.y, mx1 - plyr.x)
	end

	if love.keyboard.isDown("w") and sship.entered == true and sship.health > 0 and Paused == false then
		
		-- Move ship
		sship.x = sship.x + math.cos(self.ShipDir) * plyr.speed * dt
		sship.y = sship.y + math.sin(self.ShipDir) * plyr.speed * dt
		
		-- Set ship speed
		plyr.speed = 350
		
		-- Play thrust sound
		love.audio.play(self.ThrustSound)
	end

	if not love.keyboard.isDown("w") and sship.entered == true and sship.health > 0 then
		
		-- Stop audio if your not moving
		love.audio.stop(self.ThrustSound)
		love.audio.stop(self.BoostSound)
	end

	if love.keyboard.isDown("s") and sship.entered == true and not love.keyboard.isDown("w") and sship.health > 0 then
		
		-- Move ship
		sship.x = sship.x - math.cos(self.ShipDir) * plyr.speed * dt
		sship.y = sship.y - math.sin(self.ShipDir) * plyr.speed * dt
		
		-- set ship speed to slower in reverse
		plyr.speed = 100
		
		-- stop trust sound in reverse
		love.audio.stop(self.ThrustSound)
	end
end
	
function ship:boost(dt)

	-- Start boost timer
    self.BoostTime = self.BoostTime + dt

    -- If holding shift and in ship then ship boosts
    if love.keyboard.isDown("lshift") and sship.entered == true and not love.keyboard.isDown("s") and love.keyboard.isDown("w") and Paused == false and sship.health > 0 then
		
    	-- Set ship speed
		plyr.speed = 600
		
		-- Boost is enabled
		self.Boost = true
		
		-- play boost sound effect
		love.audio.play(self.BoostSound)
    end

     -- If not holding down shift and in ship then dont boost
    if not love.keyboard.isDown("lshift") and sship.entered == true and not love.keyboard.isDown("s") and love.keyboard.isDown("w") and Paused == false and sship.health > 0 then
		
    	-- Sprint is enabled
		self.Boost = false
		
		-- stop boost sound effect
		love.audio.stop(self.BoostSound)
    end

    -- If you have been boosting for over 5 seconds then boosting false
    if self.Boost == true and self.BoostTime > 5 and sship.entered == true and sship.health > 0 then
    	self.BoostTired = true
    	plyr.speed = 350
    end

    -- Reset the boost timer if your not boosting
    if self.Boost == false and sship.entered == true and sship.health > 0 then
    	self.BoostTime = 0
    end

    -- If your tired and you stop boosting start the tried timer
    if self.BoostTired == true and self.Boost == false and sship.entered == true and sship.health > 0 then
    	plyr.speed = 350
    	self.BoostTiredTime = self.BoostTiredTime + dt
    	self.BoostTime = 0
    end

    -- If the tired timer goes over 1.7 seconds tired turns off and you can boost again
    if self.BoostTiredTime > 1.7 and sship.entered == true and sship.health > 0 then
    	self.BoostTired = false
    	self.BoostTiredTime = 0
    end

     -- Resets timers and set ship back to default speed
    if self.BoostTired == true and self.Boost == true and sship.entered == true and sship.health > 0 then
    	plyr.speed = 350
    	self.BoostTime = 0
    	self.BoostTiredTime = 0
    	love.audio.stop(self.BoostSound)
    end
end

function ship:update(dt)
	
	-- Update ship
	ship:movement(dt)
	ship:boost(dt)
end

function ship:draw()

	sship.sprite:setFilter( 'nearest', 'nearest' )
	self.InteractFont:setFilter( 'nearest', 'nearest' )

	--- PLAYER, SHIP AND GUN ---
	if sship.entered == true then
		
		-- Ships graphic for when the player is in the ship
		love.graphics.draw(sship.sprite, sship.x, sship.y, self.ShipDir, 1, 1, sship.sprite:getWidth()/2, sship.sprite:getHeight()/2)
		
		-- Moves the ship hit box with the ship graphic
		sship.bb:moveTo(sship.x, sship.y)
		
		sship.bb:setRotation(self.ShipDir)
	
	elseif sship.entered == false then 
		
		-- Ships graphic for when the player is out of the ship
		love.graphics.draw(sship.sprite, sship.x, sship.y, sship.bb:rotation(), 1, 1, sship.sprite:getWidth()/2, sship.sprite:getHeight()/2)

		-- Leaves the ship hit box with the ship graphic
		sship.bb:moveTo(sship.x, sship.y)
		sship.bb:moveTo(sship.x, sship.y)
	end

	if sship.yes == true and sship.entered == false then 
		
		-- Prints interact key for if you can get in the ship
		love.graphics.setFont( self.InteractFont )
		love.graphics.print('[ e ]', sship.x + 30, sship.y + 30)
	end
end

return ship