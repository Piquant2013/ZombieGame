-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates pause as a new gamestate
pause = Gamestate.new()


function pause:init()
  
  	------ VARIABLES ------
	-- Resume Button Y & X 
	self.resumebtny = 300
	self.resumebtnx = 548

	-- Main menu Button Y & X  
	self.optionsbtny = 350
	self.optionsbtnx = 512

	-- Main menu Button Y & X  
	self.mainmenubtny = 400
	self.mainmenubtnx = 476
 
	-- Button Selecter Y & X 
	self.arrowy = (self.resumebtny)
	self.arrowx = 450

	-- Pause menu state  
	self.resumestate = false
	self.optionsstate = false
	self.mainmenustate = false
	------ VARIABLES ------

	------ AUDIO ------
	self.entersound = love.audio.newSource("audio/buttons/enter.ogg")
	self.select1 = love.audio.newSource("audio/buttons/select.ogg")
	self.select2 = love.audio.newSource("audio/buttons/select.ogg")
	self.select3 = love.audio.newSource("audio/buttons/select.ogg")
	------ AUDIO ------
end

function pause:update(dt)

	-- Pause game music and set cursor
	if resume == false then
		game.music1:setVolume(0.2)
		love.mouse.setCursor(cursor)
	end

	-- Switch back to the game script
	if resume == true then
		Gamestate.pop()
		paused = false
		love.mouse.setCursor(crosshair)
		game.music1:setVolume(1.0)
	end 

	-- PAUSE MENU STATES -- 
	-- Resume pause menu state
	if self.arrowy == self.resumebtny then
		self.arrowx = love.graphics.getWidth()/2 - 320 /2
		self.resumestate = true
		self.mainmenustate = false
		self.optionsstate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
	end

	-- Options pause menu state
	if self.arrowy < self.mainmenubtny and self.arrowy > self.resumebtny then
		self.arrowx = love.graphics.getWidth()/2 - 380 /2
		self.arrowy = self.optionsbtny
		self.resumestate = false
		self.mainmenustate = false
		self.optionsstate = true
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
	end

	-- Main menu pause menu state
	if self.arrowy == self.mainmenubtny then
		self.arrowx = love.graphics.getWidth()/2 - 260 /2
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

function pause:keypressed(key)

	-- SELECT BUTTONS --
	-- Move arrow up through pause menu states
	if key == "up" or key == "w" then
		love.audio.play(self.select1)
		love.audio.play(self.select2)
		love.audio.play(self.select3)
		self.arrowy = self.arrowy - 50
	end

	-- Move arrow up through pause menu states
	if key == "down" or key == "s" then
		love.audio.play(self.select1)
		love.audio.play(self.select2)
		love.audio.play(self.select3)
		self.arrowy = self.arrowy + 50
	end
	-- SELECT BUTTONS --
 
 	-- ACTIVATE BUTTONS --
	-- Resume the game
	if key == "return" and self.resumestate == true or key == " " and self.resumestate == true then
		love.audio.play(self.entersound)
		resume = true
	end

	-- Go to options menu
	if key == "return" and self.optionsstate == true or key == " " and self.optionsstate == true then
		love.audio.play(self.entersound)
		Gamestate.push(options)
	end
  
  	-- Go to the main menu
	if key == "return" and self.mainmenustate == true or key == " " and self.mainmenustate == true then
		love.audio.play(self.entersound)
		setendless = true
		gamereset = true
		game.endless = false
		game.stuck = false
		paused = false
		welcomescreen = true
		Gamestate.switch(menu)
		love.audio.play(start.music)
		start.music:setLooping(true)
		love.audio.stop(game.music1)
	end
	-- ACTIVATE BUTTONS --

	-- Resume game
	if key == 'escape' then
		resume = true
	end
end

function pause:draw()
	
	------ FILTERS ------
	start.bg:setFilter( 'nearest', 'nearest' )
	start.font2:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	------ IMAGES ------
	love.graphics.draw(start.bg, 0, -1000, 0, 3)
	------ IMAGES ------

	------ SHAPES ------
	love.graphics.setColor(160, 47, 0)
	love.graphics.rectangle("fill", self.arrowx, self.arrowy - 8, 28, 28 )
	------ SHAPES ------

	------ TEXT ------
	love.graphics.setFont( start.font2 )
	love.graphics.print('RESUME', (love.graphics.getWidth()/2 - start.font2:getWidth( "RESUME" )/2), self.resumebtny)
	love.graphics.print('SETTINGS', (love.graphics.getWidth()/2 - start.font2:getWidth( "SETTINGS" )/2), self.optionsbtny)
	love.graphics.print('MENU', (love.graphics.getWidth()/2 - start.font2:getWidth( "MENU" )/2), self.mainmenubtny)
	love.graphics.setColor(255, 255, 255)
	------ TEXT ------
end

return pause