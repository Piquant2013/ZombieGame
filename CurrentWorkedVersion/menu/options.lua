-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads credits script
credits = require 'menu/credits'

-- Loads controls script
controls = require 'menu/controls'

-- Loads moregames script
moregames = require 'menu/moregames'

-- Loads advanced script
advanced = require 'menu/advanced'

-- Creates options as a new gamestate
options = Gamestate.new()


function options:init()

	------ VARIABLES ------
	-- FPS Button Y & X
	self.fpsbtny = 100
	self.fpsbtnx = 492

	-- control Button Y & X
	self.controlsbtny = 150
	self.controlsbtnx = 502
	
	-- moregames Button Y & X
	self.moregamesbtny = 200
	self.moregamesbtnx = 507

	-- Credits Button Y & X
	self.creditsbtny = 250
	self.creditsbtnx = 550

	-- Back button
	self.backy = 150

	-- Button Selecter Y & X
	self.arrowy = (self.fpsbtny)
	self.arrowx = 645

	-- Option menu states
	self.fpsstate = false
	self.creditsstate = false
	self.controlsstate = false
	self.moregamesstate = false

	-- Scale vars for buttons
	self.scalefps = 1
	self.scalecredits = 1
	self.scalecontrols = 1
	self.scalemoregames = 1
	self.scaleback = 1

	-- Flash vars for fps button
	self.flashbuttonfps = true
	self.buttonflashfps = 0

	-- Flash vars for credits button
	self.flashbuttoncredits = true
	self.buttonflashcredits = 0

	-- Flash vars for contorls button
	self.flashbuttoncontrols = true
	self.buttonflashcontrols = 0

	-- Flash vars for moregames button
	self.flashbuttonmoregames = true
	self.buttonflashmoregames = 0

	-- Flash vars for back button
	self.flashbuttonback = true
	self.buttonflashback = 0

	-- mouse button state
	self.fpsstatemouse = false
	self.creditsstatemouse = false
	self.controlsstatemouse = false
	self.moregamesstatemouse = false
	self.backstatemouse = false

	-- Mouse Dectect vars for sound
	self.mouseover = false
	self.mouseoverback = false
	self.mousedetect1 = 0
	self.mousedetect2 = 0
	self.mousedetect3 = 0
	self.mousedetect4 = 0
	self.mousedetect5 = 0
	------ VARIABLES ------

	------ AUDIO ------
	self.entersound1 = love.audio.newSource("audio/buttons/enter.ogg")
	self.backsound = love.audio.newSource("audio/buttons/back.ogg")
	self.select1 = love.audio.newSource("audio/buttons/select.ogg")
	self.select2 = love.audio.newSource("audio/buttons/select.ogg")
	self.select3 = love.audio.newSource("audio/buttons/select.ogg")
	self.select4 = love.audio.newSource("audio/buttons/select.ogg")
	self.clickselect1 = love.audio.newSource("audio/buttons/select.ogg")
	self.clickselect2 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover1 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover2 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover3 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover4 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover5 = love.audio.newSource("audio/buttons/select.ogg")
	------ AUDIO ------
end

