-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates minigun as a new gamestate
minigun = Gamestate.new()

function minigun:initialize()
	------ VARIABLES ------
	-- minigun spawn rate
	self.spawnrate = 0
	self.spawnrateplus = 0
	
	-- minigun vars
	self.count = 0
	
	-- miniguns table
	self.miniguns = {}
	------ VARIABLES ------
end

function minigun:spawn()	
	
	if self.spawnrate <= 0 then
	
		-- Sets the random spawn points for the minigun
		self.minizrx = love.math.random(230, 980)
		self.minizry = love.math.random(180, 530)

		if self.minizrx > 490 and self.minizrx < 709 and self.minizry > 244 and self.minizry < 459 then
			self.minizrx = love.math.random(709, 980)
			self.minizry = love.math.random(459, 530)
		end

		-- gunmini table
		gunmini = {} 

		-- The contents of the gunmini table
		gunmini.x = self.minizrx
		gunmini.y = self.minizry
		gunmini.ammo = 200
		gunmini.bb = Collider:addRectangle(gunmini.x, gunmini.y, 20, 20)
		gunmini.sprite = love.graphics.newImage("images/weapons/minigun.png")
		gunmini.sprite2 = love.graphics.newImage("images/weapons/fademini.png")
		
		-- Insert Minigun
		table.insert(self.miniguns, gunmini)
		
		-- set the spawn rate and add one minigun to minigun count
		self.spawnrate = self.spawnrateplus
		self.count = self.count + 1
	end
end

function minigun:update(dt)
	
	-- refresh the spawn rate
	self.spawnrate = math.max(0, self.spawnrate - dt)
end

function minigun:draw()
	
	for i, o in ipairs(self.miniguns) do
		
		------ FILTERS ------
		o.sprite:setFilter( 'nearest', 'nearest' )
		o.sprite2:setFilter( 'nearest', 'nearest' )
		------ FILTERS ------

		------ IMAGES ------
		if endless.minihad == false then
			love.graphics.draw(o.sprite, o.x, o.y)
			love.graphics.setColor(255, 255, 255, endless.gunsflash)
			love.graphics.draw(o.sprite2, o.x, o.y)
			love.graphics.setColor(255, 255, 255)
		end
		------ IMAGES ------
	end
end

return minigun