-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates game as a new gamestate
pistol = Gamestate.new()


function pistol:initialize()

	------ VARIABLES ------
	-- Bullet
	self.cooldown = 0
	self.cooldownplus = 0.25
	self.aimresize = 0


	--aim = {
		--x = 400,
		--y = 300,
		--w = 16,
		--h = 2,
	--}


	-- PISTOL --
	-- pistol table
	self.pis = {}
	pis = self.pis

	-- The contents of the pistol table
	pis.y = plyr.y
	pis.x = plyr.x
	pis.sprite = love.graphics.newImage("images/weapons/pistol.png")
	pis.aim = love.graphics.newImage("images/aim.png")
	-- PISTOL --

	-- BULLETS --
	-- bullet tables
	self.bullets = {}
	-- BULLETS --
	------ VARIABLES ------
end

function pistol:update(dt)

	if love.mouse.isDown('l') and self.cooldown <= 0 and gameover == false and welcomescreen == false then
		
		-- rotates and shoots towards the crosshair if the crosshair is more then 20 pixels away from the player
		if (mx1 > (plyr.x + 20) or (mx1 < (plyr.x - 20 ))) or (my1 > (plyr.y + 20 ) or (my1 < (plyr.y - 20 ))) then
			gmx = mx1 - 6 * math.sin(math.atan2(my1 - pis.y, mx1 - pis.x))
			gmy = my1 + 6 * math.cos(math.atan2(my1 - pis.y, mx1 - pis.x))
			self.direction = math.atan2(gmy - pis.y, gmx - pis.x)
		
		-- Rotate and shoot straght when the crosshair is within 20 pixels of the player
		elseif (mx1 > (plyr.x - 20) or (mx1 < (plyr.x + 20 ))) or (my1 > (plyr.y - 20 ) or (my1 < (plyr.y + 20 ))) then
			self.direction = math.atan2(my1 - pis.y, mx1 - pis.x)
		end

		-- bullet tables
		bullet = {}

		-- The contents of the bullets table
		bullet.x = pis.x
		bullet.y = pis.y
		bullet.w = 1
		bullet.h = 12
		bullet.dir = self.direction
		bullet.speed = 500
		bullet.bb = Collider:addRectangle(bullet.x, bullet.y, bullet.h, bullet.w)
		bullet.sound = love.audio.newSource("audio/weapons/pistol.ogg")
		bullet.sprite = love.graphics.newImage("images/weapons/bullet-pistol.png")

		-- Insert the bullet
		table.insert(self.bullets, bullet)
		self.cooldown = self.cooldownplus
		love.audio.play(bullet.sound)
	end

	-- cool down pistol
	self.cooldown = math.max(0, self.cooldown - dt)

	-- keep gun with the player and set crosshair
	pis.x = plyr.x
    pis.y = plyr.y
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

function pistol:bulletdraw()

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

function pistol:draw()

	------ FILTERS ------
	pis.sprite:setFilter( 'nearest', 'nearest' )
	pis.aim:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	------ IMAGES ------
	if gameover == false then

		-- Move the pistol towards the crosshair if the crosshair is atleast 20 pixels away from the player 
		if (mx1 > (plyr.x + 20) or (mx1 < (plyr.x - 20 ))) or (my1 > (plyr.y + 20 ) or (my1 < (plyr.y - 20 ))) then
			love.graphics.draw(pis.sprite, pis.x, pis.y, player.armrot, 1, 1, plyr.sprite:getWidth() - 40, plyr.sprite:getHeight() - 25)





			--love.graphics.push()
			--love.graphics.translate( aim.x, aim.y )
			--love.graphics.rotate( player.armrot )
			--love.graphics.rectangle( 'fill', -aim.w/2, -aim.h/2, plyr.y - mx1, aim.h )
			--love.graphics.pop()

			--love.graphics.draw(pis.aim, pis.x, pis.y, player.armrot, 1, 1, 0, plyr.sprite:getHeight() - 25)
			--love.graphics.push()
			--love.graphics.rotate(player.armrot)
			--love.graphics.translate(0, plyr.sprite:getHeight()/2)
			--love.graphics.rectangle("fill", pis.x, pis.y, plyr.x - mx1, 2)
			--love.graphics.pop()





		-- Rotate the pistol with normal player rotate when the crosshair is within 20 pixels of the player
		elseif (mx1 > (plyr.x - 20) or (mx1 < (plyr.x + 20 ))) or (my1 > (plyr.y - 20 ) or (my1 < (plyr.y + 20 ))) then
			love.graphics.draw(pis.sprite, pis.x, pis.y, plyr.rotation, 1, 1, plyr.sprite:getWidth() - 40, plyr.sprite:getHeight() - 25)	
		end
	
	elseif gameover == true then
		
		-- lock the pistol draw position when death
		love.graphics.draw(pis.sprite, pis.x, pis.y, plyr.deadrotation, 1, 1, plyr.sprite:getWidth() - 40, plyr.sprite:getHeight() - 25)
	end
	------ IMAGES ------
end

return pistol