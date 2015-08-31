-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates inv as a new gamestate
inv = Gamestate.new()

function inv:initialize()
	------ VARIABLES ------
	-- inv spawn rate
	self.spawnrate = 0
	self.spawnrateplus = 0
	
	-- inv vars
	self.count = 0
	
	-- invs table
	self.invs = {}
	------ VARIABLES ------
end

function inv:spawn()	
	
	if self.spawnrate <= 0 then
		
		-- Sets the random spawn points for the smg
		self.invzrx = love.math.random(230, 980)
		self.invzry = love.math.random(180, 530)

		if self.invzrx > 490 and self.invzrx < 709 and self.invzry > 244 and self.invzry < 459 then
			self.invzrx = love.math.random(709, 980)
			self.invzry = love.math.random(459, 530)
		end

		-- iteminv table
		iteminv = {} 
		
		-- The contents of the iteminv table
		iteminv.x = self.invzrx
		iteminv.y = self.invzry
		iteminv.bb = Collider:addRectangle(iteminv.x, iteminv.y, 20, 20)
		iteminv.sprite = love.graphics.newImage("images/weapons/inv.png")
		iteminv.sprite2 = love.graphics.newImage("images/weapons/fadeinv.png")
		iteminv.sprite3 = love.graphics.newImage("images/weapons/bubble.png")
		
		-- Insert SMG
		table.insert(self.invs, iteminv)
		
		-- set the spawn rate and add one inv to inv count
		self.spawnrate = self.spawnrateplus
		self.count = self.count + 1
	end
end

function inv:update(dt)
	
	-- refresh the spawn rate
	self.spawnrate = math.max(0, self.spawnrate - dt)
end

function inv:draw()
	
	for i, o in ipairs(self.invs) do
		
		------ FILTERS ------
		o.sprite:setFilter( 'nearest', 'nearest' )
		o.sprite2:setFilter( 'nearest', 'nearest' )
		o.sprite3:setFilter( 'nearest', 'nearest' )
		------ FILTERS ------
		
		------ IMAGES ------
		if arcade.invhad == false then
			love.graphics.draw(o.sprite, o.x, o.y)
			love.graphics.setColor(255, 255, 255, arcade.gunsflash)
			love.graphics.draw(o.sprite2, o.x, o.y)
			love.graphics.setColor(255, 255, 255)
		end

		if arcade.invhave == true then
			love.graphics.draw(o.sprite3, plyr.x, plyr.y, 0, 1, 1, plyr.sprite:getWidth()/2, plyr.sprite:getHeight()/2)
		end
		------ IMAGES ------
	end
end

return inv