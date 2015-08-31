-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates pause as a new gamestate
pause = Gamestate.new()


function pause:init()
  
  	------ VARIABLES ------
	-- Resume Button Y & X 
	self.resumebtny = 50
	self.resumebtnx = 548

	-- Main menu Button Y & X  
	self.optionsbtny = 100
	self.optionsbtnx = 512

	-- Main menu Button Y & X  
	self.mainmenubtny = 150
	self.mainmenubtnx = 476
 
	-- Button Selecter Y & X 
	self.arrowy = (self.resumebtny)
	self.arrowx = 480

	-- Pause menu state  
	self.resumestate = false
	self.optionsstate = false
	self.mainmenustate = false

	-- Scale vars for buttons
	self.scaleresume = 1
	self.scaleoptions = 1
	self.scalemainmenu = 1

	-- Flash vars for resume button
	self.flashbuttonresume = true
	self.buttonflashresume = 0

	-- Flash vars for options button
	self.flashbuttonoptions = true
	self.buttonflashoptions = 0

	-- Flash vars for menu button
	self.flashbuttonmainmenu = true
	self.buttonflashmainmenu = 0

	-- mouse button state
	self.resumestatemouse = false
	self.optionsstatemouse = false
	self.mainmenustatemouse = false

	-- Mouse Dectect vars for sound
	self.mouseover = false
	self.mousedetect1 = 0
	self.mousedetect2 = 0
	self.mousedetect3 = 0
	------ VARIABLES ------

	------ AUDIO ------
	self.entersound = love.audio.newSource("audio/buttons/enter.ogg")
	self.select1 = love.audio.newSource("audio/buttons/select.ogg")
	self.select2 = love.audio.newSource("audio/buttons/select.ogg")
	self.select3 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover1 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover2 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover3 = love.audio.newSource("audio/buttons/select.ogg")
	------ AUDIO ------
end

