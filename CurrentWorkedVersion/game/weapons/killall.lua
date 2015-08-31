-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates inv as a new gamestate
killall = Gamestate.new()

function killall:initialize()
	------ VARIABLES ------
	-- killall spawn rate
	self.spawnrate = 0
	self.spawnrateplus = 0
	
	-- killall vars
	self.count = 0
	
	-- killalls table
	self.killalls = {}
	------ VARIABLES ------
end

function killall:spawn()	
	
	if self.spawnrate <= 0 then
		
		-- Sets the random spawn points for the smg
		self.killallzrx = love.math.random(230, 980)
		self.killallzry = love.math.random(180, 530)

		if self.killallzrx > 490 and self.killallzrx < 709 and self.killallzry > 244 and self.killallzry < 459 then
			self.killallzrx = love.math.random(709, 980)
			self.killallzry = love.math.random(459, 530)
		end

		-- iteminv table
		itemkillall = {} 
		
		-- The contents of the iteminv table
		itemkillall.x = self.killallzrx
		itemkillall.y = self.killallzry
		itemkillall.bb = Collider:addRectangle(itemkillall.x, itemkillall.y, 20, 20)
		itemkillall.sprite = love.graphics.newImage("images/weapons/killall.png")
		itemkillall.sprite2 = love.graphics.newImage("images/weapons/fadekillall.png")
		
		-- Insert SMG
		table.insert(self.killalls, itemkillall)
		
		-- set the spawn rate and add one inv to inv count
		self.spawnrate = self.spawnrateplus
		self.count = self.count + 1
	end
end

function killall:update(dt)
	
	-- refresh the spawn rate
	self.spawnrate = math.max(0, self.spawnrate - dt)
end

function killall:draw()
	
	for i, o in ipairs(self.killalls) do
		
		------ FILTERS ------
		o.sprite:setFilter( 'nearest', 'nearest' )
		o.sprite2:setFilter( 'nearest', 'nearest' )
		------ FILTERS ------
		
		------ IMAGES ------
		if arcade.killallhad == false then
			love.graphics.draw(o.sprite, o.x, o.y)
			love.graphics.setColor(255, 255, 255, arcade.gunsflash)
			love.graphics.draw(o.sprite2, o.x, o.y)
			love.graphics.setColor(255, 255, 255)
		end
		------ IMAGES ------
	end
end

return killall