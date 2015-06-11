local Gamestate = require 'libs/hump/gamestate'
smg = Gamestate.new()

function smg:initialize()
	self.spawnrate = 0
	self.spawnrateplus = 0
	self.count = 0
	self.smgs = {}
end

function smg:spawn()	
	if self.spawnrate <= 0 then
		self.smgzrx = love.math.random(230, 980)
		self.smgzry = love.math.random(180, 530)

		if self.smgzrx > 490 and self.smgzrx < 709 and self.smgzry > 244 and self.smgzry < 459 then
			self.smgzrx = love.math.random(709, 980)
			self.smgzry = love.math.random(459, 530)
		end

		gunsmg = {} 
		gunsmg.x = self.smgzrx
		gunsmg.y = self.smgzry
		gunsmg.ammo = 160
		gunsmg.bb = Collider:addRectangle(gunsmg.x, gunsmg.y, 20, 20)
		gunsmg.sprite = love.graphics.newImage("images/weapons/smg.png")
		gunsmg.sprite2 = love.graphics.newImage("images/weapons/fadesmg.png")
		table.insert(self.smgs, gunsmg)
		self.spawnrate = self.spawnrateplus
		self.count = self.count + 1
	end
end

function smg:update(dt)
	self.spawnrate = math.max(0, self.spawnrate - dt)
end

function smg:draw()
	for i, o in ipairs(self.smgs) do
		o.sprite:setFilter( 'nearest', 'nearest' )
		o.sprite2:setFilter( 'nearest', 'nearest' )
		--o.bb:draw('line')
		if endless.smghad == false then
			love.graphics.draw(o.sprite, o.x, o.y)
			love.graphics.setColor(255, 255, 255, endless.gunsflash)
			love.graphics.draw(o.sprite2, o.x, o.y)
			love.graphics.setColor(255, 255, 255)
		end
	end
end

return smg