function pause:update(dt)

	-- Pause game music and set cursor
	if resume == false then
		
		if setarcade == false then
			game.music1:setVolume(0.2)
			game.music3:setVolume(0.2)
		end

		if gamereset == false then
			game.music4:setVolume(0.2)
		end
		
		love.mouse.setCursor(cursor)
		love.audio.pause(game.invidle)
	end

	-- Switch back to the game script
	if resume == true then
		Gamestate.pop()
		paused = false
		love.audio.resume(game.invidle)
		love.mouse.setCursor(crosshair)

		if setarcade == false then
			game.music1:setVolume(1.0)
			game.music3:setVolume(1.0)
		end

		if gamereset == false then
			game.music4:setVolume(1.0)
		end
		
		love.audio.resume(game.invidle)
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
		self.scaleresume = 1.1
		self.scaleoptions = 1
		self.scalemainmenu = 1
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
		self.scaleresume = 1
		self.scaleoptions = 1.1
		self.scalemainmenu = 1
	end

	-- Main menu pause menu state
	if self.arrowy == self.mainmenubtny then
		self.arrowx = love.graphics.getWidth()/2 - 260 /2
		self.resumestate = false
		self.mainmenustate = true
		self.optionsstate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select3)
		self.scaleresume = 1
		self.scaleoptions = 1
		self.scalemainmenu = 1.1
	end
	-- PAUSE MENU STATES -- 

  	-- Make sure the arrow doesnt go past resume or main menu
	if self.arrowy > self.mainmenubtny then
		self.arrowy = self.mainmenubtny
	elseif self.arrowy < self.resumebtny then
		self.arrowy = self.resumebtny
	end

	-- MOUSE AREAS --
	-- Mouse area of resume button
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "SETTINGS" )/2 + start.font2:getWidth( "SETTINGS" )) 
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "SETTINGS" )/2) 
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "RESUME" )/2 - 60) - 10
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "RESUME" )/2 - 60 + start.font2:getHeight( "RESUME" )) + 10 then
		self.resumestatemouse = true
		self.optionsstatemouse = false
		self.mainmenustatemouse = false
		self.arrowy = self.resumebtny
		self.arrowx = love.graphics.getWidth()/2 - 320 /2
		self.scaleresume = 1.1
		self.scaleoptions = 1
		self.scalemainmenu = 1
		self.mouseover = true
		self.mousedetect1 = self.mousedetect1 + 1
		self.mousedetect2 = 0
		self.mousedetect3 = 0
	end

	-- Mouse area of options button
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "SETTINGS" )/2 + start.font2:getWidth( "SETTINGS" )) 
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "SETTINGS" )/2) 
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "SETTINGS" )/2 - 10) - 10
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "SETTINGS" )/2 - 10 + start.font2:getHeight( "SETTINGS" )) + 10 then
		self.resumestatemouse = false
		self.optionsstatemouse = true
		self.mainmenustatemouse = false
		self.arrowx = love.graphics.getWidth()/2 - 380 /2
		self.arrowy = self.optionsbtny
		self.scaleresume = 1
		self.scaleoptions = 1.1
		self.scalemainmenu = 1
		self.mouseover = true
		self.mousedetect1 = 0
		self.mousedetect2 = self.mousedetect2 + 1
		self.mousedetect3 = 0
	end

	-- Mouse area of menu button
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "SETTINGS" )/2 + start.font2:getWidth( "SETTINGS" )) 
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "SETTINGS" )/2) 
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "MENU" )/2 + 40) - 10
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "MENU" )/2 + 40 + start.font2:getHeight( "MENU" )) + 10 then
		self.resumestatemouse = false
		self.optionsstatemouse = false
		self.mainmenustatemouse = true
		self.arrowy = self.mainmenubtny
		self.arrowx = love.graphics.getWidth()/2 - 260 /2
		self.scaleresume = 1
		self.scaleoptions = 1
		self.scalemainmenu = 1.1
		self.mouseover = true
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = self.mousedetect3 + 1
	end
	-- MOUSE AREAS --

	-- MOUSE OUT OF AREA --
	if love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "SETTINGS" )/2 + start.font2:getWidth( "SETTINGS" )) then
		self.resumestatemouse = false
		self.optionsstatemouse = false
		self.mainmenustatemouse = false
		self.mouseover = false
	end
	
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "SETTINGS" )/2) then
		self.resumestatemouse = false
		self.optionsstatemouse = false
		self.mainmenustatemouse = false
		self.mouseover = false
	end
	
	if love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "RESUME" )/2 - 60) - 10 then
		self.resumestatemouse = false
		self.optionsstatemouse = false
		self.mainmenustatemouse = false
		self.mouseover = false
	end

	if love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "MENU" )/2 + 40 + start.font2:getHeight( "MENU" )) + 10 then
		self.resumestatemouse = false
		self.optionsstatemouse = false
		self.mainmenustatemouse = false
		self.mouseover = false
	end
	-- MOUSE OUT OF AREA --

	-- BUTTON FLASHING --
	-- Flashing for the resume button
	if self.resumestatemouse == true or self.resumestate == true then
		
		if self.flashbuttonresume == true then
			self.buttonflashresume = self.buttonflashresume + dt + 2
		elseif self.flashbuttonresume == false then
			self.buttonflashresume = self.buttonflashresume + dt - 2
		end
	
		if self.buttonflashresume > 100 then
			self.flashbuttonresume = false
		elseif self.buttonflashresume < 2 then
			self.flashbuttonresume = true
		end
	
	elseif self.resumestatemouse == false or self.resumestate == false then
		self.flashbuttonresume = true
		self.buttonflashresume = 0
	end

	-- Flashing for the options button
	if self.optstatemouse == true or self.optionsstate == true then
		
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
	
	elseif self.optstatemouse == false or self.optionsstate == false then
		self.flashbuttonoptions = true
		self.buttonflashoptions = 0
	end

	-- Flashing for the menu button
	if self.mainmenustatemouse == true or self.mainmenustate == true then
		
		if self.flashbuttonmainmenu == true then
			self.buttonflashmainmenu = self.buttonflashmainmenu + dt + 2
		elseif self.flashbuttonmainmenu == false then
			self.buttonflashmainmenu = self.buttonflashmainmenu + dt - 2
		end
	
		if self.buttonflashmainmenu > 100 then
			self.flashbuttonmainmenu = false
		elseif self.buttonflashmainmenu < 2 then
			self.flashbuttonmainmenu = true
		end
	
	elseif self.mainmenustatemouse == false or self.mainmenustate == false then
		self.flashbuttonmainmenu = true
		self.buttonflashmainmenu = 0
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
end

