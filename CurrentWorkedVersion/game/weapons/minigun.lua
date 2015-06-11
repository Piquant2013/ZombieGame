local Gamestate = require 'libs/hump/gamestate'
minigun = Gamestate.new()

function minigun:initialize()
	self.spawnrate = 0
	self.spawnrateplus = 0
	self.count = 0
	self.miniguns = {}
end

function minigun:spawn()	
	if self.spawnrate <= 0 then
		self.minizrx = love.math.random(230, 980)
		self.minizry = love.math.random(180, 530)

		if self.minizrx > 490 and self.minizrx < 709 and self.minizry > 244 and self.minizry < 459 then
			self.minizrx = love.math.random(709, 980)
			self.minizry = love.math.random(459, 530)
		end

		gunmini = {} 
		gunmini.x = self.minizrx
		gunmini.y = self.minizry
		gunmini.ammo = 200
		gunmini.bb = Collider:addRectangle(gunmini.x, gunmini.y, 10, 10)
		gunmini.sprite = love.graphics.newImage("images/weapons/minigun.png")
		gunmini.sprite2 = love.graphics.newImage("images/weapons/fademini.png")
		table.insert(self.miniguns, gunmini)
		self.spawnrate = self.spawnrateplus
		self.count = self.count + 1
	end
end

function minigun:update(dt)
	self.spawnrate = math.max(0, self.spawnrate - dt)
end

function minigun:draw()
	for i, o in ipairs(self.miniguns) do
		o.sprite:setFilter( 'nearest', 'nearest' )
		o.sprite2:setFilter( 'nearest', 'nearest' )
		--o.bb:draw('line')
		if endless.minihad == false then
			love.graphics.draw(o.sprite, o.x, o.y)
			love.graphics.setColor(255, 255, 255, endless.gunsflash)
			love.graphics.draw(o.sprite2, o.x, o.y)
			love.graphics.setColor(255, 255, 255)
		end
	end
end

return minigun