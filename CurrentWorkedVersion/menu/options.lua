-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads credits script
credits = require 'menu/credits'

-- Loads credits script
controls = require 'menu/controls'

-- Loads credits script
changelog = require 'menu/changelog'

-- Loads credits script
moregames = require 'menu/moregames'

-- Creates options as a new gamestate
options = Gamestate.new()


function options:init()

	------ VARIABLES ------
	-- FPS Button Y & X
	self.fpsbtny = 100
	self.fpsbtnx = 492
	
	-- Mute Button Y & X
	self.mutebtny = 150
	self.mutebtnx = 502
	
	-- MouseLock Button Y & X
	self.mouselockbtny = 200
	self.creditsbtnx = 550
	
	-- Credits Button Y & X
	self.creditsbtny = 250
	self.mouselockbtnx = 507








	-- FPS Button Y & X
	self.fullscreenbtny = 100
	self.fullscreenbtnx = 492
	
	-- Mute Button Y & X
	self.controlsbtny = 150
	self.controlsbtnx = 502
	
	-- MouseLock Button Y & X
	self.changelogbtny = 200
	self.changelogbtnx = 550
	
	-- Credits Button Y & X
	self.moregamesbtny = 250
	self.moregamesbtnx = 507






	-- FPS Selecter Y & X
	self.fullscreenarrowy = 232
	self.fullscreenarrowx = 665







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
	self.mouselockarrowx = 507

	-- Back arrow
	self.backy = 150

	-- page vars
	self.page2 = false

	-- Option menu states
	self.fpsstate = false
	self.mutestate = false
	self.mouselockstate = false
	self.creditsstate = false
	self.fullscreenstate = false
	self.controlsstate = false
	self.changelogstate = false
	self.moregamesstate = false
	------ VARIABLES ------

	------ AUDIO ------
	self.entersound1 = love.audio.newSource("audio/buttons/enter.ogg")
	self.entersound1a = love.audio.newSource("audio/buttons/enter.ogg")
	self.entersound2 = love.audio.newSource("audio/buttons/enter.ogg")
	self.entersound2a = love.audio.newSource("audio/buttons/enter.ogg")
	self.entersound3 = love.audio.newSource("audio/buttons/enter.ogg")
	self.entersound3a = love.audio.newSource("audio/buttons/enter.ogg")
	self.backsound = love.audio.newSource("audio/buttons/back.ogg")
	self.select1 = love.audio.newSource("audio/buttons/select.ogg")
	self.select2 = love.audio.newSource("audio/buttons/select.ogg")
	self.select3 = love.audio.newSource("audio/buttons/select.ogg")
	self.select4 = love.audio.newSource("audio/buttons/select.ogg")
	self.select5 = love.audio.newSource("audio/buttons/select.ogg")
	self.select6 = love.audio.newSource("audio/buttons/select.ogg")
	------ AUDIO ------
end

