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
	self.playbtny = 100
	self.playbtnx = 582
	
	-- Option Button Y & X
	self.optbtny = 150
	self.optbtnx = 550

	-- Quit Button Y & X
	self.quitbtny = 200
	self.quitbtnx = 592
	
	-- Button Selecter Y & X
	self.arrowy = (self.playbtny)
	self.arrowx = 370

	-- Menus state
	self.playstate = false
	self.optstate = false
	self.exitstate = false

	-- Scale vars for buttons
	self.scaleplay = 1
	self.scaleoptions = 1
	self.scalequit = 1

	-- Flash vars for play button
	self.flashbuttonplay = true
	self.buttonflashplay = 0

	-- Flash vars for options button
	self.flashbuttonoptions = true
	self.buttonflashoptions = 0

	-- Flash vars for quit button
	self.flashbuttonquit = true
	self.buttonflashquit = 0

	-- mouse button state
	self.playstatemouse = false
	self.optstatemouse = false
	self.exitstatemouse = false

	-- Mouse Dectect vars for sound
	self.mouseover = false
	self.mousedetect1 = 0
	self.mousedetect2 = 0
	self.mousedetect3 = 0
	------ VARIABLES ------

	------ AUDIO ------
	self.entersound = love.audio.newSource("audio/buttons/enter.ogg")
	self.backsound = love.audio.newSource("audio/buttons/back.ogg")
	self.select1 = love.audio.newSource("audio/buttons/select.ogg")
	self.select2 = love.audio.newSource("audio/buttons/select.ogg")
	self.select3 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover1 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover2 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover3 = love.audio.newSource("audio/buttons/select.ogg")
	------ AUDIO ------
end

