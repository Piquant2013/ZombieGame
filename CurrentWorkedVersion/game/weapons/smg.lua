-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates smg as a new gamestate
smg = Gamestate.new()

function smg:initialize()
	------ VARIABLES ------
	-- smg spawn rate
	self.spawnrate = 0
	self.spawnrateplus = 0
	
	-- smg vars
	self.count = 0
	
	-- smgs table
	self.smgs = {}
	------ VARIABLES ------
end

function smg:spawn()	
	
	if self.spawnrate <= 0 then
		
		-- Sets the random spawn points for the smg
		self.smgzrx = love.math.random(230, 980)
		self.smgzry = love.math.random(180, 530)

		if self.smgzrx > 490 and self.smgzrx < 709 and self.smgzry > 244 and self.smgzry < 459 then
			self.smgzrx = love.math.random(709, 980)
			self.smgzry = love.math.random(459, 530)
		end

		-- gunsmg table
		gunsmg = {} 
		
		-- The contents of the gunsmg table
		gunsmg.x = self.smgzrx
		gunsmg.y = self.smgzry
		gunsmg.ammo = 160
		gunsmg.bb = Collider:addRectangle(gunsmg.x, gunsmg.y, 20, 20)
		gunsmg.sprite = love.graphics.newImage("images/weapons/smg.png")
		gunsmg.sprite2 = love.graphics.newImage("images/weapons/fadesmg.png")
		
		-- Insert SMG
		table.insert(self.smgs, gunsmg)
		
		-- set the spawn rate and add one smg to smg count
		self.spawnrate = self.spawnrateplus
		self.count = self.count + 1
	end
end

function smg:update(dt)
	
	-- refresh the spawn rate
	self.spawnrate = math.max(0, self.spawnrate - dt)
end

function smg:draw()
	
	for i, o in ipairs(self.smgs) do
		
		------ FILTERS ------
		o.sprite:setFilter( 'nearest', 'nearest' )
		o.sprite2:setFilter( 'nearest', 'nearest' )
		------ FILTERS ------
		
		------ IMAGES ------
		if endless.smghad == false then
			love.graphics.draw(o.sprite, o.x, o.y)
			love.graphics.setColor(255, 255, 255, endless.gunsflash)
			love.graphics.draw(o.sprite2, o.x, o.y)
			love.graphics.setColor(255, 255, 255)
		end
		------ IMAGES ------
	end
end

return smg