function options:update(dt)

	-- Move options text depending on if its in menu or pasued
	if paused == true then
		self.fpsbtny = -50
		self.mutebtny = 0
		self.mouselockbtny = 50
		self.creditsbtny = 100
		self.backy = 0
		self.fullscreenbtny = -50
		self.controlsbtny = 0
		self.changelogbtny = 50
		self.moregamesbtny = 100
	elseif paused == false then
		self.fpsbtny = 100
		self.mutebtny = 150
		self.mouselockbtny = 200
		self.creditsbtny = 250
		self.backy = 150
		self.fullscreenbtny = 100
		self.controlsbtny = 150
		self.changelogbtny = 200
		self.moregamesbtny = 250
	end 
	
	-- OPTION MENU STATES --
	-- fps options menu state
	if self.arrowy == self.fpsbtny and self.page2 == false then
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
	if self.arrowy < self.mouselockbtny and self.arrowy > self.fpsbtny and self.page2 == false then
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
	if self.arrowy < self.creditsbtny and self.arrowy > self.mutebtny and self.page2 == false then
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
	if self.arrowy == self.creditsbtny and self.page2 == false then
		self.arrowx = love.graphics.getWidth()/2 + 170 /2
		self.fpsstate = false
		self.mutestate = false
		self.creditsstate = true
		self.mouselockstate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select3)
		love.audio.stop(self.select4)
	end














	-- fps options menu state
	if self.arrowy == self.fullscreenbtny and self.page2 == true then
		self.arrowx = love.graphics.getWidth()/2 + 40 /2
		self.fullscreenstate = true
		self.controlsstate = false
		self.moregamesstate = false
		self.changelogstate = false
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
		love.audio.stop(self.select4)
	end

	-- mute options menu state
	if self.arrowy < self.changelogbtny and self.arrowy > self.fullscreenbtny and self.page2 == true then
		self.arrowx = love.graphics.getWidth()/2 + 130 /2
		self.fullscreenstate = false
		self.controlsstate = true
		self.moregamesstate = false
		self.changelogstate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
		love.audio.stop(self.select4)
	end

	-- mouselock options menu state
	if self.arrowy < self.moregamesbtny and self.arrowy > self.controlsbtny and self.page2 == true then
		self.arrowx = love.graphics.getWidth()/2 + 100 /2
		self.fullscreenstate = false
		self.controlsstate = false
		self.moregamesstate = false
		self.changelogstate = true
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
	end

	-- credits options menu state
	if self.arrowy == self.moregamesbtny and self.page2 == true then
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.fullscreenstate = false
		self.controlsstate = false
		self.moregamesstate = true
		self.changelogstate = false
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








	-- Pushes mouselock arrow back if it trys to pass off else turn setmouselock true or false
	if self.fullscreenarrowx > self.fullscreenbtnx then
		self.fullscreenarrowx = self.fullscreenbtnx - 118
	elseif self.fullscreenarrowx == self.fullscreenbtnx - 118 then
		setfull = false
	elseif self.fullscreenarrowx == self.fullscreenbtnx then	
		setfull = true
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











	if key == "right" and self.page2 == false or key == "d" and self.page2 == false then
		love.audio.play(self.select5)
		love.audio.stop(self.select6)
		self.page2 = true
	end

	if key == "left" and self.page2 == true or key == "a" and self.page2 == true then
		love.audio.stop(self.select5)
		love.audio.play(self.select6)
		self.page2 = false
	end
	

	









	-- SELECT BUTTONS --

	-- ACTIVATE BUTTONS --
	-- go to credits screen
	if key == "return" and self.creditsstate == true and self.page2 == false or key == " " and self.creditsstate == true and self.page2 == false then
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
			love.audio.pause(game.music1)
		end

		love.audio.play(credits.music)
		credits.music:setLooping(true)
		credits.slider = love.graphics.getHeight() + 20
	end

	-- set fps on or off
	if key == "return" and self.fpsstate == true and self.page2 == false or key == " " and self.fpsstate == true and self.page2 == false then
		self.fpsarrowx = self.fpsarrowx + 118
	end

	-- set mute on or off
	if key == "return" and self.mutestate == true and self.page2 == false or key == " " and self.mutestate == true and self.page2 == false then
		self.mutearrowx = self.mutearrowx + 118
	end

	-- set mouselock on or off
	if key == "return" and self.mouselockstate == true and self.page2 == false or key == " " and self.mouselockstate == true and self.page2 == false then
		self.mouselockarrowx = self.mouselockarrowx + 118
	end

	-- Plays audio for FPS On & Off buttons
	if key == "return" and setfps == true and self.page2 == false or key == " " and setfps == true and self.page2 == false then
		love.audio.play(self.entersound1)
		love.audio.stop(self.entersound1a)
	elseif key == "return" and setfps == false and self.page2 == false or key == " " and setfps == false and self.page2 == false then
		love.audio.play(self.entersound1a)
		love.audio.stop(self.entersound1)
	end 

	-- Plays audio for mouselock On & Off buttons
	if key == "return" and setmouselock == true and self.page2 == false or key == " " and setmouselock == true and self.page2 == false then
		love.audio.play(self.entersound2a)
		love.audio.stop(self.entersound2)
	elseif key == "return" and setmouselock == false and self.page2 == false or key == " " and setmouselock == false and self.page2 == false then
		love.audio.play(self.entersound2)
		love.audio.stop(self.entersound2a)
	end












	-- set fps on or off
	if key == "return" and self.fullscreenstate == true and self.page2 == true or key == " " and self.fullscreenstate == true and self.page2 == true then
		self.fullscreenarrowx = self.fullscreenarrowx + 118
	end

	-- set mute on or off
	if key == "return" and self.controlsstate == true and self.page2 == true or key == " " and self.controlsstate == true and self.page2 == true then
		love.audio.play(self.entersound1)
		Gamestate.push(controls)
	end

	-- set mouselock on or off
	if key == "return" and self.changelogstate == true and self.page2 == true or key == " " and self.changelogstate == true and self.page2 == true then
		love.audio.play(self.entersound1)
		Gamestate.push(changelog)
	end

	-- go to credits screen
	if key == "return" and self.moregamesstate == true and self.page2 == true or key == " " and self.moregamesstate == true and self.page2 == true then
		love.audio.play(self.entersound1)
		Gamestate.push(moregames)
	end

	-- Plays audio for FPS On & Off buttons
	if key == "return" and setfull == true and self.page2 == true or key == " " and setfull == true and self.page2 == true then
		love.audio.play(self.entersound3)
		love.audio.stop(self.entersound3a)
	elseif key == "return" and setfull == false and self.page2 == true or key == " " and setfull == false and self.page2 == true then
		love.audio.play(self.entersound3a)
		love.audio.stop(self.entersound3)
	end











	-- ACTIVATE BUTTONS --

	-- Go back to the menu screen
	if key == "escape" then
		Gamestate.pop()
		love.audio.play(self.backsound)
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
	love.graphics.setFont( start.font2 )
	
	if self.page2 == false then
		love.graphics.print('DISPLAY FPS:', (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2) + self.fpsbtny)
		love.graphics.print('MUTE AUDIO:', (love.graphics.getWidth()/2 - start.font2:getWidth( "MUTE AUDIO:" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "MUTE AUDIO:" )/2) + self.mutebtny)
		love.graphics.print('WINDOW LOCK:', (love.graphics.getWidth()/2 - start.font2:getWidth( "WINDOW LOCK:" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "WINDOW LOCK:" )/2) + self.mouselockbtny)
		love.graphics.print('CREDITS', (love.graphics.getWidth()/2 - start.font2:getWidth( "CREDITS" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "CREDITS" )/2) + self.creditsbtny)
		love.graphics.print('< 1/2 >', (love.graphics.getWidth()/2 - start.font2:getWidth( "< 1/2 >" )/2) +  300, (love.graphics.getHeight()/2 - start.font2:getHeight( "< 1/2 >" )/2) + self.creditsbtny + 60)
	end










	love.graphics.print('<', (love.graphics.getWidth()/2 - 320), (love.graphics.getHeight()/2 - start.font2:getHeight( "<" )/2) + self.backy)







	

	if self.page2 == true then
		love.graphics.print('FULLSCREEN:', (love.graphics.getWidth()/2 - start.font2:getWidth( "FULLSCREEN:" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "FULLSCREEN:" )/2) + self.fpsbtny)
		love.graphics.print('CONTROLS', (love.graphics.getWidth()/2 - start.font2:getWidth( "CONTROLS" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "CONTROLS" )/2) + self.mutebtny)
		love.graphics.print('CHANGELOG', (love.graphics.getWidth()/2 - start.font2:getWidth( "CHANGELOG" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "CHANGELOG" )/2) + self.mouselockbtny)
		love.graphics.print('MORE GAMES', (love.graphics.getWidth()/2 - start.font2:getWidth( "MORE GAMES" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "MORE GAMES" )/2) + self.creditsbtny)
		love.graphics.print('< 2/2 >', (love.graphics.getWidth()/2 - start.font2:getWidth( "< 2/2 >" )/2) +  300, (love.graphics.getHeight()/2 - start.font2:getHeight( "< 2/2 >" )/2) + self.creditsbtny + 60)
	end

	if self.page2 == true then
	
		-- changes text from on and off for fullscreen
		if setfull == true then
			love.graphics.print('ON', (love.graphics.getWidth()/2 - start.font2:getWidth( "ON" )/2) + 285, (love.graphics.getHeight()/2 - start.font2:getHeight( "ON" )/2) + self.fpsbtny)
		elseif setfull == false then
			love.graphics.print('OFF', (love.graphics.getWidth()/2 - start.font2:getWidth( "OFF" )/2) + 300, (love.graphics.getHeight()/2 - start.font2:getHeight( "OFF" )/2) + self.fpsbtny)
		end
	end











	if self.page2 == false then
	
		-- changes text from on and off for fps
		if setfps == true then
			love.graphics.print('ON', (love.graphics.getWidth()/2 - start.font2:getWidth( "ON" )/2) + 285, (love.graphics.getHeight()/2 - start.font2:getHeight( "ON" )/2) + self.fpsbtny)
		elseif setfps == false then
			love.graphics.print('OFF', (love.graphics.getWidth()/2 - start.font2:getWidth( "OFF" )/2) + 300, (love.graphics.getHeight()/2 - start.font2:getHeight( "OFF" )/2) + self.fpsbtny)
		end

		-- changes text from on and off for mute
		if setmute == true then
			love.graphics.print('ON', (love.graphics.getWidth()/2 - start.font2:getWidth( "ON" )/2) + 285, (love.graphics.getHeight()/2 - start.font2:getHeight( "ON" )/2) + self.mutebtny)
		elseif setmute == false then
			love.graphics.print('OFF', (love.graphics.getWidth()/2 - start.font2:getWidth( "OFF" )/2) + 300, (love.graphics.getHeight()/2 - start.font2:getHeight( "OFF" )/2) + self.mutebtny)
		end

		-- changes text from on and off for mouselock
		if setmouselock == true then
			love.graphics.print('ON', (love.graphics.getWidth()/2 - start.font2:getWidth( "ON" )/2) + 285, (love.graphics.getHeight()/2 - start.font2:getHeight( "ON" )/2) + self.mouselockbtny)
		elseif setmouselock == false then
			love.graphics.print('OFF', (love.graphics.getWidth()/2 - start.font2:getWidth( "OFF" )/2) + 300, (love.graphics.getHeight()/2 - start.font2:getHeight( "OFF" )/2) + self.mouselockbtny)
		end
	end

	-- display verion number
	if paused == false then
		love.graphics.setFont( start.font0 )
		love.graphics.setColor(160, 47, 0)
		love.graphics.print('Pre-Alpha 0.1.1', 15, (love.graphics.getHeight() - start.font0:getHeight("Pre-Alpha 0.1.1") - 10))
		love.graphics.setColor(255, 255, 255)
	end

	love.graphics.setColor(255, 255, 255)
	------ TEXT ------
end

return options