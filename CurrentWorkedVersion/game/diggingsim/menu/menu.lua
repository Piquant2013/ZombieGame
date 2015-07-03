-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads camera script
local camera = require "libs/hump/camera"

-- Loads game script
selectmodesim = require 'game/diggingsim/game/game'

-- Creates menu as a new gamestate
menusim = Gamestate.new()


function menusim:init()

	------ VARIABLES ------
	-- Play Button Y & X
	self.playbtny = 254
	self.playbtnx = 582

	-- Quit Button Y & X
	self.quitbtny = 284
	self.quitbtnx = 550
	
	-- Button Selecter Y & X
	self.arrowy = (self.playbtny)
	self.arrowx = 370

	-- Menus state
	self.playstate = false
	self.optstate = false
	self.exitstate = false

	-- Camera
	self.Cam = camera(640, 39, 2.5)
	------ VARIABLES ------

	------ IMAGES ------
	self.sprite = love.graphics.newImage("game/diggingsim/images/game/player.png")
	self.shovel = love.graphics.newImage("game/diggingsim/images/game/shovel.png")
	self.map = love.graphics.newImage("game/diggingsim/images/game/map.png")
	self.sky = love.graphics.newImage("game/diggingsim/images/game/sky.png")
	self.dug = love.graphics.newImage("game/diggingsim/images/game/dug.png")
	self.flag1 = love.graphics.newImage("game/diggingsim/images/game/flag1.png")
	self.flag2 = love.graphics.newImage("game/diggingsim/images/game/flag2.png")
	self.arrow = love.graphics.newImage("game/diggingsim/images/menu/arrow.png")
	------ IMAGES ------

	------ AUDIO ------
	self.entersound = love.audio.newSource("game/diggingsim/audio/buttons/enter.ogg")
	self.backsound = love.audio.newSource("game/diggingsim/audio/buttons/back.ogg")
	self.select1 = love.audio.newSource("game/diggingsim/audio/buttons/select.ogg")
	self.select2 = love.audio.newSource("game/diggingsim/audio/buttons/select.ogg")
	self.select3 = love.audio.newSource("game/diggingsim/audio/buttons/select.ogg")
	------ AUDIO ------
end

function menusim:update(dt)
	
	-- CAMERA --
	-- set up camera
	dx,dy = (640) - self.Cam.x, (39) - self.Cam.y
	mx1,my1 = self.Cam:mousepos()
	self.Cam:move(dx/2, dy/2)
	self.Cam:zoomTo(12)
	-- CAMERA --

	-- MENU STATES --
	-- plays menu state
	if self.arrowy == self.playbtny then
		self.arrowx = love.graphics.getWidth()/2 + 10
		self.playstate = true
		self.optstate = false
		self.exitstate = false
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
	end

	-- Quits menu state
	if self.arrowy == self.quitbtny then
		self.arrowx = love.graphics.getWidth()/2 + 10
		self.optstate = false
		self.playstate = false
		self.exitstate = true
		love.audio.stop(self.select1)
		love.audio.stop(self.select3)
	end
	-- MENU STATES --

	-- Make sure the arrow doesnt go past play or quit
	if self.arrowy > self.quitbtny then
		self.arrowy = self.quitbtny
	elseif self.arrowy < self.playbtny then
		self.arrowy = self.playbtny
	end
end

function menusim:keypressed(key)

	-- SELECT BUTTONS --
	-- Move arrow up through menu states
	if key == "up" or key == "w" then
		love.audio.play(self.select1)
		love.audio.play(self.select2)
		love.audio.play(self.select3)
		self.arrowy = self.arrowy - 30
	end

	-- Move arrow down through menu states
	if key == "down" or key == "s" then
		love.audio.play(self.select1)
		love.audio.play(self.select2)
		love.audio.play(self.select3)
		self.arrowy = self.arrowy + 30
	end
	-- SELECT BUTTONS --

	-- ACTIVATE BUTTONS --
	-- Launch game
	if key == "return" and self.playstate == true or key == " " and self.playstate == true then
		love.audio.play(self.entersound)
		Gamestate.push(selectmodesim)

		-- RESET GAME --
		kid.x = 640
		kid.y = 39
		selectmodesim.shovely = kid.y + 4
		selectmodesim.shipx = -6000
		selectmodesim.shipy = kid.y
		selectmodesim.talktimer = 0
		selectmodesim.speak = false
		selectmodesim.achtimer = 0
		selectmodesim.ach = false
		selectmodesim.playerdeath = false
		selectmodesim.wingame = false
		selectmodesim.reddot = 158
		selectmodesim.paused = false
		selectmodesim.resume = true
		selectmodesim.Cam = camera(kid.x, kid.y, 2.5)
		-- RESET GAME --
	end

	-- Quit game
	if key == "return" and self.exitstate == true or key == " " and self.exitstate == true then
		setendless = true
		gamereset = true
		game.endless = false
		game.stuck = false
		paused = false
		welcomescreen = true
		Gamestate.switch(start)
		love.audio.play(start.music)
		start.music:setLooping(true)
		love.audio.stop(game.music1)
		love.audio.stop(game.music2)
		love.audio.stop(startsim.music)
	end
	-- ACTIVATE BUTTONS --

	-- Go back to the startsim screen
	if key == "escape" then
		Gamestate.switch(startsim)
		startsim.movelogo = 100
		love.audio.play(self.backsound)
	end
end

function menusim:draw()
	
	------ FILTERS ------
	startsim.gamelogo:setFilter( 'nearest', 'nearest' )
	startsim.font2:setFilter( 'nearest', 'nearest' )
	self.map:setFilter( 'nearest', 'nearest' )
	self.sprite:setFilter( 'nearest', 'nearest' )
	self.shovel:setFilter( 'nearest', 'nearest' )
	self.flag1:setFilter( 'nearest', 'nearest' )
	self.flag2:setFilter( 'nearest', 'nearest' )
	self.sky:setFilter( 'nearest', 'nearest' )
	self.arrow:setFilter( 'nearest', 'nearest' )
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
	love.graphics.draw(startsim.gamelogo, (love.graphics.getWidth()/2 - startsim.gamelogo:getWidth()/2), 130)
	------ IMAGES ------

	------ SHAPES ------
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(self.arrow, self.arrowx, self.arrowy, 0, 10)
	------ SHAPES ------

	------ TEXT ------
	love.graphics.setFont( startsim.font2 )
	love.graphics.print('START NEW GAME', (love.graphics.getWidth()/2 + 100 ), self.playbtny)
	love.graphics.print('QUIT', (love.graphics.getWidth()/2  + 100 ), self.quitbtny)
	love.graphics.setColor(255, 255, 255, 255)
	------ TEXT ------
end

return menusim