-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates oneup as a new gamestate
oneup = Gamestate.new()

function oneup:initialize()
	------ VARIABLES ------
	-- oneup spawn rate
	self.spawnrate = 0
	self.spawnrateplus = 0
	
	-- oneup vars
	self.count = 0
	
	-- oneups table
	self.oneups = {}
	------ VARIABLES ------
end

function oneup:spawn()	
	
	if self.spawnrate <= 0 then
		
		-- Sets the random spawn points for the oneup
		self.oneupzrx = love.math.random(230, 980)
		self.oneupzry = love.math.random(180, 530)

		if self.oneupzrx > 490 and self.oneupzrx < 709 and self.oneupzry > 244 and self.oneupzry < 459 then
			self.oneupzrx = love.math.random(709, 980)
			self.oneupzry = love.math.random(459, 530)
		end

		-- itemoneup table
		itemoneup = {} 
		
		-- The contents of the itemoneup table
		itemoneup.x = self.oneupzrx
		itemoneup.y = self.oneupzry
		itemoneup.bb = Collider:addRectangle(itemoneup.x, itemoneup.y, 20, 20)
		itemoneup.sprite = love.graphics.newImage("images/weapons/oneup.png")
		itemoneup.sprite2 = love.graphics.newImage("images/weapons/fadeoneup.png")
		
		-- Insert oneup
		table.insert(self.oneups, itemoneup)
		
		-- set the spawn rate and add one oneup to oneup count
		self.spawnrate = self.spawnrateplus
		self.count = self.count + 1
	end
end

function oneup:update(dt)
	
	-- refresh the spawn rate
	self.spawnrate = math.max(0, self.spawnrate - dt)
end

function oneup:draw()
	
	for i, o in ipairs(self.oneups) do
		
		------ FILTERS ------
		o.sprite:setFilter( 'nearest', 'nearest' )
		o.sprite2:setFilter( 'nearest', 'nearest' )
		------ FILTERS ------
		
		------ IMAGES ------
		if arcade.oneuphad == false then
			love.graphics.draw(o.sprite, o.x, o.y)
			love.graphics.setColor(255, 255, 255, arcade.gunsflash)
			love.graphics.draw(o.sprite2, o.x, o.y)
			love.graphics.setColor(255, 255, 255)
		end
		------ IMAGES ------
	end
end

return oneup