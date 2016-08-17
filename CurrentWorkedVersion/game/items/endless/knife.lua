-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates game as a new gamestate
handgun = Gamestate.new()


function handgun:initialize()

	------ VARIABLES ------
	-- aim
	self.aimassist = false

	-- Bullet
	self.cooldown = 0
	self.cooldownplus = 0.25

	-- PISTOL --
	-- pistol table
	self.hand = {}
	hand = self.hand

	-- The contents of the pistol table
	hand.y = plyr.y
	hand.x = plyr.x
	hand.sprite = love.graphics.newImage("images/weapons/pistol.png")
	hand.aim = love.graphics.newImage("images/weapons/aim.png")
	-- PISTOL --

	-- BULLETS --
	-- bullet tables
	self.bullets = {}
	-- BULLETS --
	------ VARIABLES ------
end

function handgun:aim(mx, my, button)
	
	-- turn aim on and off
	if button == 2 and gameover == false and welcomescreen == false and self.aimassist == false then
		self.aimassist = true
	elseif button == 2 and gameover == false and welcomescreen == false and self.aimassist == true then
		self.aimassist = false
	end
end

function handgun:update(dt)

	if love.mouse.isDown(1) and self.cooldown <= 0 and gameover == false and welcomescreen == false then
		
		-- rotates and shoots towards the crosshair if the crosshair is more then 20 pixels away from the player
		if (mx1 > (plyr.x + 20) or (mx1 < (plyr.x - 20 ))) or (my1 > (plyr.y + 20 ) or (my1 < (plyr.y - 20 ))) then
			
			-- middle
			gmx = mx1 - 6 * math.sin(math.atan2(my1 - hand.y, mx1 - hand.x))
			gmy = my1 + 6 * math.cos(math.atan2(my1 - hand.y, mx1 - hand.x))
			self.direction = math.atan2(gmy - hand.y, gmx - hand.x)
		
		-- Rotate and shoot straght when the crosshair is within 20 pixels of the player
		elseif (mx1 > (plyr.x - 20) or (mx1 < (plyr.x + 20 ))) or (my1 > (plyr.y - 20 ) or (my1 < (plyr.y + 20 ))) then
			
			-- middle
			self.direction = math.atan2(my1 - hand.y, mx1 - hand.x)
		end

		-- bullet tables
		bullet = {}

		-- The contents of the middle bullet table
		bullet.x = hand.x
		bullet.y = hand.y
		bullet.w = 1
		bullet.h = 12
		bullet.dir = self.direction
		bullet.speed = 600
		bullet.dead = 0
		bullet.bb = Collider:addRectangle(bullet.x, bullet.y, bullet.h, bullet.w)
		bullet.sound = love.audio.newSource("audio/weapons/pistol.ogg")
		bullet.sound2 = love.audio.newSource("audio/weapons/shotgun.ogg")
		bullet.sprite = love.graphics.newImage("images/weapons/bullet-pistol.png")

		-- Insert the bullet
		table.insert(self.bullets, bullet)


		self.cooldown = self.cooldownplus
		love.audio.play(bullet.sound)
		bullet.sound:setVolume(sfxvolume)
	end

	-- cool down pistol
	self.cooldown = math.max(0, self.cooldown - dt)

	-- keep gun with the player and set crosshair
	hand.x = plyr.x
    hand.y = plyr.y
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

function handgun:bulletdraw()

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

function handgun:aimdraw()

	-- Draw the aim assist for when the mouse is away from the player
	if (mx1 > (plyr.x + 20) or (mx1 < (plyr.x - 20 ))) or (my1 > (plyr.y + 20 ) or (my1 < (plyr.y - 20 ))) then
		if self.aimassist == true and gameover == false then
			love.graphics.push()
			love.graphics.setColor(160, 47, 0, 120)
			love.graphics.setLineWidth(0.8)
			self.aimdirection = math.atan2(my1 - hand.y, mx1 - hand.x)
			love.graphics.line( hand.x + 6 * math.sin(self.aimdirection), hand.y - 6 * math.cos(self.aimdirection), mx1, my1)
			love.graphics.setColor(255, 255, 255)
			love.graphics.pop()
		end
	
	-- draw the aim assist when the mouse is close to the player
	elseif (mx1 > (plyr.x - 20) or (mx1 < (plyr.x + 20 ))) or (my1 > (plyr.y - 20 ) or (my1 < (plyr.y + 20 ))) then
		if self.aimassist == true and gameover == false then
			love.graphics.setColor(255, 255, 255, 120)
			love.graphics.draw(hand.aim, hand.x, hand.y, plyr.rotation, 1, 1, plyr.sprite:getWidth() - 40, plyr.sprite:getHeight() - 25)
			love.graphics.setColor(255, 255, 255)
		end
	end
end

function handgun:draw()

	------ FILTERS ------
	hand.sprite:setFilter( 'nearest', 'nearest' )
	hand.aim:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	------ IMAGES ------
	if gameover == false then

		-- Move the pistol towards the crosshair if the crosshair is atleast 20 pixels away from the player 
		if (mx1 > (plyr.x + 20) or (mx1 < (plyr.x - 20 ))) or (my1 > (plyr.y + 20 ) or (my1 < (plyr.y - 20 ))) then
			love.graphics.draw(hand.sprite, hand.x, hand.y, player.armrot, 1, 1, plyr.sprite:getWidth() - 40, plyr.sprite:getHeight() - 25)

		-- Rotate the pistol with normal player rotate when the crosshair is within 20 pixels of the player
		elseif (mx1 > (plyr.x - 20) or (mx1 < (plyr.x + 20 ))) or (my1 > (plyr.y - 20 ) or (my1 < (plyr.y + 20 ))) then
			love.graphics.draw(hand.sprite, hand.x, hand.y, plyr.rotation, 1, 1, plyr.sprite:getWidth() - 40, plyr.sprite:getHeight() - 25)
		end
	
	elseif gameover == true then
		
		-- lock the pistol draw position when death
		love.graphics.draw(hand.sprite, hand.x, hand.y, plyr.deadrotation, 1, 1, plyr.sprite:getWidth() - 40, plyr.sprite:getHeight() - 25)
	end
	------ IMAGES ------
end

return handgun