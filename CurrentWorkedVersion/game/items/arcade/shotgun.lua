-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates game as a new gamestate
pistol = Gamestate.new()


function pistol:initialize()

	------ VARIABLES ------
	-- aim
	self.aimassist = false

	-- Bullet
	self.cooldown = 0
	self.cooldownplus = 0.25

	-- PISTOL --
	-- pistol table
	self.pis = {}
	pis = self.pis

	-- The contents of the pistol table
	pis.y = plyr.y
	pis.x = plyr.x
	pis.sprite = love.graphics.newImage("images/weapons/pistol.png")
	pis.aim = love.graphics.newImage("images/weapons/aim.png")
	-- PISTOL --

	-- BULLETS --
	-- bullet tables
	self.bullets = {}
	-- BULLETS --
	------ VARIABLES ------
end

function pistol:aim(mx, my, button)
	
	-- turn aim on and off
	if button == 2 and gameover == false and welcomescreen == false and self.aimassist == false then
		self.aimassist = true
	elseif button == 2 and gameover == false and welcomescreen == false and self.aimassist == true then
		self.aimassist = false
	end
end

function pistol:update(dt)

	if love.mouse.isDown(1) and self.cooldown <= 0 and gameover == false and welcomescreen == false and arcade.death == false then
		
		-- rotates and shoots towards the crosshair if the crosshair is more then 20 pixels away from the player
		if (mx1 > (plyr.x + 20) or (mx1 < (plyr.x - 20 ))) or (my1 > (plyr.y + 20 ) or (my1 < (plyr.y - 20 ))) then
			
			-- middle
			gmx = mx1 - 6 * math.sin(math.atan2(my1 - pis.y, mx1 - pis.x))
			gmy = my1 + 6 * math.cos(math.atan2(my1 - pis.y, mx1 - pis.x))
			self.direction = math.atan2(gmy - pis.y, gmx - pis.x)

			-- Shotgun bullets
			if arcade.wave > 9 and arcade.smghave == false and arcade.minihave == false and arcade.queminihave == false and arcade.quesmghave == false then
				
				-- left
				gmlx = mx1 - -6 * math.sin(math.atan2(my1 - pis.y, mx1 - pis.x))
				gmly = my1 + -6 * math.cos(math.atan2(my1 - pis.y, mx1 - pis.x))
				self.directionl = math.atan2(gmly - pis.y, gmlx - pis.x)

				-- right
				gmrx = mx1 - 18 * math.sin(math.atan2(my1 - pis.y, mx1 - pis.x))
				gmry = my1 + 18 * math.cos(math.atan2(my1 - pis.y, mx1 - pis.x))
				self.directionr = math.atan2(gmry - pis.y, gmrx - pis.x)
			end
		
		-- Rotate and shoot straght when the crosshair is within 20 pixels of the player
		elseif (mx1 > (plyr.x - 20) or (mx1 < (plyr.x + 20 ))) or (my1 > (plyr.y - 20 ) or (my1 < (plyr.y + 20 ))) then
			
			-- middle
			self.direction = math.atan2(my1 - pis.y, mx1 - pis.x)

			-- Shotgun bullets
			if arcade.wave > 9 and arcade.smghave == false and arcade.minihave == false and arcade.queminihave == false and arcade.quesmghave == false then
				
				-- left
				gmlx = mx1 - -0.5 * math.sin(math.atan2(my1 - pis.y, mx1 - pis.x))
				gmly = my1 + -0.5 * math.cos(math.atan2(my1 - pis.y, mx1 - pis.x))
				self.directionl = math.atan2(gmly - pis.y, gmlx - pis.x)

				-- right
				gmrx = mx1 - 0.5 * math.sin(math.atan2(my1 - pis.y, mx1 - pis.x))
				gmry = my1 + 0.5 * math.cos(math.atan2(my1 - pis.y, mx1 - pis.x))
				self.directionr = math.atan2(gmry - pis.y, gmrx - pis.x)
			end
		end

		-- bullet tables
		bullet = {}
		bulletleft = {}
		bulletright = {}

		-- The contents of the middle bullet table
		bullet.x = pis.x
		bullet.y = pis.y
		bullet.w = 1
		bullet.h = 12
		bullet.dir = self.direction
		bullet.speed = 600
		bullet.dead = 0
		bullet.bb = Collider:addRectangle(bullet.x, bullet.y, bullet.h, bullet.w)
		bullet.sound = love.audio.newSource("audio/weapons/pistol.ogg")
		bullet.sound2 = love.audio.newSource("audio/weapons/shotgun.ogg")
		bullet.sprite = love.graphics.newImage("images/weapons/bullet-pistol.png")

		-- Shotgun bullets
		if arcade.wave > 9 and arcade.smghave == false and arcade.minihave == false and arcade.queminihave == false and arcade.quesmghave == false then
			
			-- The contents of the left bullet table
			bulletleft.x = pis.x
			bulletleft.y = pis.y
			bulletleft.w = 1
			bulletleft.h = 12
			bulletleft.dir = self.directionl
			bulletleft.speed = 600
			bulletleft.dead = 0
			bulletleft.bb = Collider:addRectangle(bullet.x, bullet.y, bullet.h, bullet.w)
			bulletleft.sprite = love.graphics.newImage("images/weapons/bullet-pistol.png")

			-- The contents of the right bullet table
			bulletright.x = pis.x
			bulletright.y = pis.y
			bulletright.w = 1
			bulletright.h = 12
			bulletright.dir = self.directionr
			bulletright.speed = 600
			bulletright.dead = 0
			bulletright.bb = Collider:addRectangle(bullet.x, bullet.y, bullet.h, bullet.w)
			bulletright.sprite = love.graphics.newImage("images/weapons/bullet-pistol.png")
		end

		-- Insert the bullet
		table.insert(self.bullets, bullet)

		-- Shotgun bullets
		if arcade.wave > 9 and arcade.smghave == false and arcade.minihave == false and arcade.queminihave == false and arcade.quesmghave == false then
			table.insert(self.bullets, bulletleft)
			table.insert(self.bullets, bulletright)
		end

		self.cooldown = self.cooldownplus

		if arcade.wave < 10 or arcade.smghave == true or arcade.minihave == true or arcade.queminihave == true or arcade.quesmghave == true then
			love.audio.play(bullet.sound)
			bullet.sound:setVolume(sfxvolume)
		end

		if arcade.wave > 9 and arcade.smghave == false and arcade.minihave == false and arcade.queminihave == false and arcade.quesmghave == false then
			love.audio.play(bullet.sound2)
			bullet.sound2:setVolume(sfxvolume)
		end

		-- Take off ammo while you fire for special weapons in arcade mode
		for i, o in ipairs(smg.smgs) do
			o.ammo = o.ammo - 1

			if o.ammo < 0 then
				o.ammo = 0
			end
		end

		for i, o in ipairs(minigun.miniguns) do
			o.ammo = o.ammo - 1
			
			if o.ammo < 0 then
				o.ammo = 0
			end
		end

		arcade.quesmgammo = arcade.quesmgammo - 1

		if arcade.quesmgammo < 0 then
			arcade.quesmgammo = 0
		end

		arcade.queminiammo = arcade.queminiammo - 1

		if arcade.queminiammo < 0 then
			arcade.queminiammo = 0
		end

		-- allow the shotgun to kill 2 zombies per shot
		bullet.dead = 0
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