function options:update(dt)


	self.entersound1:setVolume(sfxvolume)
	self.backsound:setVolume(sfxvolume)
	self.select1:setVolume(sfxvolume)
	self.select2:setVolume(sfxvolume)
	self.select3:setVolume(sfxvolume)
	self.select4:setVolume(sfxvolume)
	self.clickselect1:setVolume(sfxvolume)
	self.clickselect2:setVolume(sfxvolume)
	self.mouseover1:setVolume(sfxvolume)
	self.mouseover2:setVolume(sfxvolume)
	self.mouseover3:setVolume(sfxvolume)
	self.mouseover4:setVolume(sfxvolume)
	self.mouseover5:setVolume(sfxvolume)


	-- Move options text depending on if its in menu or pasued
	if paused == true then
		self.fpsbtny = -50
		self.creditsbtny = 100
		self.backy = 0
		self.controlsbtny = 0
		self.moregamesbtny = 50
	elseif paused == false then
		self.fpsbtny = 100
		self.creditsbtny = 250
		self.backy = 150
		self.controlsbtny = 150
		self.moregamesbtny = 200
	end 
	
	-- OPTION MENU STATES --
	-- fps options menu state
	if self.arrowy == self.fpsbtny then
		self.arrowx = love.graphics.getWidth()/2 + 130 /2
		self.fpsstate = true
		self.creditsstate = false
		self.controlsstate = false
		self.moregamesstate = false
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
		love.audio.stop(self.select4)
		self.scalefps = 1.1
		self.scalecredits = 1
		self.scalecontrols = 1
		self.scalemoregames = 1
		self.scaleback = 1
	end

	-- credits options menu state
	if self.arrowy == self.creditsbtny then
		self.arrowx = love.graphics.getWidth()/2 + 170 /2
		self.fpsstate = false
		self.creditsstate = true
		self.controlsstate = false
		self.moregamesstate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select3)
		love.audio.stop(self.select4)
		self.scalefps = 1
		self.scalecredits = 1.1
		self.scalecontrols = 1
		self.scalemoregames = 1
		self.scaleback = 1
	end

	-- mute controls menu state
	if self.arrowy < self.moregamesbtny and self.arrowy > self.fpsbtny then
		self.arrowx = love.graphics.getWidth()/2 + 130 /2
		self.fpsstate = false
		self.creditsstate = false
		self.controlsstate = true
		self.moregamesstate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
		love.audio.stop(self.select4)
		self.scalefps = 1
		self.scalecredits = 1
		self.scalecontrols = 1.1
		self.scalemoregames = 1
		self.scaleback = 1
	end

	-- credits moregames menu state
	if self.arrowy < self.creditsbtny and self.arrowy > self.controlsbtny then
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.fpsstate = false
		self.creditsstate = false
		self.controlsstate = false
		self.moregamesstate = true
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
		self.scalefps = 1
		self.scalecredits = 1
		self.scalecontrols = 1
		self.scalemoregames = 1.1
		self.scaleback = 1
	end
	-- OPTION MENU STATES --

	-- Make sure the arrow doesnt go past fps or credits
	if self.arrowy < self.fpsbtny then
		self.arrowy = self.fpsbtny
	elseif self.arrowy > self.creditsbtny then
		self.arrowy = self.creditsbtny
	end

	-- MOUSE AREAS --
	-- Mouse area of fps button
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 + start.font2:getWidth( "DISPLAY FPS:" )) 
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2) 
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.fpsbtny - 10) - 5
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.fpsbtny + start.font2:getHeight( "DISPLAY FPS:" )) + 5 then
		self.fpsstatemouse = true
		self.creditsstatemouse = false
		self.controlsstatemouse = false
		self.moregamesstatemouse = false
		self.backstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 + 130 /2
		self.arrowy = self.fpsbtny
		self.scalefps = 1.1
		self.scalecredits = 1
		self.scalecontrols = 1
		self.scalemoregames = 1
		self.scaleback = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mousedetect1 = self.mousedetect1 + 1
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = 0
		self.mousedetect5 = 0
	end

	-- Mouse area of credits button
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 + start.font2:getWidth( "DISPLAY FPS:" )) 
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2) 
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "CREDITS" )/2 + self.creditsbtny - 10) - 5
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "CREDITS" )/2 + self.creditsbtny + start.font2:getHeight( "CREDITS" )) + 5 then
		self.fpsstatemouse = false
		self.creditsstatemouse = true
		self.controlsstatemouse = false
		self.moregamesstatemouse = false
		self.backstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 + 170 /2
		self.arrowy = self.creditsbtny
		self.scalefps = 1
		self.scalecredits = 1.1
		self.scalecontrols = 1
		self.scalemoregames = 1
		self.scaleback = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = self.mousedetect4 + 1
		self.mousedetect5 = 0
	end

	-- Mouse area of controls button
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 + start.font2:getWidth( "DISPLAY FPS:" )) 
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2) 
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "CONTROLS" )/2 + self.controlsbtny - 10) - 5
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "CONTROLS" )/2 + self.controlsbtny + start.font2:getHeight( "CONTROLS" )) + 5 then
		self.fpsstatemouse = false
		self.creditsstatemouse = false
		self.controlsstatemouse = true
		self.moregamesstatemouse = false
		self.backstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 + 130 /2
		self.arrowy = self.controlsbtny
		self.scalefps = 1
		self.scalecredits = 1
		self.scalecontrols = 1.1
		self.scalemoregames = 1
		self.scaleback = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mousedetect1 = 0
		self.mousedetect2 = self.mousedetect2 + 1
		self.mousedetect3 = 0
		self.mousedetect4 = 0
	end

	-- Mouse area of moregames button
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 + start.font2:getWidth( "DISPLAY FPS:" )) 
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2) 
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "MORE GAMES" )/2 + self.moregamesbtny - 10) - 5
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "MORE GAMES" )/2 + self.moregamesbtny + start.font2:getHeight( "MORE GAMES" )) + 5 then
		self.fpsstatemouse = false
		self.creditsstatemouse = false
		self.controlsstatemouse = false
		self.moregamesstatemouse = true
		self.backstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.arrowy = self.moregamesbtny
		self.scalefps = 1
		self.scalecredits = 1
		self.scalecontrols = 1
		self.scalemoregames = 1.1
		self.scaleback = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = self.mousedetect3 + 1
		self.mousedetect4 = 0
		self.mousedetect5 = 0
	end

	-- Mouse area of back button
	if love.mouse.getX() < (love.graphics.getWidth()/2 - 300 - start.font2:getWidth( "<" )/2 + start.font2:getWidth( "<" ) + 30) 
		and love.mouse.getX() > (love.graphics.getWidth()/2 - 300 - start.font2:getWidth( "<" )/2 - 40) 
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "<" )/2 + self.backy - 40) 
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "<" )/2 + self.backy) + start.font2:getHeight( "<" ) + 30 then
		self.fpsstatemouse = false
		self.creditsstatemouse = false
		self.controlsstatemouse = false
		self.moregamesstatemouse = false
		self.backstatemouse = true
		self.scaleback = 1.4
		self.mouseover = false
		self.mouseoverback = true
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = 0
		self.mousedetect5 = self.mousedetect5 + 1
	end
	-- MOUSE AREAS --

	-- MOUSE OUT OF AREA --
	-- Out of areas for the page 1 buttons
	if love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 + start.font2:getWidth( "DISPLAY FPS:" )) then
		self.fpsstatemouse = false
		self.mutestatemouse = false
		self.mouselockstatemouse = false
		self.creditsstatemouse = false
		self.mouseover = false
	end
	
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2) then
		self.fpsstatemouse = false
		self.mutestatemouse = false
		self.mouselockstatemouse = false
		self.creditsstatemouse = false
		self.mouseover = false
	end
	
	if love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.fpsbtny - 10) - 5 then
		self.fpsstatemouse = false
		self.mutestatemouse = false
		self.mouselockstatemouse = false
		self.creditsstatemouse = false
		self.mouseover = false
	end

	if love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "CREDITS" )/2 + self.creditsbtny + start.font2:getHeight( "CREDITS" )) + 5 then
		self.fpsstatemouse = false
		self.mutestatemouse = false
		self.mouselockstatemouse = false
		self.creditsstatemouse = false
		self.mouseover = false
	end

	-- Out of areas for the back button
	if love.mouse.getX() > (love.graphics.getWidth()/2 - 300 - start.font2:getWidth( "<" )/2 + start.font2:getWidth( "<" )) + 30 then
		self.backstatemouse = false
		self.mouseoverback = false
		self.scaleback = 1
	end 
	
	if love.mouse.getX() < (love.graphics.getWidth()/2 - 300 - start.font2:getWidth( "<" )/2) - 40 then
		self.backstatemouse = false
		self.mouseoverback = false
		self.scaleback = 1
	end

	if love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "<" )/2 + self.backy - 40) then
		self.backstatemouse = false
		self.mouseoverback = false
		self.scaleback = 1
	end 

	if love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "<" )/2 + self.backy) + start.font2:getHeight( "<" ) + 30 then
		self.backstatemouse = false
		self.mouseoverback = false
		self.scaleback = 1
	end

	-- BUTTON FLASHING -- 
	-- Flashing for the fps button
	if self.fpsstatemouse == true or self.fpsstate == true then
		
		if self.flashbuttonfps == true then
			self.buttonflashfps = self.buttonflashfps + dt + 2
		elseif self.flashbuttonfps == false then
			self.buttonflashfps = self.buttonflashfps + dt - 2
		end
	
		if self.buttonflashfps > 100 then
			self.flashbuttonfps = false
		elseif self.buttonflashfps < 2 then
			self.flashbuttonfps = true
		end
	
	elseif self.fpsstatemouse == false or self.fpsstate == false then
		self.flashbuttonfps = true
		self.buttonflashfps = 0
	end

	-- Flashing for the credits button
	if self.creditsstatemouse == true or self.creditsstate == true then
		
		if self.flashbuttoncredits == true then
			self.buttonflashcredits = self.buttonflashcredits + dt + 2
		elseif self.flashbuttoncredits == false then
			self.buttonflashcredits = self.buttonflashcredits + dt - 2
		end
	
		if self.buttonflashcredits > 100 then
			self.flashbuttoncredits = false
		elseif self.buttonflashcredits < 2 then
			self.flashbuttoncredits = true
		end
	
	elseif self.creditsstatemouse == false or self.creditsstate == false then
		self.flashbuttoncredits = true
		self.buttonflashcredits = 0
	end

	-- Flashing for the contorls button
	if self.controlsstatemouse == true or self.controlsstate == true then
		
		if self.flashbuttoncontrols == true then
			self.buttonflashcontrols = self.buttonflashcontrols + dt + 2
		elseif self.flashbuttoncontrols == false then
			self.buttonflashcontrols = self.buttonflashcontrols + dt - 2
		end
	
		if self.buttonflashcontrols > 100 then
			self.flashbuttoncontrols = false
		elseif self.buttonflashcontrols < 2 then
			self.flashbuttoncontrols = true
		end
	
	elseif self.controlsstatemouse == false or self.controlsstate == false then
		self.flashbuttoncontrols = true
		self.buttonflashcontrols = 0
	end

	-- Flashing for the moregames button
	if self.moregamesstatemouse == true or self.moregamesstate == true then
		
		if self.flashbuttonmoregames == true then
			self.buttonflashmoregames = self.buttonflashmoregames + dt + 2
		elseif self.flashbuttonmoregames == false then
			self.buttonflashmoregames = self.buttonflashmoregames + dt - 2
		end
	
		if self.buttonflashmoregames > 100 then
			self.flashbuttonmoregames = false
		elseif self.buttonflashmoregames < 2 then
			self.flashbuttonmoregames = true
		end
	
	elseif self.moregamesstatemouse == false or self.moregamesstate == false then
		self.flashbuttonmoregames = true
		self.buttonflashmoregames = 0
	end

	-- Flashing for the back button
	if self.backstatemouse == true then
		
		if self.flashbuttonback == true then
			self.buttonflashback = self.buttonflashback + dt + 2
		elseif self.flashbuttonback == false then
			self.buttonflashback = self.buttonflashback + dt - 2
		end
	
		if self.buttonflashback > 100 then
			self.flashbuttonback = false
		elseif self.buttonflashback < 2 then
			self.flashbuttonback = true
		end
	
	elseif self.backstatemouse == false or self.backstate == false then
		self.flashbuttonback = true
		self.buttonflashback = 0
	end
	-- BUTTON FLASHING --

	-- MOUSE DECTECTS --
	if self.mouseover == false then
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = 0
		love.audio.stop(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.stop(self.mouseover4)
	end

	if self.mouseoverback == false then
		self.mousedetect5 = 0
		love.audio.stop(self.mouseover5)
	end

	if self.mousedetect1 == 1 then
		love.audio.play(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.stop(self.mouseover4)
	end

	if self.mousedetect2 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.play(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.stop(self.mouseover4)
	end

	if self.mousedetect3 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.play(self.mouseover3)
		love.audio.stop(self.mouseover4)
	end

	if self.mousedetect4 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.play(self.mouseover4)
	end
	-- MOUSE DECTECTS --
end

function options:keypressed(key)
	
	-- SELECT BUTTONS --
	-- Move arrow up through options menu states
	if key == "up" or key == "w" then

		if self.fpsstate == false then
			love.audio.play(self.select1)
			love.audio.play(self.select2)
			love.audio.play(self.select3)
			love.audio.play(self.select4)
		end

		self.arrowy = self.arrowy - 50

		if self.mouseover == true then
			love.mouse.setX((love.graphics.getWidth()/2 - 459/2) + 500)
		end 
	end

	-- Move arrow up through options menu states
	if key == "down" or key == "s" then
		
		if self.creditsstate == false then
			love.audio.play(self.select1)
			love.audio.play(self.select2)
			love.audio.play(self.select3)
			love.audio.play(self.select4)
		end

		self.arrowy = self.arrowy + 50

		if self.mouseover == true then
			love.mouse.setX((love.graphics.getWidth()/2 - 459/2) + 500)
		end 
	end
	-- SELECT BUTTONS --

	-- ACTIVATE BUTTONS --
	-- go to credits screen
	if key == "return" and self.creditsstate == true or key == "space" and self.creditsstate == true then
		Gamestate.push(credits)
		love.audio.play(self.entersound1)
		love.audio.stop(credits.entersound)
		love.audio.pause(start.music)

		-- pause easteregg music if its playing
		if start.easteregg == true then
			love.audio.pause(start.colorgoeshere)
		end
		
		-- pasue game music if its playing
		if paused == true then
			if setarcade == false then
				love.audio.pause(game.music1)
			end

			if gamereset == false then
				love.audio.pause(game.music4)
			end
		end

		love.audio.play(credits.music)
		credits.music:setLooping(true)
		credits.slider = love.graphics.getHeight() + 20
	end

	-- switch advancded script
	if key == "return" and self.fpsstate == true or key == "space" and self.fpsstate == true then
		Gamestate.push(advanced)
		love.audio.play(self.entersound1)
	end

	-- set controls on or off
	if key == "return" and self.controlsstate == true or key == "space" and self.controlsstate == true then
		Gamestate.push(controls)
		love.audio.play(self.entersound1)
	end

	-- go to moregames screen
	if key == "return" and self.moregamesstate == true or key == "space" and self.moregamesstate == true then
		Gamestate.push(moregames)
		love.audio.play(self.entersound1)
	end
	-- ACTIVATE BUTTONS --

	-- Go back to the menu screen
	if key == "escape" then
		Gamestate.pop()
		love.audio.play(self.backsound)

		if paused == true then
			self.arrowy = -50
		elseif paused == false then
			self.arrowy = 100
		end 
	end
end

function options:mousepressed(mx, my, button)
	
	-- go to credits screen
	if button == 1 and self.creditsstatemouse == true then
		Gamestate.push(credits)
		love.audio.play(self.entersound1)
		love.audio.stop(credits.entersound)
		love.audio.pause(start.music)

		-- pause easteregg music if its playing
		if start.easteregg == true then
			love.audio.pause(start.colorgoeshere)
		end
		
		-- pasue game music if its playing
		if paused == true then
			if setarcade == false then
				love.audio.pause(game.music1)
			end

			if gamereset == false then
				love.audio.pause(game.music4)
			end
		end

		love.audio.play(credits.music)
		credits.music:setLooping(true)
		credits.slider = love.graphics.getHeight() + 20
	end

	-- switch advancded script
	if button == 1 and self.fpsstatemouse == true then
		Gamestate.push(advanced)
		love.audio.play(self.entersound1)
	end

	-- set controls on or off
	if button == 1 and self.controlsstatemouse == true then
		love.audio.play(self.entersound1)
		Gamestate.push(controls)
	end

	-- go to credits screen
	if button == 1 and self.moregamesstatemouse == true then
		love.audio.play(self.entersound1)
		Gamestate.push(moregames)
	end

	-- Go back to the start screen
	if button == 1 and self.backstatemouse == true then
		Gamestate.pop()
		love.audio.play(self.backsound)

		if paused == true then
			self.arrowy = -50
		elseif paused == false then
			self.arrowy = 100
		end 
	end

	-- Go back to the start screen
	if button == 2 then
		Gamestate.pop()
		love.audio.play(self.backsound)

		if paused == true then
			self.arrowy = -50
		elseif paused == false then
			self.arrowy = 100
		end 
	end
end

function options:draw()

	------ FILTERS ------
	start.gamelogo:setFilter( 'nearest', 'nearest' )
	start.bg:setFilter( 'nearest', 'nearest' )
	start.font2:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	------ IMAGES ------
	-- Sets image depending if in options menu or pasue
	if paused == false then
		love.graphics.draw(start.bg, -10, 0, 0, 1)
		love.graphics.draw(start.gamelogo, (love.graphics.getWidth()/2 - start.gamelogo:getWidth()/2), (love.graphics.getHeight()/2 - start.gamelogo:getHeight()/2 - start.movelogo))
	elseif paused == true then
		love.graphics.draw(start.bg, 0, -1000, 0, 3)
	end
	------ IMAGES ------

	------ SHAPES ------
	love.graphics.setColor(160, 47, 0)
	love.graphics.rectangle("fill", self.arrowx - 250, (love.graphics.getHeight()/2 - 28/2) + self.arrowy - 8, 28, 28 )
	------ SHAPES ------

	------ TEXT ------	
		
		-- draw page 1 options
		love.graphics.setFont( start.font2 )
		love.graphics.print('ADVANCED', (love.graphics.getWidth()/2 - start.font2:getWidth( "ADVANCED" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "ADVANCED" )/2) + self.fpsbtny, 0, self.scalefps)
		love.graphics.setColor(255, 255, 255, self.buttonflashfps)
		love.graphics.print('ADVANCED', (love.graphics.getWidth()/2 - start.font2:getWidth( "ADVANCED" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "ADVANCED" )/2) + self.fpsbtny, 0, self.scalefps)
		love.graphics.setColor(160, 47, 0, 255)
		love.graphics.print('CREDITS', (love.graphics.getWidth()/2 - start.font2:getWidth( "CREDITS" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "CREDITS" )/2) + self.creditsbtny, 0, self.scalecredits)
		love.graphics.setColor(255, 255, 255, self.buttonflashcredits)
		love.graphics.print('CREDITS', (love.graphics.getWidth()/2 - start.font2:getWidth( "CREDITS" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "CREDITS" )/2) + self.creditsbtny, 0, self.scalecredits)
		love.graphics.setColor(160, 47, 0, 255)
		
		-- draw page 2 options
		love.graphics.setFont( start.font2 )
		love.graphics.setColor(160, 47, 0, 255)
		love.graphics.print('CONTROLS', (love.graphics.getWidth()/2 - start.font2:getWidth( "CONTROLS" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "CONTROLS" )/2) + self.controlsbtny, 0, self.scalecontrols)
		love.graphics.setColor(255, 255, 255, self.buttonflashcontrols)
		love.graphics.print('CONTROLS', (love.graphics.getWidth()/2 - start.font2:getWidth( "CONTROLS" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "CONTROLS" )/2) + self.controlsbtny, 0, self.scalecontrols)
		love.graphics.setColor(160, 47, 0, 255)
		love.graphics.print('MORE GAMES', (love.graphics.getWidth()/2 - start.font2:getWidth( "MORE GAMES" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "MORE GAMES" )/2) + self.moregamesbtny, 0, self.scalemoregames)
		love.graphics.setColor(255, 255, 255, self.buttonflashmoregames)
		love.graphics.print('MORE GAMES', (love.graphics.getWidth()/2 - start.font2:getWidth( "MORE GAMES" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "MORE GAMES" )/2) + self.moregamesbtny, 0, self.scalemoregames)
		love.graphics.setColor(160, 47, 0, 255)

	-- draw back button
	love.graphics.setFont( start.font2 )
	love.graphics.print('<', (love.graphics.getWidth()/2 - 320), (love.graphics.getHeight()/2 - start.font2:getHeight( "<" )/2) + self.backy, 0, self.scaleback)
	love.graphics.setColor(255, 255, 255, self.buttonflashback)
	love.graphics.print('<', (love.graphics.getWidth()/2 - 320), (love.graphics.getHeight()/2 - start.font2:getHeight( "<" )/2) + self.backy, 0, self.scaleback)
	love.graphics.setColor(255, 255, 255)

	-- display verion number only if in menu
	if paused == false then
		love.graphics.setFont( start.font0 )
		love.graphics.setColor(160, 47, 0)
		love.graphics.print('Pre-Alpha 0.1.3', 15, (love.graphics.getHeight() - start.font0:getHeight("Pre-Alpha 0.1.3") - 10))
		love.graphics.setColor(255, 255, 255)
	end
	------ TEXT ------
end

return options