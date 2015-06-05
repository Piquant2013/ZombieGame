-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates game as a new gamestate
zombie = Gamestate.new()


function zombie:initialize()

	------ VARIABLES ------
	-- zombie spawn rate
	self.spawnrate = 0
	self.spawnrateplus = 0
	
	-- zombie vars
	self.health = 0
	self.speed = 0
	self.count = 0

	-- zombs table
	self.zombs = {}
	------ VARIABLES ------
end

function zombie:spawn()

	if self.spawnrate <= 0 then
		
		-- Sets the random spawn points for the zombies in endless
		if game.endless == true then
			self.postion = love.math.random(1, 4)
			if self.postion == 1 then
				self.zrx = love.math.random(100, 1100)
				self.zry = love.math.random(1, 10)
			elseif self.postion == 2 then
				self.zrx = love.math.random(1, 10)
				self.zry = love.math.random(100, 600)
			elseif self.postion == 3 then
				self.zrx = love.math.random(1190, 1200)
				self.zry = love.math.random(100, 600)
			elseif self.postion == 4 then
				self.zrx = love.math.random(100, 1100)
				self.zry = love.math.random(690, 700)
			end
		end

		-- Sets the random spawn points for the zombies in stuck
		if game.stuck == true then
			self.postion = love.math.random(1, 4)
			if self.postion == 1 then
				self.zrx = love.math.random(530, 540)
				self.zry = love.math.random(290, 640)
			elseif self.postion == 2 then
				self.zrx = love.math.random(530, 1060)
				self.zry = love.math.random(290, 300)
			elseif self.postion == 3 then
				self.zrx = love.math.random(530, 1060)
				self.zry = love.math.random(630, 640)
			elseif self.postion == 4 then
				self.zrx = love.math.random(1060, 1070)
				self.zry = love.math.random(290, 640)
			end
		end

		-- zombs table
		zomb = {} 

		-- The contents of the rock table
		zomb.x = self.zrx
		zomb.y = self.zry
		zomb.w = 16
		zomb.h = 16
		zomb.health = self.health
		zomb.speed = self.speed
		zomb.bb = Collider:addRectangle(zomb.x, zomb.y, zomb.w, zomb.h)
		zomb.sprite = love.graphics.newImage("images/zombies/zombie.png")
		zomb.damageaudio = love.audio.newSource("audio/zombie/damage.ogg")

		-- Insert Zombie
		table.insert(self.zombs, zomb)

		-- set the spawn rate and add one zombie to zombiecount var
		self.spawnrate = self.spawnrateplus
		self.count = self.count + 1
	end
end

function zombie:update(dt)

	-- push zombies away from each other when they touch -- TEMP --
	for i = 1, #self.zombs do
		for j = i + 1, #self.zombs do
			if (self.zombs[i].x > (self.zombs[j].x - 16) and (self.zombs[i].x < (self.zombs[j].x + 16))) and (self.zombs[i].y > (self.zombs[j].y - 16) and (self.zombs[i].y < (self.zombs[j].y + 16))) then
				self.pushrotation = math.atan2(self.zombs[i].x - self.zombs[j].x, self.zombs[j].y - self.zombs[i].y) + math.pi / 2
				self.zombs[j].x = self.zombs[j].x + math.cos(self.pushrotation) * 30 * dt
				self.zombs[j].y = self.zombs[j].y + math.sin(self.pushrotation) * 30 * dt
			end
		end
	end

	-- refresh the spawn rate
	self.spawnrate = math.max(0, self.spawnrate - dt)

	-- Makes zombies go towards player
	for i,v in ipairs(self.zombs) do	
    	self.rotation = math.atan2(v.x - plyr.x, plyr.y - v.y) + math.pi / 2
    	local dx = math.cos(self.rotation) * (dt * v.speed)
    	local dy = math.sin(self.rotation) * (dt * v.speed)
		v.x = v.x + dx
   		v.y = v.y + dy
	end
end

function zombie:draw()

	for i,v in ipairs(self.zombs) do
		
		------ FILTERS ------
		v.sprite:setFilter( 'nearest', 'nearest' )
		------ FILTERS ------

		------ IMAGES ------
		-- Set the rotation of the zombies, movement of zomb.bb, rotate zomb.bb and draw zombie
		self.drawrotation = math.atan2(v.x - plyr.x, plyr.y - v.y) + math.pi / 2
		v.bb:moveTo(v.x, v.y)
   		v.bb:setRotation(self.drawrotation)
		love.graphics.draw(v.sprite, v.x, v.y, self.drawrotation, 1, 1, v.sprite:getWidth()/2, v.sprite:getHeight()/2)
		------ IMAGES ------
	end
end

return zombie