function pause:keypressed(key)

	-- SELECT BUTTONS --
	-- Move arrow up through pause menu states
	if key == "up" or key == "w" then
		love.audio.play(self.select1)
		love.audio.play(self.select2)
		love.audio.play(self.select3)
		self.arrowy = self.arrowy - 50

		if self.mouseover == true then
			love.mouse.setX((love.graphics.getWidth()/2 - 459/2) + 500)
		end
	end

	-- Move arrow up through pause menu states
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
	-- Resume the game
	if key == "return" and self.resumestate == true or key == " " and self.resumestate == true then
		love.audio.play(self.entersound)
		resume = true
	end

	-- Go to options menu
	if key == "return" and self.optionsstate == true or key == " " and self.optionsstate == true then
		love.audio.play(self.entersound)
		Gamestate.push(options)
		options.arrowy = -50
	end
  
  	-- Go to the main menu
	if key == "return" and self.mainmenustate == true or key == " " and self.mainmenustate == true then
		love.audio.play(self.entersound)
		setarcade = true
		gamereset = true
		game.arcade = false
		game.stuck = false
		paused = false
		welcomescreen = true
		Gamestate.switch(menu)
		love.audio.play(start.music)
		start.music:setLooping(true)
		love.audio.stop(game.music1)
		love.audio.stop(game.music4)
		love.audio.stop(game.music2)
	end
	-- ACTIVATE BUTTONS --

	-- Resume game
	if key == 'escape' then
		resume = true
	end
end

function pause:mousepressed(mx, my, button)
 
	-- Resume the game
	if button == "l" and self.resumestatemouse == true then
		love.audio.play(self.entersound)
		resume = true
	end

	-- Go to options menu
	if button == "l" and self.optionsstatemouse == true then
		love.audio.play(self.entersound)
		Gamestate.push(options)
		options.arrowy = -50
	end
  
  	-- Go to the main menu
	if button == "l" and self.mainmenustatemouse == true then
		love.audio.play(self.entersound)
		setarcade = true
		gamereset = true
		game.arcade = false
		game.stuck = false
		paused = false
		welcomescreen = true
		Gamestate.switch(menu)
		love.audio.play(start.music)
		start.music:setLooping(true)
		love.audio.stop(game.music1)
		love.audio.stop(game.music4)
		love.audio.stop(game.music2)
	end

	-- Resume game
	if button == 'r' then
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
	love.graphics.rectangle("fill", self.arrowx, (love.graphics.getHeight()/2 - 28/2) + self.arrowy - 8 - 100, 28, 28 )
	------ SHAPES ------

	------ TEXT ------
	love.graphics.setFont( start.font2 )
	love.graphics.print('RESUME', (love.graphics.getWidth()/2 - start.font2:getWidth( "RESUME" )/2), (love.graphics.getHeight()/2 - 30/2 - 50), 0, self.scaleresume)
	love.graphics.setColor(255, 255, 255, self.buttonflashresume)
	love.graphics.print('RESUME', (love.graphics.getWidth()/2 - start.font2:getWidth( "RESUME" )/2), (love.graphics.getHeight()/2 - 30/2 - 50), 0, self.scaleresume)
	love.graphics.setColor(160, 47, 0, 255)
	love.graphics.print('SETTINGS', (love.graphics.getWidth()/2 - start.font2:getWidth( "SETTINGS" )/2), (love.graphics.getHeight()/2 - 30/2), 0, self.scaleoptions)
	love.graphics.setColor(255, 255, 255, self.buttonflashoptions)
	love.graphics.print('SETTINGS', (love.graphics.getWidth()/2 - start.font2:getWidth( "SETTINGS" )/2), (love.graphics.getHeight()/2 - 30/2), 0, self.scaleoptions)
	love.graphics.setColor(160, 47, 0, 255)
	love.graphics.print('MENU', (love.graphics.getWidth()/2 - start.font2:getWidth( "MENU" )/2), (love.graphics.getHeight()/2 - 30/2 + 50), 0, self.scalemainmenu)
	love.graphics.setColor(255, 255, 255, self.buttonflashmainmenu)
	love.graphics.print('MENU', (love.graphics.getWidth()/2 - start.font2:getWidth( "MENU" )/2), (love.graphics.getHeight()/2 - 30/2 + 50), 0, self.scalemainmenu)
	love.graphics.setColor(255, 255, 255, 255)
	------ TEXT ------
end

return pause