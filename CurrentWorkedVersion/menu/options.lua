-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads credits script
credits = require 'menu/credits'

-- Creates options as a new gamestate
options = Gamestate.new()


function options:init()

	------ VARIABLES ------
	-- FPS Button Y & X
	self.fpsbtny = 442
	self.fpsbtnx = 492
	
	-- Mute Button Y & X
	self.mutebtny = 492
	self.mutebtnx = 502
	
	-- MouseLock Button Y & X
	self.mouselockbtny = 542
	self.creditsbtnx = 550
	
	-- Credits Button Y & X
	self.creditsbtny = 592
	self.mouselockbtnx = 507

	-- Button Selecter Y & X
	self.arrowy = (self.fpsbtny)
	self.arrowx = 645

	-- FPS Selecter Y & X
	self.fpsarrowy = 232
	self.fpsarrowx = 665
	
	-- Mute Selecter Y & X
	self.mutearrowy = 347
	self.mutearrowx = 665

	-- MouseLock Selecter Y & X
	self.mouselockarrowy = 462
	self.mouselockarrowx = 665

	-- Option menu states
	self.fpsstate = false
	self.mutestate = false
	self.mouselockstate = false
	self.creditsstate = false
	------ VARIABLES ------

	------ AUDIO ------
	self.entersound1 = love.audio.newSource("audio/buttons/enter.ogg")
	self.entersound1a = love.audio.newSource("audio/buttons/enter.ogg")
	self.entersound2 = love.audio.newSource("audio/buttons/enter.ogg")
	self.entersound2a = love.audio.newSource("audio/buttons/enter.ogg")
	self.select1 = love.audio.newSource("audio/buttons/select.ogg")
	self.select2 = love.audio.newSource("audio/buttons/select.ogg")
	self.select3 = love.audio.newSource("audio/buttons/select.ogg")
	self.select4 = love.audio.newSource("audio/buttons/select.ogg")
	------ AUDIO ------
end

function options:update(dt)

	-- Move options text depending on if its in menu or pasued
	if paused == true then
		self.fpsbtny = 300
		self.mutebtny = 350
		self.mouselockbtny = 400
		self.creditsbtny = 450
	elseif paused == false then
		self.fpsbtny = 442
		self.mutebtny = 492
		self.mouselockbtny = 542
		self.creditsbtny = 592
	end 
	
	-- OPTION MENU STATES --
	-- fps options menu state
	if self.arrowy == self.fpsbtny then
		self.arrowx = love.graphics.getWidth()/2 + 10 /2
		self.fpsstate = true
		self.mutestate = false
		self.creditsstate = false
		self.mouselockstate = false
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
		love.audio.stop(self.select4)
	end

	-- mute options menu state
	if self.arrowy < self.mouselockbtny and self.arrowy > self.fpsbtny then
		self.arrowx = love.graphics.getWidth()/2 + 40 /2
		self.fpsstate = false
		self.mutestate = true
		self.creditsstate = false
		self.mouselockstate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
		love.audio.stop(self.select4)
	end

	-- mouselock options menu state
	if self.arrowy < self.creditsbtny and self.arrowy > self.mutebtny then
		self.arrowx = love.graphics.getWidth()/2 + 10 /2
		self.fpsstate = false
		self.mutestate = false
		self.creditsstate = false
		self.mouselockstate = true
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
	end

	-- credits options menu state
	if self.arrowy == self.creditsbtny then
		self.arrowx = love.graphics.getWidth()/2 + 170 /2
		self.fpsstate = false
		self.mutestate = false
		self.creditsstate = true
		self.mouselockstate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select3)
		love.audio.stop(self.select4)
	end
	-- OPTION MENU STATES --

	-- Make sure the arrow doesnt go past fps or credits
	if self.arrowy < self.fpsbtny then
		self.arrowy = self.fpsbtny
	elseif self.arrowy > self.creditsbtny then
		self.arrowy = self.creditsbtny
	end

	-- Pushes FPS arrow back if it trys to pass off else turn setfps true or false
	if self.fpsarrowx > self.fpsbtnx then
		self.fpsarrowx = self.fpsbtnx - 118
	elseif self.fpsarrowx == self.fpsbtnx - 118 then
		setfps = false
	elseif self.fpsarrowx == self.fpsbtnx then	
		setfps = true
	end

	-- Pushes mute arrow back if it trys to pass off else turn setmute true or false
	if self.mutearrowx > self.mutebtnx then
		self.mutearrowx = self.mutebtnx - 118
	elseif self.mutearrowx == self.mutebtnx - 118 then
		setmute = false
	elseif self.mutearrowx == self.mutebtnx then	
		setmute = true
	end

	-- Pushes mouselock arrow back if it trys to pass off else turn setmouselock true or false
	if self.mouselockarrowx > self.mouselockbtnx then
		self.mouselockarrowx = self.mouselockbtnx - 118
	elseif self.mouselockarrowx == self.mouselockbtnx - 118 then
		setmouselock = false
	elseif self.mouselockarrowx == self.mouselockbtnx then	
		setmouselock = true
	end
end

