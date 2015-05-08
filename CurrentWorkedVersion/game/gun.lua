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
	self.ShotTime = 0
	self.ShotTimePlus = 0
	self.Bullets = {}
	self.GunShot = false
	self.GunShot1 = false
	self.Shot = love.graphics.newImage("images/shot.png")
	
	-- Gun
	pistol.GunY = plyr.y
	pistol.GunX = plyr.x
	pistol.HaveGun = false
	pistol.yes = false
	pistol.itemx = 750
	pistol.itemy = 380
	pistol.bb = Collider:addRectangle(pistol.itemx, pistol.itemy,24,24)
	pistol.sprite = love.graphics.newImage("images/gun.png")
	pistol.invsprite = love.graphics.newImage("images/gunitem.png")
	pistol.itemsprite = love.graphics.newImage("images/gunitem.png")
	
	------ AUDIO ------
	self.GunSound = love.audio.newSource("audio/gun.ogg")
	self.GunSound1 = love.audio.newSource("audio/gun.ogg")
	------ AUDIO ------

	self.InteractFont = love.graphics.newFont("fonts/xen3.ttf", 10)
end

function gun:shooting(mx, my, button)

	if button == "l" and self.ShotTime <= 0 and sship.entered == false and pistol.HaveGun == true then
		
		-- The bullet direction
		self.Direction = math.atan2(my1 - pistol.GunY, mx1 - pistol.GunX)
		
		-- shot bullet when left click
		bullet = {}

		bullet.x = pistol.GunX
		bullet.y = pistol.GunY
		bullet.Dir = self.Direction
		bullet.Speed = 400
		bullet.bb = Collider:addRectangle(bullet.x, bullet.y, 12, 1)

		table.insert(self.Bullets, bullet)
		
		-- Reset shot timer
		self.ShotTime = self.ShotTimePlus
	end

	-- Gun Sounds
	if button == "l" and self.GunShot == true and game.Welcome == false and game.GameOver == false and sship.entered == false and pistol.HaveGun == true then
		love.audio.play(self.GunSound)
		love.audio.stop(self.GunSound1)
		self.GunShot1 = false
	end

	-- Gun Sounds
	if button == "l" and self.GunShot1 == false and game.Welcome == false and game.GameOver == false and sship.entered == false and pistol.HaveGun == true then
		love.audio.play(self.GunSound1)
		love.audio.stop(self.GunSound)
		self.GunShot = true
	end
end

function gun:update(dt)

	-- Shot time
	self.ShotTime = math.max(0, self.ShotTime - dt)
	 	
	for i, o in ipairs(self.Bullets) do

		-- Set bullet speed, rotation and postion
		o.x = o.x + math.cos(o.Dir) * o.Speed * dt
		o.y = o.y + math.sin(o.Dir) * o.Speed * dt

		if (o.x > (plyr.x + 300) or (o.x < (plyr.x - 300 ))) or (o.y > (plyr.y + 300 ) or (o.y < (plyr.y - 300 ))) then
			
			-- if the bullet goes off screen undraw it and move the bullet hit box (Temporally) to 4000, 4000
			Collider:remove(o.bb)
			table.remove(self.Bullets, i)
		end
	end

	if pistol.HaveGun == true then
		
		-- gun follows the player
		pistol.GunX = plyr.x
    	pistol.GunY = plyr.y
    	
    	-- gun item follows the player
    	pistol.itemx = plyr.x
    	pistol.itemy = plyr.y
    end

    if pistol.HaveGun == true and Paused == false then
		
		-- If you have the gun then change the cursor to the crosshair
		love.mouse.setCursor(crosshair)
	elseif pistol.HaveGun == false and Paused == false then
		
		-- If you dont have the gun then set the cursor to the pointer
		love.mouse.setCursor(cursor)
	end
end

function gun:bulletdraw()

	------ FILTERS ------
	self.Shot:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	for i, o in ipairs(self.Bullets) do
		
		-- Gun bullet graphic
		love.graphics.draw(self.Shot, o.x, o.y, o.Dir, 1, 1, plyr.sprite:getWidth() - 26, plyr.sprite:getHeight() - 25) --self.Shot:getWidth()/2, self.Shot:getHeight()/2) 

		-- Move and rotate bullet hitbox
		o.bb:moveTo(o.x + 6 * math.sin(o.Dir), o.y - 6 * math.cos(o.Dir))
		o.bb:setRotation(o.Dir)
	end
end

function gun:draw()

	------ FILTERS ------
	pistol.sprite:setFilter( 'nearest', 'nearest' )
	pistol.itemsprite:setFilter( 'nearest', 'nearest' )
	pistol.invsprite:setFilter( 'nearest', 'nearest' )
	self.InteractFont:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	if pistol.HaveGun == true and sship.entered == false then
			
		-- Draws gun graphic in hand
		love.graphics.draw(pistol.sprite, pistol.GunX, pistol.GunY, plyr.rotation, 1, 1, plyr.sprite:getWidth() - 40, plyr.sprite:getHeight() - 25)
	end

	if pistol.HaveGun == true then

		-- Moves the gun item hit box with the gun grpahic
		pistol.bb:moveTo(pistol.itemx, pistol.itemy)
	end

	if pistol.yes == true and pistol.HaveGun == false then 
		
		-- Prints interact key for if you can pick up the gun
		love.graphics.setFont( self.InteractFont )
		love.graphics.print('[ e ]', pistol.itemx + 10, pistol.itemy + 10)
	end

	if pistol.HaveGun == false then
		
		-- Draws the gun item grpahic for if the player doesnt hold the gun
		love.graphics.draw(pistol.itemsprite, pistol.itemx, pistol.itemy, 0, 1, 1, pistol.itemsprite:getWidth()/2, pistol.itemsprite:getHeight()/2)
		
		-- Moves the gun item hit box with the gun grpahic
		pistol.bb:moveTo(pistol.itemx, pistol.itemy)
	end
end

function gun:hotbaritem()

	if pistol.HaveGun == true then
		
		-- Put the gun item grpahic in the hot bar if you have obtained it
		love.graphics.draw(pistol.invsprite, love.graphics.getWidth()/2 - 348 - 2/2, love.graphics.getHeight() - 28, 0, 8, 8, pistol.invsprite:getWidth()/2, pistol.invsprite:getHeight()/2)
	end
end

return gun