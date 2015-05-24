-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads game script
selectmode = require 'game/menus/selectmode'

-- Loads options script
options = require 'menu/options'

-- Creates menu as a new gamestate
menu = Gamestate.new()


function menu:init()

	------ VARIABLES ------
	-- Play Button Y & X
	self.playbtny = 442
	self.playbtnx = 582
	
	-- Option Button Y & X
	self.optbtny = 492
	self.optbtnx = 550

	-- Quit Button Y & X
	self.quitbtny = 542
	self.quitbtnx = 592
	
	-- Button Selecter Y & X
	self.arrowy = (self.playbtny)
	self.arrowx = 480

	-- Menus state
	self.playstate = false
	self.optstate = false
	self.exitstate = false
	------ VARIABLES ------

	------ AUDIO ------
	self.entersound = love.audio.newSource("audio/buttons/enter.ogg")
	self.select1 = love.audio.newSource("audio/buttons/select.ogg")
	self.select2 = love.audio.newSource("audio/buttons/select.ogg")
	self.select3 = love.audio.newSource("audio/buttons/select.ogg")
	------ AUDIO ------
end

function menu:update(dt)
	
	--- MOVE LOGO --- 
	start.movelogo = start.movelogo - dt - 4

	if start.movelogo < 100 then
		start.movelogo = 100
	end
	--- MOVE LOGO ---

	-- MENU STATES --
	-- plays menu state
	if self.arrowy == self.playbtny then
		self.arrowx = love.graphics.getWidth()/2 - 540/2
		self.playstate = true
		self.optstate = false
		self.exitstate = false
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
	end

	-- Options menu state
	if self.arrowy < self.quitbtny and self.arrowy > self.playbtny then
		self.arrowx = love.graphics.getWidth()/2 - 360/2
		self.arrowy = self.optbtny
		self.exitstate = false
		self.playstate = false
		self.optstate = true
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
	end

	-- Quits menu state
	if self.arrowy == self.quitbtny then
		self.arrowx = love.graphics.getWidth()/2 - 240/2
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

function menu:keypressed(key)

	-- SELECT BUTTONS --
	-- Move arrow up through menu states
	if key == "up" or key == "w" then
		love.audio.play(self.select1)
		love.audio.play(self.select2)
		love.audio.play(self.select3)
		self.arrowy = self.arrowy - 50
	end

	-- Move arrow down through menu states
	if key == "down" or key == "s" then
		love.audio.play(self.select1)
		love.audio.play(self.select2)
		love.audio.play(self.select3)
		self.arrowy = self.arrowy + 50
	end
	-- SELECT BUTTONS --

	-- ACTIVATE BUTTONS --
	-- Launch game
	if key == "return" and self.playstate == true or key == " " and self.playstate == true then
		love.audio.play(self.entersound)
		Gamestate.push(selectmode)
	end

	-- Quit game
	if key == "return" and self.exitstate == true or key == " " and self.exitstate == true then
		love.event.quit()
	end

	-- Go to options menu
	if key == "return" and self.optstate == true or key == " " and self.optstate == true then
		love.audio.play(self.entersound)
		Gamestate.push(options)
	end
	-- ACTIVATE BUTTONS --

	-- Go back to the start screen
	if key == "escape" then
		Gamestate.switch(start)
		start.movelogo = 100
		love.audio.play(self.entersound)
	end
end

function menu:draw()
	
	------ FILTERS ------
	start.gamelogo:setFilter( 'nearest', 'nearest' )
	start.bg:setFilter( 'nearest', 'nearest' )
	start.font2:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	------ IMAGES ------
	love.graphics.draw(start.bg, -10, 0, 0, 1)
	love.graphics.draw(start.gamelogo, (love.graphics.getWidth()/2 - start.gamelogo:getWidth()/2), start.movelogo)
	------ IMAGES ------

	------ SHAPES ------
	love.graphics.setColor(160, 47, 0)
	love.graphics.rectangle("fill", self.arrowx, self.arrowy - 8, 28, 28 )
	------ SHAPES ------

	------ TEXT ------
	love.graphics.setFont( start.font2 )
	love.graphics.print('START NEW GAME', (love.graphics.getWidth()/2 - start.font2:getWidth( "START NEW GAME" )/2), self.playbtny)
	love.graphics.print('QUIT', (love.graphics.getWidth()/2 - start.font2:getWidth( "QUIT" )/2), self.quitbtny)
	love.graphics.print('SETTINGS', (love.graphics.getWidth()/2 - start.font2:getWidth( "SETTINGS" )/2), self.optbtny)
	love.graphics.setColor(255, 255, 255, 255)
	------ TEXT ------
end

return menu