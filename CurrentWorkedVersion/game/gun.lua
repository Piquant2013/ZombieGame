-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads Hardon Collider script
local HC = require 'libs/hardoncollider'

-- Creates game as a new gamestate
gun = Gamestate.new()


function gun:initialize()

	-- Gun table and its varibles
	self.pistol = {}

	-- So dont have to keep writing gun at the start of every gun var
	pistol = self.pistol
	
	-- Bullet
	ShotTime = 0
	ShotTimePlus = 0.3
	self.Bullets = {}
	self.GunShot = false
	self.GunShot1 = false
	self.Shot = love.graphics.newImage("images/shot.png")
	
	-- Gun
	pistol.GunY = plyr.y
	pistol.GunX = plyr.x
	pistol.yes = false
	pistol.itemx = 750
	pistol.itemy = 380
	pistol.sprite = love.graphics.newImage("images/gun.png")
	pistol.invsprite = love.graphics.newImage("images/gunitem.png")
	pistol.itemsprite = love.graphics.newImage("images/gunitem.png")
	
	------ AUDIO ------
	self.GunSound = love.audio.newSource("audio/gun.ogg")
	self.GunSound1 = love.audio.newSource("audio/gun.ogg")
	------ AUDIO ------

	self.InteractFont = love.graphics.newFont("fonts/xen3.ttf", 10)
end

function gun:update(dt)

	if love.mouse.isDown('l') and ShotTime <= 0 and sship.entered == false then
		
		if (mx1 > (plyr.x + 20) or (mx1 < (plyr.x - 20 ))) or (my1 > (plyr.y + 20 ) or (my1 < (plyr.y - 20 ))) then
			
			-- The bullet direction
			GunMX = mx1 - 6 * math.sin(math.atan2(my1 - pistol.GunY, mx1 - pistol.GunX))
			GunMY = my1 + 6 * math.cos(math.atan2(my1 - pistol.GunY, mx1 - pistol.GunX))
			self.Direction = math.atan2(GunMY - pistol.GunY, GunMX - pistol.GunX)

		elseif (mx1 > (plyr.x - 20) or (mx1 < (plyr.x + 20 ))) or (my1 > (plyr.y - 20 ) or (my1 < (plyr.y + 20 ))) then

			-- The bullet direction
			self.Direction = math.atan2(my1 - pistol.GunY, mx1 - pistol.GunX)

		end
		
		-- shot bullet when left click
		bullet = {}

		bullet.x = pistol.GunX
		bullet.y = pistol.GunY
		bullet.Dir = self.Direction
		bullet.Speed = 400
		bullet.bb = Collider:addRectangle(bullet.x, bullet.y, 12, 1)
		bullet.sound = love.audio.newSource("audio/gun.ogg")

		table.insert(self.Bullets, bullet)
		
		-- Reset shot timer
		ShotTime = ShotTimePlus
	end

	-- Shot time
	ShotTime = math.max(0, ShotTime - dt)
	 	
	for i, o in ipairs(self.Bullets) do

		-- Set bullet speed, rotation and postion
		o.x = o.x + math.cos(o.Dir) * o.Speed * dt
		o.y = o.y + math.sin(o.Dir) * o.Speed * dt

		love.audio.play(o.sound)
		Collider:addToGroup("players", o.bb)

		if (o.x > (plyr.x + 300) or (o.x < (plyr.x - 300 ))) or (o.y > (plyr.y + 300 ) or (o.y < (plyr.y - 300 ))) then
			
			-- if the bullet goes off screen undraw it and move the bullet hit box (Temporally) to 4000, 4000
			Collider:removeFromGroup("players", o.bb)
			Collider:remove(o.bb)
			table.remove(self.Bullets, i)
		end
	end

		-- gun follows the player
		pistol.GunX = plyr.x
    	pistol.GunY = plyr.y
    	
    	-- gun item follows the player
    	pistol.itemx = plyr.x
    	pistol.itemy = plyr.y

		-- If you have the gun then change the cursor to the crosshair
		love.mouse.setCursor(crosshair)
end

function gun:bulletdraw()

	------ FILTERS ------
	self.Shot:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	for i, o in ipairs(self.Bullets) do

		-- Gun bullet graphic
		love.graphics.draw(self.Shot, o.x, o.y, o.Dir, 1, 1, plyr.sprite:getWidth() - 26, plyr.sprite:getHeight() - 25)

		-- Move and rotate bullet hitbox
		o.bb:moveTo(o.x + 6 * math.sin(o.Dir), o.y - 6 * math.cos(o.Dir))
		o.bb:setRotation(o.Dir)
		o.bb:draw('line')
	end
end

function gun:draw()

	------ FILTERS ------
	pistol.sprite:setFilter( 'nearest', 'nearest' )
	pistol.itemsprite:setFilter( 'nearest', 'nearest' )
	pistol.invsprite:setFilter( 'nearest', 'nearest' )
	self.InteractFont:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	if sship.entered == false then

		if (mx1 > (plyr.x + 20) or (mx1 < (plyr.x - 20 ))) or (my1 > (plyr.y + 20 ) or (my1 < (plyr.y - 20 ))) then

			-- Draws gun graphic in hand
			love.graphics.draw(pistol.sprite, pistol.GunX, pistol.GunY, player.armrot, 1, 1, plyr.sprite:getWidth() - 40, plyr.sprite:getHeight() - 25)

		elseif (mx1 > (plyr.x - 20) or (mx1 < (plyr.x + 20 ))) or (my1 > (plyr.y - 20 ) or (my1 < (plyr.y + 20 ))) then
			
			-- Draws gun graphic in hand
			love.graphics.draw(pistol.sprite, pistol.GunX, pistol.GunY, plyr.rotation, 1, 1, plyr.sprite:getWidth() - 40, plyr.sprite:getHeight() - 25)
		
		end
	end
end

return gun