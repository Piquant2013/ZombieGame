-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads gamestate script
local endless = require 'game/gamemodes/endless'

-- Creates pause as a new gamestate
selectmode = Gamestate.new()


function selectmode:init()
  
  	------ VARIABLES ------
	-- survival Button Y & X 
	self.survivalbtny = 250
	self.survivalbtnx = 548

	-- Arcade menu Button Y & X  
	self.arcadebtny = 350
	self.arcadebtnx = 512

	-- Endless menu Button Y & X  
	self.endlessbtny = 450
	self.endlessbtnx = 476
 
	-- Button Selecter Y & X 
	self.arrowy = (self.survivalbtny)
	self.arrowx = 450

	-- Survival Selecter Y & X
	self.survivalarrowy = 232
	self.survivalarrowx = 665
	
	-- Arcade Selecter Y & X
	self.arcadearrowy = 347
	self.arcadearrowx = 665

	-- Select mode menu state  
	self.survivalstate = false
	self.arcadestate = false
	self.endlessstate = false

	-- If in area
	self.survival = false
	self.arcade = false
	------ VARIABLES ------
	
	------ IMAGES ------
	self.screenshot1 = love.graphics.newImage("images/menu/screenshot1.png")
	self.screenshot2 = love.graphics.newImage("images/menu/screenshot2.png")
	------ IMAGES ------

	------ AUDIO ------
	self.entersound1 = love.audio.newSource("audio/buttons/enter.ogg")
	self.entersound1a = love.audio.newSource("audio/buttons/enter.ogg")
	self.entersound2 = love.audio.newSource("audio/buttons/enter.ogg")
	self.entersound2a = love.audio.newSource("audio/buttons/enter.ogg")
	self.select1 = love.audio.newSource("audio/buttons/select.ogg")
	self.select2 = love.audio.newSource("audio/buttons/select.ogg")
	self.select3 = love.audio.newSource("audio/buttons/select.ogg")
	------ AUDIO ------
end

function selectmode:update(dt)

	-- Stop arrow from moving and sounds when in survival or arcade screens
	if self.survival == true then
		self.arrowy = 250
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
	end

	if self.arcade == true then
		self.arrowy = 350
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
	end

	-- SELECT MODE MENU STATES -- 
	-- survival pause menu state
	if self.arrowy == self.survivalbtny then
		self.arrowx = love.graphics.getWidth()/2 - 510 /2
		self.survivalstate = true
		self.endlessstate = false
		self.arcadestate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
	end

	-- Arcade pause menu state
	if self.arrowy < self.endlessbtny and self.arrowy > self.survivalbtny then
		self.arrowx = love.graphics.getWidth()/2 - 455 /2
		self.arrowy = self.arcadebtny
		self.survivalstate = false
		self.endlessstate = false
		self.arcadestate = true
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
	end

	-- Endless pause pause menu state
	if self.arrowy == self.endlessbtny then
		self.arrowx = love.graphics.getWidth()/2 - 490 /2
		self.survivalstate = false
		self.endlessstate = true
		self.arcadestate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select3)
	end
	-- SELECT MODE MENU STATES --  

  	-- Make sure the arrow doesnt go past survival or endless
	if self.arrowy > self.endlessbtny then
		self.arrowy = self.endlessbtny
	elseif self.arrowy < self.survivalbtny then
		self.arrowy = self.survivalbtny
	end

	-- Pushes survival arrow back if it trys to pass off else turn survival true or false
	if self.survivalarrowx > self.survivalbtnx then
		self.survivalarrowx = self.survivalbtnx - 118
	elseif self.survivalarrowx == self.survivalbtnx - 118 then
		self.survival = false
	elseif self.survivalarrowx == self.survivalbtnx then	
		self.survival = true
	end

	-- Pushes arcade arrow back if it trys to pass off else turn arcade true or false
	if self.arcadearrowx > self.arcadebtnx then
		self.arcadearrowx = self.arcadebtnx - 118
	elseif self.arcadearrowx == self.arcadebtnx - 118 then
		self.arcade = false
	elseif self.arcadearrowx == self.arcadebtnx then	
		self.arcade = true
	end
end

