-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates game as a new gamestate
clickratepistol = Gamestate.new()


function clickratepistol:initialize()

	------ VARIABLES ------
	-- Bullet
	self.cooldown = 0
	self.cooldownplus = 0

	-- PISTOL --
	-- pistol table
	self.crp = {}
	crp = self.crp

	-- The contents of the pistol table
	crp.y = plyr.y
	crp.x = plyr.x
	crp.sprite = love.graphics.newImage("images/weapons/pistol.png")
	-- PISTOL --

	-- BULLETS --
	-- bullet tables
	self.bullets = {}
	-- BULLETS --
	------ VARIABLES ------
end

function clickratepistol:shooting(mx, my, button)

	if button == "l" and self.cooldown <= 0 and gameover == false and welcomescreen == false then
		
		-- rotates and shoots towards the crosshair if the crosshair is more then 20 pixels away from the player
		if (mx1 > (plyr.x + 20) or (mx1 < (plyr.x - 20 ))) or (my1 > (plyr.y + 20 ) or (my1 < (plyr.y - 20 ))) then
			gmx = mx1 - 6 * math.sin(math.atan2(my1 - crp.y, mx1 - crp.x))
			gmy = my1 + 6 * math.cos(math.atan2(my1 - crp.y, mx1 - crp.x))
			self.direction = math.atan2(gmy - crp.y, gmx - crp.x)
		
		-- Rotate and shoot straght when the crosshair is within 20 pixels of the player
		elseif (mx1 > (plyr.x - 20) or (mx1 < (plyr.x + 20 ))) or (my1 > (plyr.y - 20 ) or (my1 < (plyr.y + 20 ))) then
			self.direction = math.atan2(my1 - crp.y, mx1 - crp.x)
		end

		-- bullet tables
		self.bullet = {}

		-- The contents of the bullets table
		self.bullet.x = crp.x
		self.bullet.y = crp.y
		self.bullet.w = 1
		self.bullet.h = 12
		self.bullet.dir = self.direction
		self.bullet.speed = 400
		self.bullet.bb = Collider:addRectangle(self.bullet.x, self.bullet.y, self.bullet.h, self.bullet.w)
		self.bullet.sound = love.audio.newSource("audio/weapons/pistol.ogg")
		self.bullet.sprite = love.graphics.newImage("images/weapons/bullet-pistol.png")

		-- Insert the bullet
		table.insert(self.bullets, self.bullet)
		self.cooldown = self.cooldownplus
		love.audio.play(self.bullet.sound)
	end
end

function clickratepistol:update(dt)

	-- cool down pistol
	self.cooldown = math.max(0, self.cooldown - dt)

	-- keep gun with the player and set crosshair
	crp.x = plyr.x
    crp.y = plyr.y
	love.mouse.setCursor(crosshair)
	 	
	for i, o in ipairs(self.bullets) do

		-- Move bullet
		o.x = o.x + math.cos(o.dir) * o.speed * dt
		o.y = o.y + math.sin(o.dir) * o.speed * dt
		
		-- add to the players group
		Collider:addToGroup("players", o.bb)

		-- Unspawn bullet if its 250 pixels away from the player
		if (o.x > (plyr.x + 250) or (o.x < (plyr.x - 250 ))) or (o.y > (plyr.y + 250 ) or (o.y < (plyr.y - 250 ))) then
			Collider:removeFromGroup("players", o.bb)
			Collider:remove(o.bb)
			table.remove(self.bullets, i)
		end
	end
end

function clickratepistol:bulletdraw()

	for i, o in ipairs(self.bullets) do
		------ FILTERS ------
		o.sprite:setFilter( 'nearest', 'nearest' )
		------ FILTERS ------
		
		------ IMAGES ------
		-- draw bullet
		love.graphics.draw(o.sprite, o.x, o.y, o.dir, 1, 1, plyr.sprite:getWidth() - 26, plyr.sprite:getHeight() - 25)

		-- Move and rotate bullet.bb with the bullet
		o.bb:moveTo(o.x + 6 * math.sin(o.dir), o.y - 6 * math.cos(o.dir))
		o.bb:setRotation(o.dir)
		------ IMAGES ------
	end
end

function clickratepistol:draw()

	------ FILTERS ------
	crp.sprite:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	------ IMAGES ------
	if gameover == false then

		-- Move the pistol towards the crosshair if the crosshair is atleast 20 pixels away from the player 
		if (mx1 > (plyr.x + 20) or (mx1 < (plyr.x - 20 ))) or (my1 > (plyr.y + 20 ) or (my1 < (plyr.y - 20 ))) then
			love.graphics.draw(crp.sprite, crp.x, crp.y, player.armrot, 1, 1, plyr.sprite:getWidth() - 40, plyr.sprite:getHeight() - 25)

		-- Rotate the pistol with normal player rotate when the crosshair is within 20 pixels of the player
		elseif (mx1 > (plyr.x - 20) or (mx1 < (plyr.x + 20 ))) or (my1 > (plyr.y - 20 ) or (my1 < (plyr.y + 20 ))) then
			love.graphics.draw(crp.sprite, crp.x, crp.y, plyr.rotation, 1, 1, plyr.sprite:getWidth() - 40, plyr.sprite:getHeight() - 25)	
		end
	
	elseif gameover == true then
		
		-- lock the pistol draw position when death
		love.graphics.draw(crp.sprite, crp.x, crp.y, plyr.deadrotation, 1, 1, plyr.sprite:getWidth() - 40, plyr.sprite:getHeight() - 25)
	end
	------ IMAGES ------
end

return clickratepistol