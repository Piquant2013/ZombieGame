-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates inv as a new gamestate
heart = Gamestate.new()

function heart:initialize()
	------ VARIABLES ------
	-- heart spawn rate
	self.spawnrate = 0
	self.spawnrateplus = 0
	
	-- heart vars
	self.count = 0
	
	-- hearts table
	self.hearts = {}
	------ VARIABLES ------
end

function heart:spawn()	
	
	if self.spawnrate <= 0 then
		
		-- Sets the random spawn points for the smg
		self.heartzrx = love.math.random(230, 980)
		self.heartzry = love.math.random(180, 530)

		if self.heartzrx > 490 and self.heartzrx < 709 and self.heartzry > 244 and self.heartzry < 459 then
			self.heartzrx = love.math.random(709, 980)
			self.heartzry = love.math.random(459, 530)
		end

		-- iteminv table
		itemheart = {} 
		
		-- The contents of the iteminv table
		itemheart.x = self.heartzrx
		itemheart.y = self.heartzry
		itemheart.bb = Collider:addRectangle(itemheart.x, itemheart.y, 20, 20)
		itemheart.sprite = love.graphics.newImage("images/weapons/heart.png")
		itemheart.sprite2 = love.graphics.newImage("images/weapons/fadeheart.png")
		
		-- Insert SMG
		table.insert(self.hearts, itemheart)
		
		-- set the spawn rate and add one inv to inv count
		self.spawnrate = self.spawnrateplus
		self.count = self.count + 1
	end
end

function heart:update(dt)
	
	-- refresh the spawn rate
	self.spawnrate = math.max(0, self.spawnrate - dt)
end

function heart:draw()
	
	for i, o in ipairs(self.hearts) do
		
		------ FILTERS ------
		o.sprite:setFilter( 'nearest', 'nearest' )
		o.sprite2:setFilter( 'nearest', 'nearest' )
		------ FILTERS ------
		
		------ IMAGES ------
		if arcade.hearthad == false then
			love.graphics.draw(o.sprite, o.x, o.y)
			love.graphics.setColor(255, 255, 255, arcade.gunsflash)
			love.graphics.draw(o.sprite2, o.x, o.y)
			love.graphics.setColor(255, 255, 255)
		end
		------ IMAGES ------
	end
end

return heart