function options:keypressed(key)
	
	-- SELECT BUTTONS --
	-- Move arrow up through options menu states
	if key == "up" or key == "w" then
		love.audio.play(self.select1)
		love.audio.play(self.select2)
		love.audio.play(self.select3)
		love.audio.play(self.select4)
		self.arrowy = self.arrowy - 50
	end

	-- Move arrow up through options menu states
	if key == "down" or key == "s" then
		love.audio.play(self.select1)
		love.audio.play(self.select2)
		love.audio.play(self.select3)
		love.audio.play(self.select4)
		self.arrowy = self.arrowy + 50
	end
	-- SELECT BUTTONS --

	-- ACTIVATE BUTTONS --
	-- go to credits screen
	if key == "return" and self.creditsstate == true or key == " " and self.creditsstate == true then
		Gamestate.push(credits)
		love.audio.play(self.entersound1)
		love.audio.stop(credits.entersound)
		love.audio.pause(start.music)
		
		-- pasue game music if its playing
		if paused == true then
			love.audio.pause(game.music1)
		end

		love.audio.play(credits.music)
		credits.music:setLooping(true)
		credits.slider = 740
	end

	-- set fps on or off
	if key == "return" and self.fpsstate == true or key == " " and self.fpsstate == true then
		self.fpsarrowx = self.fpsarrowx + 118
	end

	-- set mute on or off
	if key == "return" and self.mutestate == true or key == " " and self.mutestate == true then
		self.mutearrowx = self.mutearrowx + 118
	end

	-- set mouselock on or off
	if key == "return" and self.mouselockstate == true or key == " " and self.mouselockstate == true then
		self.mouselockarrowx = self.mouselockarrowx + 118
	end

	-- Plays audio for FPS On & Off buttons
	if key == "return" and setfps == true or key == " " and setfps == true then
		love.audio.play(self.entersound1)
		love.audio.stop(self.entersound1a)
	elseif key == "return" and setfps == false or key == " " and setfps == false then
		love.audio.play(self.entersound1a)
		love.audio.stop(self.entersound1)
	end 

	-- Plays audio for mouselock On & Off buttons
	if key == "return" and setmouselock == true or key == " " and setmouselock == true then
		love.audio.play(self.entersound2a)
		love.audio.stop(self.entersound2)
	elseif key == "return" and setmouselock == false or key == " " and setmouselock == false then
		love.audio.play(self.entersound2)
		love.audio.stop(self.entersound2a)
	end
	-- ACTIVATE BUTTONS --

	-- Go back to the menu screen
	if key == "escape" then
		Gamestate.pop()
		love.audio.play(self.entersound1)
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
		love.graphics.draw(start.gamelogo, (love.graphics.getWidth()/2 - start.gamelogo:getWidth()/2), start.movelogo)
	elseif paused == true then
		love.graphics.draw(start.bg, 0, -1000, 0, 3)
	end
	------ IMAGES ------

	------ SHAPES ------
	love.graphics.setColor(160, 47, 0)
	love.graphics.rectangle("fill", self.arrowx - 250, self.arrowy - 8, 28, 28 )
	------ SHAPES ------

	------ TEXT ------
	love.graphics.setFont( start.font2 )
	love.graphics.print('DISPLAY FPS:', (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2), self.fpsbtny)
	love.graphics.print('MUTE AUDIO:', (love.graphics.getWidth()/2 - start.font2:getWidth( "MUTE AUDIO:" )/2), self.mutebtny)
	love.graphics.print('WINDOW LOCK:', (love.graphics.getWidth()/2 - start.font2:getWidth( "WINDOW LOCK:" )/2), self.mouselockbtny)
	love.graphics.print('CREDITS', (love.graphics.getWidth()/2 - start.font2:getWidth( "CREDITS" )/2), self.creditsbtny)

	-- changes text from on and off for fps
	if setfps == true then
		love.graphics.print('ON', (love.graphics.getWidth()/2 - start.font2:getWidth( "ON" )/2) + 285, self.fpsbtny)
	elseif setfps == false then
		love.graphics.print('OFF', (love.graphics.getWidth()/2 - start.font2:getWidth( "OFF" )/2) + 300, self.fpsbtny)
	end

	-- changes text from on and off for mute
	if setmute == true then
		love.graphics.print('ON', (love.graphics.getWidth()/2 - start.font2:getWidth( "ON" )/2) + 285, self.mutebtny)
	elseif setmute == false then
		love.graphics.print('OFF', (love.graphics.getWidth()/2 - start.font2:getWidth( "OFF" )/2) + 300, self.mutebtny)
	end

	-- changes text from on and off for mouselock
	if setmouselock == true then
		love.graphics.print('ON', (love.graphics.getWidth()/2 - start.font2:getWidth( "ON" )/2) + 285, self.mouselockbtny)
	elseif setmouselock == false then
		love.graphics.print('OFF', (love.graphics.getWidth()/2 - start.font2:getWidth( "OFF" )/2) + 300, self.mouselockbtny)
	end

	love.graphics.setColor(255, 255, 255)
	------ TEXT ------
end

return options