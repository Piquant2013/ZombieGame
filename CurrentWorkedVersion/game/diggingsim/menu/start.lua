-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads camera script
local camera = require "libs/hump/camera"

-- Loads menu script
menusim = require 'game/diggingsim/menu/menu'

-- Creates start as a new gamestate
startsim = Gamestate.new()


function startsim:init()

	------ VARIABLES ------
	self.textflash = 255
	self.flashtimer = 0
	self.Cam = camera(640, 39, 2.5)
	------ VARIABLES ------

	------ IMAGES ------
	self.gamelogo = love.graphics.newImage("game/diggingsim/images/menu/gamelogo.png")
	self.sprite = love.graphics.newImage("game/diggingsim/images/game/player.png")
	self.shovel = love.graphics.newImage("game/diggingsim/images/game/shovel.png")
	self.map = love.graphics.newImage("game/diggingsim/images/game/map.png")
	self.sky = love.graphics.newImage("game/diggingsim/images/game/sky.png")
	self.dug = love.graphics.newImage("game/diggingsim/images/game/dug.png")
	self.flag1 = love.graphics.newImage("game/diggingsim/images/game/flag1.png")
	self.flag2 = love.graphics.newImage("game/diggingsim/images/game/flag2.png")
	------ IMAGES ------

	------ FONTS ------
	self.font1 = love.graphics.newFont("fonts/xen3.ttf", 20)
	self.font2 = love.graphics.newFont("fonts/xen3.ttf", 30)
	self.font3 = love.graphics.newFont("fonts/xen3.ttf", 70)
	------ FONTS ------
	
	------ AUDIO ------
	self.entersound = love.audio.newSource("game/diggingsim/audio/buttons/enter.ogg")
	self.music = love.audio.newSource("game/diggingsim/audio/music/menu.ogg")
	------ AUDIO ------
end

function startsim:update(dt)
	
	-- CAMERA --
	-- set up camera
	dx,dy = (640) - self.Cam.x, (39) - self.Cam.y
	mx1,my1 = self.Cam:mousepos()
	self.Cam:move(dx/2, dy/2)
	self.Cam:zoomTo(12)
	-- CAMERA --

	--- TEXT FLASH ---
	-- start flash timer
	self.flashtimer = self.flashtimer + dt
	
	-- flashing times
	if self.flashtimer > 4 then
		self.textflash = 0
	end

	if self.flashtimer > 4.5 then
		self.textflash = 255
		self.flashtimer = 0
	end
	--- TEXT FLASH ---
end

function startsim:keypressed(key)

	-- move onto the menu script
	if key == " " or key == "return" then
		Gamestate.switch(menusim)
		love.audio.play(self.entersound)
		paused = false
	end
end

function startsim:draw()

	------ FILTERS ------
	self.gamelogo:setFilter( 'nearest', 'nearest' )
	self.font2:setFilter( 'nearest', 'nearest' )
	self.map:setFilter( 'nearest', 'nearest' )
	self.sprite:setFilter( 'nearest', 'nearest' )
	self.shovel:setFilter( 'nearest', 'nearest' )
	self.flag1:setFilter( 'nearest', 'nearest' )
	self.flag2:setFilter( 'nearest', 'nearest' )
	self.sky:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	------ IMAGES ------
	-- CAM --
	self.Cam:attach()
	love.graphics.draw(self.map, (love.graphics.getWidth()/2 - self.map:getWidth()/2), 0)
	love.graphics.draw(self.dug, 640 - 9, 39- 589)
	love.graphics.draw(self.sky, (love.graphics.getWidth()/2 - self.sky:getWidth()/2), 0)
	love.graphics.draw(self.sprite, 640, 39)
	love.graphics.draw(self.shovel, 640 - 2, 39+ 4)
	self.Cam:detach()
	-- CAM --

	-- Title
	love.graphics.draw(self.gamelogo, (love.graphics.getWidth()/2 - self.gamelogo:getWidth()/2), 130)
	------ IMAGES ------

	------ TEXT ------
	love.graphics.setFont( self.font2 )
	love.graphics.setColor(255, 255, 255, self.textflash)
	love.graphics.print('PUSH START BUTTON', (love.graphics.getWidth( )/2 + 30), 265)
	love.graphics.setColor(255, 255, 255, 255)
	------ TEXT ------
end

return startsim