function selectmode:keypressed(key)

	-- SELECT BUTTONS --
	-- Move arrow up through select mode menu states
	if key == "up" or key == "w" then
		love.audio.play(self.select1)
		love.audio.play(self.select2)
		love.audio.play(self.select3)
		self.arrowy = self.arrowy - 100
	end

	-- Move arrow up through select mode menu states
	if key == "down" or key == "s" then
		love.audio.play(self.select1)
		love.audio.play(self.select2)
		love.audio.play(self.select3)
		self.arrowy = self.arrowy + 100
	end
	-- SELECT BUTTONS --
 
 	-- ACTIVATE BUTTONS --
	-- Go back and forth between surival
	if key == "return" and self.survivalstate == true or key == " " and self.survivalstate == true or key == 'escape' and self.survival == true then
		self.survivalarrowx = self.survivalarrowx + 118
	end

	-- Go back and forth between arcade
	if key == "return" and self.arcadestate == true or key == " " and self.arcadestate == true or key == 'escape' and self.arcade == true then
		self.arcadearrowx = self.arcadearrowx + 118
	end
  
  	-- Go to the endless game mode
	if key == "return" and self.endlessstate == true or key == " " and self.endlessstate == true then
		Gamestate.switch(endless)
		love.audio.play(self.entersound1)
	end

	-- Plays audio for survival buttons
	if key == "return" and self.survival == true or key == " " and self.survival == true or key == 'escape' and self.survival == true then
		love.audio.play(self.entersound1)
		love.audio.stop(self.entersound1a)
	elseif key == "return" and self.survival == false or key == " " and self.survival == false or key == 'escape' and self.survival == false then
		love.audio.play(self.entersound1a)
		love.audio.stop(self.entersound1)
	end 

	-- Plays audio for arcade buttons
	if key == "return" and self.arcade == true or key == " " and self.arcade == true or key == 'escape' and self.arcade == true then
		love.audio.play(self.entersound2)
		love.audio.stop(self.entersound2a)
	elseif key == "return" and self.arcade == false or key == " " and self.arcade == false or key == 'escape' and self.arcade == false then
		love.audio.play(self.entersound2a)
		love.audio.stop(self.entersound2)
	end 
	-- ACTIVATE BUTTONS --

	-- Go back to main menu
	if key == 'escape' and self.survival == false and self.arcade == false then
		Gamestate.pop()
	end
end

function selectmode:draw()
	
	------ FILTERS ------
	start.bg:setFilter( 'nearest', 'nearest' )
	start.font:setFilter( 'nearest', 'nearest' )
	self.screenshot1:setFilter( 'nearest', 'nearest' )
	self.screenshot2:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	------ IMAGES ------
	love.graphics.draw(start.bg, 0, -1000, 0, 3)
	
	-- Draws screenshot if in survival
	if self.survival == true then
		love.graphics.draw(self.screenshot2, 0, 0, 0, 0.51)
	end

	-- Draws screenshot if in arcade
	if self.arcade == true then
		love.graphics.draw(self.screenshot1, 0, 0, 0, 0.51)
	end
	------ IMAGES ------

	------ SHAPES ------
	-- Only draw arrow if not in survival or arcade
	if self.survival == false and self.arcade == false then
		love.graphics.setColor(160, 47, 0)
		love.graphics.rectangle("fill", self.arrowx, self.arrowy - 8, 28, 28 )
	end
	------ SHAPES ------

	------ TEXT ------
	-- Only draw buttons if not in survival or arcade
	if self.survival == false and self.arcade == false then
		love.graphics.setFont( start.font )
		love.graphics.setColor(160, 47, 0, 100)
		love.graphics.print('SURVIVAL MODE', (love.graphics.getWidth()/2 - start.font:getWidth( "SURVIVAL MODE" )/2), self.survivalbtny)
		love.graphics.print('(COMING SOON)', (love.graphics.getWidth()/2 - start.font:getWidth( "(COMING SOON)" )/2), self.survivalbtny + 35)
		love.graphics.print('ARCADE MODE', (love.graphics.getWidth()/2 - start.font:getWidth( "ARCADE MODE" )/2), self.arcadebtny)
		love.graphics.print('(COMING SOON)', (love.graphics.getWidth()/2 - start.font:getWidth( "(COMING SOON)" )/2), self.arcadebtny + 35)
		love.graphics.setColor(160, 47, 0)
		love.graphics.print('ENDLESS MODE', (love.graphics.getWidth()/2 - start.font:getWidth( "ENDLESS MODE" )/2), self.endlessbtny)
	end
	
	-- Draw text if in survival
	if self.survival == true then
		love.graphics.setFont( start.font )
		love.graphics.setColor(160, 47, 0)
		love.graphics.print('SURVIVAL MODE (COMING SOON)', (love.graphics.getWidth()/2 - start.font:getWidth( "SURVIVAL MODE (COMING SOON)" )/2), 500)
	end

	-- Draw text if in arcade
	if self.arcade == true then
		love.graphics.setFont( start.font )
		love.graphics.setColor(160, 47, 0)
		love.graphics.print('ARCADE MODE (COMING SOON)', (love.graphics.getWidth()/2 - start.font:getWidth( "ARCADE MODE (COMING SOON)" )/2), 500)
	end

	love.graphics.setColor(255, 255, 255)
	------ TEXT ------
end

return selectmode