function menu:update(dt)
	
	--- MOVE LOGO --- 
	start.movelogo = start.movelogo + dt + 4

	if start.movelogo > 128 then
		start.movelogo = 128
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
		self.scaleplay = 1.1
		self.scaleoptions = 1
		self.scalequit = 1
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
		self.scaleplay = 1
		self.scaleoptions = 1.1
		self.scalequit = 1
	end

	-- Quits menu state
	if self.arrowy == self.quitbtny then
		self.arrowx = love.graphics.getWidth()/2 - 240/2
		self.optstate = false
		self.playstate = false
		self.exitstate = true
		love.audio.stop(self.select1)
		love.audio.stop(self.select3)
		self.scaleplay = 1
		self.scaleoptions = 1
		self.scalequit = 1.1
	end
	-- MENU STATES --

	-- Make sure the arrow doesnt go past play or quit
	if self.arrowy > self.quitbtny then
		self.arrowy = self.quitbtny
	elseif self.arrowy < self.playbtny then
		self.arrowy = self.playbtny
	end

	-- MOUSE AREAS --
	-- Mouse area of play button
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "START NEW GAME" )/2 + start.font2:getWidth( "START NEW GAME" )) + 50 
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "START NEW GAME" )/2) - 50 
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "START NEW GAME" )/2 + 90) - 10
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "START NEW GAME" )/2 + 90 + start.font2:getHeight( "START NEW GAME" )) + 10 then
		self.playstatemouse = true
		self.optstatemouse = false
		self.exitstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 - 540/2
		self.arrowy = self.playbtny
		self.scaleplay = 1.1
		self.scaleoptions = 1
		self.scalequit = 1
		self.mouseover = true
		self.mousedetect1 = self.mousedetect1 + 1
		self.mousedetect2 = 0
		self.mousedetect3 = 0
	end

	-- Mouse area of options button
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "START NEW GAME" )/2 + start.font2:getWidth( "START NEW GAME" )) + 50 
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "START NEW GAME" )/2) - 50 
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "SETTINGS" )/2 + 140) - 10
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "SETTINGS" )/2 + 140 + start.font2:getHeight( "SETTINGS" )) + 10 then
		self.playstatemouse = false
		self.optstatemouse = true
		self.exitstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 - 360/2
		self.arrowy = self.optbtny
		self.scaleplay = 1
		self.scaleoptions = 1.1
		self.scalequit = 1
		self.mouseover = true
		self.mousedetect1 = 0
		self.mousedetect2 = self.mousedetect2 + 1
		self.mousedetect3 = 0
	end

	-- Mouse area of exit button
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "START NEW GAME" )/2 + start.font2:getWidth( "START NEW GAME" )) + 50 
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "START NEW GAME" )/2) - 50 
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "QUIT" )/2 + 190) - 10
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "QUIT" )/2 + 190 + start.font2:getHeight( "QUIT" )) + 10 then
		self.playstatemouse = false
		self.optstatemouse = false
		self.exitstatemouse = true
		self.arrowx = love.graphics.getWidth()/2 - 240/2
		self.arrowy = self.quitbtny
		self.scaleplay = 1
		self.scaleoptions = 1
		self.scalequit = 1.1
		self.mouseover = true
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = self.mousedetect3 + 1
	end
	-- MOUSE AREAS --

	-- MOUSE OUT OF AREA --
	if love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "START NEW GAME" )/2 + start.font2:getWidth( "START NEW GAME" )) + 50 then
		self.playstatemouse = false
		self.optstatemouse = false
		self.exitstatemouse = false
		self.mouseover = false
	end
	
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "START NEW GAME" )/2) - 50 then
		self.playstatemouse = false
		self.optstatemouse = false
		self.exitstatemouse = false
		self.mouseover = false
	end
	
	if love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "START NEW GAME" )/2 + 90) - 10 then
		self.playstatemouse = false
		self.optstatemouse = false
		self.exitstatemouse = false
		self.mouseover = false
	end

	if love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "QUIT" )/2 + 190 + start.font2:getHeight( "QUIT" )) + 10 then
		self.playstatemouse = false
		self.optstatemouse = false
		self.exitstatemouse = false
		self.mouseover = false
	end
	-- MOUSE OUT OF AREA --

	-- BUTTON FLASHING --
	-- Flashing for the play button
	if self.playstatemouse == true or self.playstate == true then
		
		if self.flashbuttonplay == true then
			self.buttonflashplay = self.buttonflashplay + dt + 2
		elseif self.flashbuttonplay == false then
			self.buttonflashplay = self.buttonflashplay + dt - 2
		end
	
		if self.buttonflashplay > 100 then
			self.flashbuttonplay = false
		elseif self.buttonflashplay < 2 then
			self.flashbuttonplay = true
		end
	
	elseif self.playstatemouse == false or self.playstate == false then
		self.flashbuttonplay = true
		self.buttonflashplay = 0
	end

	-- Flashing for the options button
	if self.optstatemouse == true or self.optstate == true then
		
		if self.flashbuttonoptions == true then
			self.buttonflashoptions = self.buttonflashoptions + dt + 2
		elseif self.flashbuttonoptions == false then
			self.buttonflashoptions = self.buttonflashoptions + dt - 2
		end
	
		if self.buttonflashoptions > 100 then
			self.flashbuttonoptions = false
		elseif self.buttonflashoptions < 2 then
			self.flashbuttonoptions = true
		end
	
	elseif self.optstatemouse == false or self.optstate == false then
		self.flashbuttonoptions = true
		self.buttonflashoptions = 0
	end

	-- Flashing for the exit button
	if self.exitstatemouse == true or self.exitstate == true then
		
		if self.flashbuttonquit == true then
			self.buttonflashquit = self.buttonflashquit + dt + 2
		elseif self.flashbuttonquit == false then
			self.buttonflashquit = self.buttonflashquit + dt - 2
		end
	
		if self.buttonflashquit > 100 then
			self.flashbuttonquit = false
		elseif self.buttonflashquit < 2 then
			self.flashbuttonquit = true
		end
	
	elseif self.exitstatemouse == false or self.exitstate == false then
		self.flashbuttonquit = true
		self.buttonflashquit = 0
	end
	-- BUTTON FLASHING --

	-- MOUSE DECTECTS --
	if self.mouseover == false then
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		love.audio.stop(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.stop(self.mouseover3)
	end

	if self.mousedetect1 == 1 then
		love.audio.play(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.stop(self.mouseover3)
	end

	if self.mousedetect2 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.play(self.mouseover2)
		love.audio.stop(self.mouseover3)
	end

	if self.mousedetect3 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.play(self.mouseover3)
	end
	-- MOUSE DECTECTS --

	-- if fullscreens was on before you entered a game switch it back on
	if setfull == false and setgamefull == true then
		setfull = true
	end

	-- Update easter egg
	start:colorupdate(dt)
end

function menu:keypressed(key)

	-- SELECT BUTTONS --
	-- Move arrow up through menu states
	if key == "up" or key == "w" then
		love.audio.play(self.select1)
		love.audio.play(self.select2)
		love.audio.play(self.select3)
		self.arrowy = self.arrowy - 50
		
		if self.mouseover == true then
			love.mouse.setX((love.graphics.getWidth()/2 - 459/2) + 500)
		end 
	end

	-- Move arrow down through menu states
	if key == "down" or key == "s" then
		love.audio.play(self.select1)
		love.audio.play(self.select2)
		love.audio.play(self.select3)
		self.arrowy = self.arrowy + 50
		
		if self.mouseover == true then
			love.mouse.setX((love.graphics.getWidth()/2 - 459/2) + 500)
		end
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
		start.movelogo = 128
		love.audio.play(self.backsound)
	end

	-- Keypressed for easter egg
	start:colorkeypressed(key)
end

function menu:mousepressed(mx, my, button)

	-- ACTIVATE BUTTONS --
	-- Launch game
	if button == "l" and self.playstatemouse == true then
		love.audio.play(self.entersound)
		Gamestate.push(selectmode)
	end

	-- Quit game
	if button == "l" and self.exitstatemouse == true then
		love.event.quit()
	end

	-- Go to options menu
	if button == "l" and self.optstatemouse == true then
		love.audio.play(self.entersound)
		Gamestate.push(options)
	end
	-- ACTIVATE BUTTONS --

	-- Go back to the start screen
	if button == "r" then
		Gamestate.switch(start)
		start.movelogo = 128
		love.audio.play(self.backsound)
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
	love.graphics.draw(start.gamelogo, (love.graphics.getWidth()/2 - start.gamelogo:getWidth()/2), (love.graphics.getHeight()/2 - start.gamelogo:getHeight()/2 - start.movelogo))
	------ IMAGES ------

	------ SHAPES ------
	love.graphics.setColor(160, 47, 0)
	love.graphics.rectangle("fill", self.arrowx, (love.graphics.getHeight()/2 - 28/2) + self.arrowy - 8, 28, 28 )
	------ SHAPES ------

	------ TEXT ------
	love.graphics.setFont( start.font2 )
	love.graphics.print('START NEW GAME', (love.graphics.getWidth()/2 - start.font2:getWidth( "START NEW GAME" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "START NEW GAME" )/2) + self.playbtny, 0, self.scaleplay)
	love.graphics.setColor(255, 255, 255, self.buttonflashplay)
	love.graphics.print('START NEW GAME', (love.graphics.getWidth()/2 - start.font2:getWidth( "START NEW GAME" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "START NEW GAME" )/2) + self.playbtny, 0, self.scaleplay)
	love.graphics.setColor(160, 47, 0, 255)
	love.graphics.print('QUIT', (love.graphics.getWidth()/2 - start.font2:getWidth( "QUIT" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "QUIT" )/2) + self.quitbtny, 0, self.scalequit)
	love.graphics.setColor(255, 255, 255, self.buttonflashquit)
	love.graphics.print('QUIT', (love.graphics.getWidth()/2 - start.font2:getWidth( "QUIT" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "QUIT" )/2) + self.quitbtny, 0, self.scalequit)
	love.graphics.setColor(160, 47, 0, 255)
	love.graphics.print('SETTINGS', (love.graphics.getWidth()/2 - start.font2:getWidth( "SETTINGS" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "SETTINGS" )/2) + self.optbtny, 0, self.scaleoptions)
	love.graphics.setColor(255, 255, 255, self.buttonflashoptions)
	love.graphics.print('SETTINGS', (love.graphics.getWidth()/2 - start.font2:getWidth( "SETTINGS" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "SETTINGS" )/2) + self.optbtny, 0, self.scaleoptions)
	love.graphics.setColor(160, 47, 0, 255)
	love.graphics.setFont( start.font0 )
	love.graphics.setColor(160, 47, 0)
	love.graphics.print('Pre-Alpha 0.1.2', 15, (love.graphics.getHeight() - start.font0:getHeight("Pre-Alpha 0.1.1") - 10))
	love.graphics.setColor(255, 255, 255, 255)
	------ TEXT ------
end

return menu