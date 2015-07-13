-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates inv as a new gamestate
shoe = Gamestate.new()

function shoe:initialize()
	------ VARIABLES ------
	-- shoe spawn rate
	self.spawnrate = 0
	self.spawnrateplus = 0
	
	-- shoe vars
	self.count = 0
	
	-- shoes table
	self.shoes = {}
	------ VARIABLES ------
end

function shoe:spawn()	
	
	if self.spawnrate <= 0 then
		
		-- Sets the random spawn points for the smg
		self.shoezrx = love.math.random(230, 980)
		self.shoezry = love.math.random(180, 530)

		if self.shoezrx > 490 and self.shoezrx < 709 and self.shoezry > 244 and self.shoezry < 459 then
			self.shoezrx = love.math.random(709, 980)
			self.shoezry = love.math.random(459, 530)
		end

		-- iteminv table
		itemshoe = {} 
		
		-- The contents of the iteminv table
		itemshoe.x = self.shoezrx
		itemshoe.y = self.shoezry
		itemshoe.bb = Collider:addRectangle(itemshoe.x, itemshoe.y, 20, 20)
		itemshoe.sprite = love.graphics.newImage("images/weapons/shoe.png")
		itemshoe.sprite2 = love.graphics.newImage("images/weapons/fadeshoe.png")
		
		-- Insert SMG
		table.insert(self.shoes, itemshoe)
		
		-- set the spawn rate and add one inv to inv count
		self.spawnrate = self.spawnrateplus
		self.count = self.count + 1
	end
end

function shoe:update(dt)
	
	-- refresh the spawn rate
	self.spawnrate = math.max(0, self.spawnrate - dt)
end

function shoe:draw()
	
	for i, o in ipairs(self.shoes) do
		
		------ FILTERS ------
		o.sprite:setFilter( 'nearest', 'nearest' )
		o.sprite2:setFilter( 'nearest', 'nearest' )
		------ FILTERS ------
		
		------ IMAGES ------
		if endless.shoehad == false then
			love.graphics.draw(o.sprite, o.x, o.y)
			love.graphics.setColor(255, 255, 255, endless.gunsflash)
			love.graphics.draw(o.sprite2, o.x, o.y)
			love.graphics.setColor(255, 255, 255)
		end
		------ IMAGES ------
	end
end

return shoe