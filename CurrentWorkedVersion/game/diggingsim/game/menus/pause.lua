-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates pause as a new gamestate
pausesim = Gamestate.new()


function pausesim:init()
  
  	------ VARIABLES ------
	-- Resume Button Y & X 
	self.resumebtny = 300
	self.resumebtnx = 548

	-- Main menu Button Y & X  
	self.mainmenubtny = 330
	self.mainmenubtnx = 512
 
	-- Button Selecter Y & X 
	self.arrowy = (self.resumebtny)
	self.arrowx = 480

	-- Pause menu state  
	self.resumestate = false
	self.mainmenustate = false
	------ VARIABLES ------

	------ AUDIO ------
	self.entersound = love.audio.newSource("game/diggingsim/audio/buttons/enter.ogg")
	self.select1 = love.audio.newSource("game/diggingsim/audio/buttons/select.ogg")
	self.select2 = love.audio.newSource("game/diggingsim/audio/buttons/select.ogg")
	self.select3 = love.audio.newSource("game/diggingsim/audio/buttons/select.ogg")
	------ AUDIO ------
end

function pausesim:update(dt)

	-- Switch back to the game script
	if gamesim.resume == true then
		Gamestate.pop()
		gamesim.paused = false
	end 

	-- PAUSE MENU STATES -- 
	-- Resume pause menu state
	if self.arrowy == self.resumebtny then
		self.arrowx = love.graphics.getWidth()/2 - 160
		self.resumestate = true
		self.mainmenustate = false
		self.optionsstate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
	end

	-- Main menu pause menu state
	if self.arrowy == self.mainmenubtny then
		self.arrowx = love.graphics.getWidth()/2 - 160
		self.resumestate = false
		self.mainmenustate = true
		self.optionsstate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select3)
	end
	-- PAUSE MENU STATES -- 

  	-- Make sure the arrow doesnt go past resume or main menu
	if self.arrowy > self.mainmenubtny then
		self.arrowy = self.mainmenubtny
	elseif self.arrowy < self.resumebtny then
		self.arrowy = self.resumebtny
	end
end

function pausesim:keypressed(key)

	-- SELECT BUTTONS --
	-- Move arrow up through pause menu states
	if key == "up" or key == "w" then
		love.audio.play(self.select1)
		love.audio.play(self.select2)
		love.audio.play(self.select3)
		self.arrowy = self.arrowy - 30
	end

	-- Move arrow up through pause menu states
	if key == "down" or key == "s" then
		love.audio.play(self.select1)
		love.audio.play(self.select2)
		love.audio.play(self.select3)
		self.arrowy = self.arrowy + 30
	end
	-- SELECT BUTTONS --
 
 	-- ACTIVATE BUTTONS --
	-- Resume the game
	if key == "return" and self.resumestate == true or key == " " and self.resumestate == true then
		love.audio.play(self.entersound)
		gamesim.resume = true
	end
  
  	-- Go to the main menu
	if key == "return" and self.mainmenustate == true or key == " " and self.mainmenustate == true then
		love.audio.play(self.entersound)
		gamesim.paused = false
		Gamestate.switch(menusim)
	end
	-- ACTIVATE BUTTONS --

	-- Resume game
	if key == 'escape' then
		gamesim.resume = true
	end
end

function pausesim:draw()
	
	------ FILTERS ------
	startsim.font2:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	------ SHAPES ------
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(menusim.arrow, self.arrowx, self.arrowy, 0, 10)
	------ SHAPES ------

	------ TEXT ------
	love.graphics.setFont( startsim.font2 )
	love.graphics.print('RESUME', (love.graphics.getWidth()/2 - startsim.font2:getWidth( "RESUME" )/2), self.resumebtny)
	love.graphics.print('MENU', (love.graphics.getWidth()/2 - startsim.font2:getWidth( "MENU" )/2), self.mainmenubtny)
	love.graphics.setColor(255, 255, 255)
	------ TEXT ------
end

return pausesim