function pistol:aimdraw()

	-- Draw the aim assist for when the mouse is away from the player
	if (mx1 > (plyr.x + 20) or (mx1 < (plyr.x - 20 ))) or (my1 > (plyr.y + 20 ) or (my1 < (plyr.y - 20 ))) then
		if self.aimassist == true and gameover == false then
			love.graphics.push()
			love.graphics.setColor(160, 47, 0, 120)
			love.graphics.setLineWidth(0.8)
			self.aimdirection = math.atan2(my1 - pis.y, mx1 - pis.x)
			love.graphics.line( pis.x + 6 * math.sin(self.aimdirection), pis.y - 6 * math.cos(self.aimdirection), mx1, my1)
			love.graphics.setColor(255, 255, 255)
			love.graphics.pop()
		end
	
	-- draw the aim assist when the mouse is close to the player
	elseif (mx1 > (plyr.x - 20) or (mx1 < (plyr.x + 20 ))) or (my1 > (plyr.y - 20 ) or (my1 < (plyr.y + 20 ))) then
		if self.aimassist == true and gameover == false then
			love.graphics.setColor(255, 255, 255, 120)
			love.graphics.draw(pis.aim, pis.x, pis.y, plyr.rotation, 1, 1, plyr.sprite:getWidth() - 40, plyr.sprite:getHeight() - 25)
			love.graphics.setColor(255, 255, 255)
		end
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