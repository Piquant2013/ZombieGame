-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads credits script
credits = require 'menu/credits'

-- Loads controls script
controls = require 'menu/controls'

-- Loads changelog script
changelog = require 'menu/changelog'

-- Loads moregames script
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
	self.mouselockbtnx = 507
	
	-- Credits Button Y & X
	self.creditsbtny = 250
	self.creditsbtnx = 550

	-- Fullscreen Button Y & X
	self.fullscreenbtny = 100
	self.fullscreenbtnx = 492
	
	-- control Button Y & X
	self.controlsbtny = 150
	self.controlsbtnx = 502
	
	-- changelog Button Y & X
	self.changelogbtny = 200
	self.changelogbtnx = 550
	
	-- moregames Button Y & X
	self.moregamesbtny = 250
	self.moregamesbtnx = 507

	-- Back button
	self.backy = 150

	-- FPS Selecter Y & X
	self.fpsarrowy = 232
	self.fpsarrowx = 665
	
	-- Mute Selecter Y & X
	self.mutearrowy = 347
	self.mutearrowx = 665

	-- MouseLock Selecter Y & X
	self.mouselockarrowy = 462
	self.mouselockarrowx = 507

	-- fullscreen Selecter Y & X
	self.fullscreenarrowy = 232
	self.fullscreenarrowx = 665

	-- Button Selecter Y & X
	self.arrowy = (self.fpsbtny)
	self.arrowx = 645

	-- Option menu states
	self.fpsstate = false
	self.mutestate = false
	self.mouselockstate = false
	self.creditsstate = false
	self.fullscreenstate = false
	self.controlsstate = false
	self.changelogstate = false
	self.moregamesstate = false

	-- page vars
	self.page2 = false
	self.pg1 = true
	self.pg2 = false

	-- Scale vars for buttons
	self.scalefps = 1
	self.scalemute = 1
	self.scalemouselock = 1
	self.scalecredits = 1
	self.scalefullscreen = 1
	self.scalecontrols = 1
	self.scalechangelog = 1
	self.scalemoregames = 1
	self.scaleback = 1
	self.scalenext = 1

	-- Flash vars for fps button
	self.flashbuttonfps = true
	self.buttonflashfps = 0

	-- Flash vars for mute button
	self.flashbuttonmute = true
	self.buttonflashmute = 0

	-- Flash vars for mouselock button
	self.flashbuttonmouselock = true
	self.buttonflashmouselock = 0

	-- Flash vars for credits button
	self.flashbuttoncredits = true
	self.buttonflashcredits = 0

	-- Flash vars for fullscreen button
	self.flashbuttonfullscreen = true
	self.buttonflashfullscreen = 0

	-- Flash vars for contorls button
	self.flashbuttoncontrols = true
	self.buttonflashcontrols = 0

	-- Flash vars for changelog button
	self.flashbuttonchangelog  = true
	self.buttonflashchangelog  = 0

	-- Flash vars for moregames button
	self.flashbuttonmoregames = true
	self.buttonflashmoregames = 0

	-- Flash vars for back button
	self.flashbuttonback = true
	self.buttonflashback = 0

	-- Flash vars for next button
	self.flashbuttonnext = true
	self.buttonflashnext = 0

	-- mouse button state
	self.fpsstatemouse = false
	self.mutestatemouse = false
	self.mouselockstatemouse = false
	self.creditsstatemouse = false
	self.fullscreenstatemouse = false
	self.controlsstatemouse = false
	self.changelogstatemouse = false
	self.moregamesstatemouse = false
	self.backstatemouse = false
	self.nextstatemouse = false

	-- Mouse Dectect vars for sound
	self.mouseover = false
	self.mouseoverback = false
	self.mouseovernext = false
	self.mousedetect1 = 0
	self.mousedetect2 = 0
	self.mousedetect3 = 0
	self.mousedetect4 = 0
	self.mousedetect5 = 0
	self.mousedetect6 = 0
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
	self.clickselect1 = love.audio.newSource("audio/buttons/select.ogg")
	self.clickselect2 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover1 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover2 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover3 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover4 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover5 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover6 = love.audio.newSource("audio/buttons/select.ogg")
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
		self.scalefps = 1.1
		self.scalemute = 1
		self.scalemouselock = 1
		self.scalecredits = 1
		self.scaleback = 1
		self.scalenext = 1
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
		self.scalefps = 1
		self.scalemute = 1.1
		self.scalemouselock = 1
		self.scalecredits = 1
		self.scaleback = 1
		self.scalenext = 1
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
		self.scalefps = 1
		self.scalemute = 1
		self.scalemouselock = 1.1
		self.scalecredits = 1
		self.scaleback = 1
		self.scalenext = 1
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
		self.scalefps = 1
		self.scalemute = 1
		self.scalemouselock = 1
		self.scalecredits = 1.1
		self.scaleback = 1
		self.scalenext = 1
	end

	-- fullscreen options menu state
	if self.arrowy == self.fullscreenbtny and self.page2 == true then
		self.arrowx = love.graphics.getWidth()/2 + 40 /2
		self.fullscreenstate = true
		self.controlsstate = false
		self.moregamesstate = false
		self.changelogstate = false
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
		love.audio.stop(self.select4)
		self.scalefullscreen = 1.1
		self.scalecontrols = 1
		self.scalechangelog = 1
		self.scalemoregames = 1
		self.scaleback = 1
		self.scalenext = 1
	end

	-- mute controls menu state
	if self.arrowy < self.changelogbtny and self.arrowy > self.fullscreenbtny and self.page2 == true then
		self.arrowx = love.graphics.getWidth()/2 + 130 /2
		self.fullscreenstate = false
		self.controlsstate = true
		self.moregamesstate = false
		self.changelogstate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
		love.audio.stop(self.select4)
		self.scalefullscreen = 1
		self.scalecontrols = 1.1
		self.scalechangelog = 1
		self.scalemoregames = 1
		self.scaleback = 1
		self.scalenext = 1
	end

	-- mouselock changelog menu state
	if self.arrowy < self.moregamesbtny and self.arrowy > self.controlsbtny and self.page2 == true then
		self.arrowx = love.graphics.getWidth()/2 + 100 /2
		self.fullscreenstate = false
		self.controlsstate = false
		self.moregamesstate = false
		self.changelogstate = true
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
		self.scalefullscreen = 1
		self.scalecontrols = 1
		self.scalechangelog = 1.1
		self.scalemoregames = 1
		self.scaleback = 1
		self.scalenext = 1
	end

	-- credits moregames menu state
	if self.arrowy == self.moregamesbtny and self.page2 == true then
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.fullscreenstate = false
		self.controlsstate = false
		self.moregamesstate = true
		self.changelogstate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select3)
		love.audio.stop(self.select4)
		self.scalefullscreen = 1
		self.scalecontrols = 1
		self.scalechangelog = 1
		self.scalemoregames = 1.1
		self.scaleback = 1
		self.scalenext = 1
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


	-- Pushes fullscreen arrow back if it trys to pass off else turn setfullscreen true or false
	if self.fullscreenarrowx > self.fullscreenbtnx then
		self.fullscreenarrowx = self.fullscreenbtnx - 118
	elseif self.fullscreenarrowx == self.fullscreenbtnx - 118 and setgamefull == true then
		setfull = false
		setgamefull = false
	elseif self.fullscreenarrowx == self.fullscreenbtnx and setgamefull == false then	
		setfull = true
		setgamefull = true
	end

	-- Set the current page
	if self.page2 == true then
		self.pg1 = false
		self.pg2 = true
	elseif self.page2 == false then
		self.pg1 = true
		self.pg2 = false
	end

	-- MOUSE AREAS --
	-- Mouse area of fps button
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 + start.font2:getWidth( "DISPLAY FPS:" )) 
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2) 
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.fpsbtny - 10) - 5
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.fpsbtny + start.font2:getHeight( "DISPLAY FPS:" )) + 5
		and self.page2 == false then
		self.fpsstatemouse = true
		self.mutestatemouse = false
		self.mouselockstatemouse = false
		self.creditsstatemouse = false
		self.backstatemouse = false
		self.nextstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 + 10 /2
		self.arrowy = self.fpsbtny
		self.scalefps = 1.1
		self.scalemute = 1
		self.scalemouselock = 1
		self.scalecredits = 1
		self.scaleback = 1
		self.scalenext = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mouseovernext = false
		self.mousedetect1 = self.mousedetect1 + 1
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = 0
		self.mousedetect5 = 0
		self.mousedetect6 = 0
	end

	-- Mouse area of mute button
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 + start.font2:getWidth( "DISPLAY FPS:" )) 
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2) 
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "MUTE AUDIO:" )/2 + self.mutebtny - 10) - 5
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "MUTE AUDIO:" )/2 + self.mutebtny + start.font2:getHeight( "MUTE AUDIO:" )) + 5
		and self.page2 == false then
		self.fpsstatemouse = false
		self.mutestatemouse = true
		self.mouselockstatemouse = false
		self.creditsstatemouse = false
		self.backstatemouse = false
		self.nextstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 + 40 /2
		self.arrowy = self.mutebtny
		self.scalefps = 1
		self.scalemute = 1.1
		self.scalemouselock = 1
		self.scalecredits = 1
		self.scaleback = 1
		self.scalenext = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mouseovernext = false
		self.mousedetect1 = 0
		self.mousedetect2 = self.mousedetect2 + 1
		self.mousedetect3 = 0
		self.mousedetect4 = 0
		self.mousedetect5 = 0
		self.mousedetect6 = 0
	end

	-- Mouse area of mouselock button
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 + start.font2:getWidth( "DISPLAY FPS:" )) 
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2) 
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "WINDOW LOCK:" )/2 + self.mouselockbtny - 10) - 5
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "WINDOW LOCK:" )/2 + self.mouselockbtny + start.font2:getHeight( "WINDOW LOCK:" )) + 5
		and self.page2 == false then
		self.fpsstatemouse = false
		self.mutestatemouse = false
		self.mouselockstatemouse = true
		self.creditsstatemouse = false
		self.backstatemouse = false
		self.nextstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 + 10 /2
		self.arrowy = self.mouselockbtny
		self.scalefps = 1
		self.scalemute = 1
		self.scalemouselock = 1.1
		self.scalecredits = 1
		self.scaleback = 1
		self.scalenext = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mouseovernext = false
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = self.mousedetect3 + 1
		self.mousedetect4 = 0
		self.mousedetect5 = 0
		self.mousedetect6 = 0
	end

	-- Mouse area of credits button
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 + start.font2:getWidth( "DISPLAY FPS:" )) 
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2) 
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "CREDITS" )/2 + self.creditsbtny - 10) - 5
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "CREDITS" )/2 + self.creditsbtny + start.font2:getHeight( "CREDITS" )) + 5
		and self.page2 == false then
		self.fpsstatemouse = false
		self.mutestatemouse = false
		self.mouselockstatemouse = false
		self.creditsstatemouse = true
		self.backstatemouse = false
		self.nextstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 + 170 /2
		self.arrowy = self.creditsbtny
		self.scalefps = 1
		self.scalemute = 1
		self.scalemouselock = 1
		self.scalecredits = 1.1
		self.scaleback = 1
		self.scalenext = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mouseovernext = false
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = self.mousedetect4 + 1
		self.mousedetect5 = 0
		self.mousedetect6 = 0
	end

	-- Mouse area of fullscreen button
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "FULLSCREEN:" )/2 + start.font2:getWidth( "FULLSCREEN:" )) 
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "FULLSCREEN:" )/2) 
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "FULLSCREEN:" )/2 + self.fpsbtny - 10) - 5
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "FULLSCREEN:" )/2 + self.fpsbtny + start.font2:getHeight( "FULLSCREEN:" )) + 5
		and self.page2 == true then
		self.fullscreenstatemouse = true
		self.controlsstatemouse = false
		self.changelogstatemouse = false
		self.moregamesstatemouse = false
		self.backstatemouse = false
		self.nextstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 + 40 /2
		self.arrowy = self.fullscreenbtny
		self.scalefullscreen = 1.1
		self.scalecontrols = 1
		self.scalechangelog = 1
		self.scalemoregames = 1
		self.scaleback = 1
		self.scalenext = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mouseovernext = false
		self.mousedetect1 = self.mousedetect1 + 1
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = 0
		self.mousedetect5 = 0
		self.mousedetect6 = 0
	end

	-- Mouse area of controls button
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "FULLSCREEN:" )/2 + start.font2:getWidth( "FULLSCREEN:" )) 
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "FULLSCREEN:" )/2) 
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "CONTROLS" )/2 + self.mutebtny - 10) - 5
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "CONTROLS" )/2 + self.mutebtny + start.font2:getHeight( "CONTROLS" )) + 5
		and self.page2 == true then
		self.fullscreenstatemouse = false
		self.controlsstatemouse = true
		self.changelogstatemouse = false
		self.moregamesstatemouse = false
		self.backstatemouse = false
		self.nextstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 + 130 /2
		self.arrowy = self.controlsbtny
		self.scalefullscreen = 1
		self.scalecontrols = 1.1
		self.scalechangelog = 1
		self.scalemoregames = 1
		self.scaleback = 1
		self.scalenext = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mouseovernext = false
		self.mousedetect1 = 0
		self.mousedetect2 = self.mousedetect2 + 1
		self.mousedetect3 = 0
		self.mousedetect4 = 0
		self.mousedetect5 = 0
		self.mousedetect6 = 0
	end

	-- Mouse area of changelog button
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "FULLSCREEN:" )/2 + start.font2:getWidth( "FULLSCREEN:" )) 
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "FULLSCREEN:" )/2) 
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "CHANGELOG" )/2 + self.mouselockbtny - 10) - 5
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "CHANGELOG" )/2 + self.mouselockbtny + start.font2:getHeight( "CHANGELOG" )) + 5
		and self.page2 == true then
		self.fullscreenstatemouse = false
		self.controlsstatemouse = false
		self.changelogstatemouse = true
		self.moregamesstatemouse = false
		self.backstatemouse = false
		self.nextstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 + 100 /2
		self.arrowy = self.changelogbtny
		self.scalefullscreen = 1
		self.scalecontrols = 1
		self.scalechangelog = 1.1
		self.scalemoregames = 1
		self.scaleback = 1
		self.scalenext = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mouseovernext = false
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = self.mousedetect3 + 1
		self.mousedetect4 = 0
		self.mousedetect5 = 0
		self.mousedetect6 = 0
	end

	-- Mouse area of moregames button
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "FULLSCREEN:" )/2 + start.font2:getWidth( "FULLSCREEN:" )) 
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "FULLSCREEN:" )/2) 
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "MORE GAMES" )/2 + self.creditsbtny - 10) - 5
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "MORE GAMES" )/2 + self.creditsbtny + start.font2:getHeight( "MORE GAMES" )) + 5 
		and self.page2 == true then
		self.fullscreenstatemouse = false
		self.controlsstatemouse = false
		self.changelogstatemouse = false
		self.moregamesstatemouse = true
		self.backstatemouse = false
		self.nextstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.arrowy = self.moregamesbtny
		self.scalefullscreen = 1
		self.scalecontrols = 1
		self.scalechangelog = 1
		self.scalemoregames = 1.1
		self.scaleback = 1
		self.scalenext = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mouseovernext = false
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = self.mousedetect4 + 1
		self.mousedetect5 = 0
		self.mousedetect6 = 0
	end

	-- Mouse area of back button
	if love.mouse.getX() < (love.graphics.getWidth()/2 - 300 - start.font2:getWidth( "<" )/2 + start.font2:getWidth( "<" ) + 30) 
		and love.mouse.getX() > (love.graphics.getWidth()/2 - 300 - start.font2:getWidth( "<" )/2 - 40) 
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "<" )/2 + self.backy - 40) 
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "<" )/2 + self.backy) + start.font2:getHeight( "<" ) + 30 then
		self.fpsstatemouse = false
		self.mutestatemouse = false
		self.mouselockstatemouse = false
		self.creditsstatemouse = false
		self.fullscreenstatemouse = false
		self.controlsstatemouse = false
		self.changelogstatemouse = false
		self.moregamesstatemouse = false
		self.backstatemouse = true
		self.nextstatemouse = false
		self.scaleback = 1.4
		self.scalenext = 1
		self.mouseover = false
		self.mouseovernext = false
		self.mouseoverback = true
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = 0
		self.mousedetect5 = self.mousedetect5 + 1
		self.mousedetect6 = 0
	end

	-- Mouse area of next button
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "< 1/2 >" )/2 +  300 + start.font2:getWidth( "< 1/2 >" )) + 30 
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "< 1/2 >" )/2 +  300) - 40 
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "< 1/2 >" )/2 + self.creditsbtny + 50) - 20 
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "< 1/2 >" )/2 + self.creditsbtny + 60 + start.font2:getHeight( "< 1/2 >" )) + 30 then
		self.fpsstatemouse = false
		self.mutestatemouse = false
		self.mouselockstatemouse = false
		self.creditsstatemouse = false
		self.fullscreenstatemouse = false
		self.controlsstatemouse = false
		self.changelogstatemouse = false
		self.moregamesstatemouse = false
		self.backstatemouse = false
		self.nextstatemouse = true
		self.scaleback = 1
		self.scalenext = 1.1
		self.mouseover = false
		self.mouseovernext = true
		self.mouseoverback = false
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = 0
		self.mousedetect5 = 0
		self.mousedetect6 = self.mousedetect6 + 1
	end
	-- MOUSE AREAS --

	-- MOUSE OUT OF AREA --
	-- Out of areas for the page 1 buttons
	if love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 + start.font2:getWidth( "DISPLAY FPS:" )) and self.page2 == false then
		self.fpsstatemouse = false
		self.mutestatemouse = false
		self.mouselockstatemouse = false
		self.creditsstatemouse = false
		self.mouseover = false
	end
	
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2) and self.page2 == false then
		self.fpsstatemouse = false
		self.mutestatemouse = false
		self.mouselockstatemouse = false
		self.creditsstatemouse = false
		self.mouseover = false
	end
	
	if love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.fpsbtny - 10) - 5 and self.page2 == false then
		self.fpsstatemouse = false
		self.mutestatemouse = false
		self.mouselockstatemouse = false
		self.creditsstatemouse = false
		self.mouseover = false
	end

	if love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "CREDITS" )/2 + self.creditsbtny + start.font2:getHeight( "CREDITS" )) + 5 and self.page2 == false then
		self.fpsstatemouse = false
		self.mutestatemouse = false
		self.mouselockstatemouse = false
		self.creditsstatemouse = false
		self.mouseover = false
	end
	
	-- Out of areas for the page 2 buttons
	if love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "FULLSCREEN:" )/2 + start.font2:getWidth( "FULLSCREEN:" )) and self.page2 == true then
		self.fullscreenstatemouse = false
		self.controlsstatemouse = false
		self.changelogstatemouse = false
		self.moregamesstatemouse = false
		self.mouseover = false
	end
	
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "FULLSCREEN:" )/2) and self.page2 == true then
		self.fullscreenstatemouse = false
		self.controlsstatemouse = false
		self.changelogstatemouse = false
		self.moregamesstatemouse = false
		self.mouseover = false
	end
	
	if love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "FULLSCREEN:" )/2 + self.fpsbtny - 10) - 5 and self.page2 == true then
		self.fullscreenstatemouse = false
		self.controlsstatemouse = false
		self.changelogstatemouse = false
		self.moregamesstatemouse = false
		self.mouseover = false
	end

	if love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "MORE GAMES" )/2 + self.creditsbtny + start.font2:getHeight( "MORE GAMES" )) + 5  and self.page2 == true then
		self.fullscreenstatemouse = false
		self.controlsstatemouse = false
		self.changelogstatemouse = false
		self.moregamesstatemouse = false
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

	-- Out of areas for the next button
	if love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "< 1/2 >" )/2 +  300 + start.font2:getWidth( "< 1/2 >" )) + 30 then
		self.nextstatemouse = false
		self.mouseovernext = false
		self.scalenext = 1
	end 
	
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "< 1/2 >" )/2 +  300) - 40 then
		self.nextstatemouse = false
		self.mouseovernext = false
		self.scalenext = 1
	end

	if love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "< 1/2 >" )/2 + self.creditsbtny + 50) - 20 then
		self.nextstatemouse = false
		self.mouseovernext = false
		self.scalenext = 1
	end 

	if love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "< 1/2 >" )/2 + self.creditsbtny + 60 + start.font2:getHeight( "< 1/2 >" )) + 30 then
		self.nextstatemouse = false
		self.mouseovernext = false
		self.scalenext = 1
	end
	-- MOUSE OUT OF AREA --

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

	-- Flashing for the mute button
	if self.mutestatemouse == true or self.mutestate == true then
		
		if self.flashbuttonmute == true then
			self.buttonflashmute = self.buttonflashmute + dt + 2
		elseif self.flashbuttonmute == false then
			self.buttonflashmute = self.buttonflashmute + dt - 2
		end
	
		if self.buttonflashmute > 100 then
			self.flashbuttonmute = false
		elseif self.buttonflashmute < 2 then
			self.flashbuttonmute = true
		end
	
	elseif self.mutestatemouse == false or self.mutestate == false then
		self.flashbuttonmute = true
		self.buttonflashmute = 0
	end

	-- Flashing for the mouselock button
	if self.mouselockstatemouse == true or self.mouselockstate == true then
		
		if self.flashbuttonmouselock == true then
			self.buttonflashmouselock = self.buttonflashmouselock + dt + 2
		elseif self.flashbuttonmouselock == false then
			self.buttonflashmouselock = self.buttonflashmouselock + dt - 2
		end
	
		if self.buttonflashmouselock > 100 then
			self.flashbuttonmouselock = false
		elseif self.buttonflashmouselock < 2 then
			self.flashbuttonmouselock = true
		end
	
	elseif self.mouselockstatemouse == false or self.mouselockstate == false then
		self.flashbuttonmouselock = true
		self.buttonflashmouselock = 0
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

	-- Flashing for the fullscreen button
	if self.fullscreenstatemouse == true or self.fullscreenstate == true then
		
		if self.flashbuttonfullscreen == true then
			self.buttonflashfullscreen = self.buttonflashfullscreen + dt + 2
		elseif self.flashbuttonfullscreen == false then
			self.buttonflashfullscreen = self.buttonflashfullscreen + dt - 2
		end
	
		if self.buttonflashfullscreen > 100 then
			self.flashbuttonfullscreen = false
		elseif self.buttonflashfullscreen < 2 then
			self.flashbuttonfullscreen = true
		end
	
	elseif self.fullscreenstatemouse == false or self.fullscreenstate == false then
		self.flashbuttonfullscreen = true
		self.buttonflashfullscreen = 0
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

	-- Flashing for the changelog button
	if self.changelogstatemouse == true or self.changelogstate == true then
		
		if self.flashbuttonchangelog == true then
			self.buttonflashchangelog = self.buttonflashchangelog + dt + 2
		elseif self.flashbuttonchangelog == false then
			self.buttonflashchangelog = self.buttonflashchangelog + dt - 2
		end
	
		if self.buttonflashchangelog > 100 then
			self.flashbuttonchangelog = false
		elseif self.buttonflashchangelog < 2 then
			self.flashbuttonchangelog = true
		end
	
	elseif self.changelogstatemouse == false or self.changelogstate == false then
		self.flashbuttonchangelog = true
		self.buttonflashchangelog = 0
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

	-- Flashing for the next button
	if self.nextstatemouse == true then
		
		if self.flashbuttonnext == true then
			self.buttonflashnext = self.buttonflashnext + dt + 2
		elseif self.flashbuttonnext == false then
			self.buttonflashnext = self.buttonflashnext + dt - 2
		end
	
		if self.buttonflashnext > 100 then
			self.flashbuttonnext = false
		elseif self.buttonflashnext < 2 then
			self.flashbuttonnext = true
		end
	
	elseif self.nextstatemouse == false then
		self.flashbuttonnext = true
		self.buttonflashnext = 0
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

	if self.mouseovernext == false then
		self.mousedetect6 = 0
		love.audio.stop(self.mouseover6)
	end

	if self.mousedetect1 == 1 then
		love.audio.play(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.stop(self.mouseover4)
		love.audio.stop(self.mouseover5)
		love.audio.stop(self.mouseover6)
	end

	if self.mousedetect2 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.play(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.stop(self.mouseover4)
		love.audio.stop(self.mouseover5)
		love.audio.stop(self.mouseover6)
	end

	if self.mousedetect3 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.play(self.mouseover3)
		love.audio.stop(self.mouseover4)
		love.audio.stop(self.mouseover5)
		love.audio.stop(self.mouseover6)
	end

	if self.mousedetect4 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.play(self.mouseover4)
		love.audio.stop(self.mouseover5)
		love.audio.stop(self.mouseover6)
	end

	if self.mousedetect5 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.stop(self.mouseover4)
		love.audio.play(self.mouseover5)
		love.audio.stop(self.mouseover6)
	end

	if self.mousedetect6 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.stop(self.mouseover4)
		love.audio.stop(self.mouseover5)
		love.audio.play(self.mouseover6)
	end
	-- MOUSE DECTECTS --
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

		if self.mouseover == true then
			love.mouse.setX((love.graphics.getWidth()/2 - 459/2) + 500)
		end 
	end

	-- Move arrow up through options menu states
	if key == "down" or key == "s" then
		love.audio.play(self.select1)
		love.audio.play(self.select2)
		love.audio.play(self.select3)
		love.audio.play(self.select4)
		self.arrowy = self.arrowy + 50

		if self.mouseover == true then
			love.mouse.setX((love.graphics.getWidth()/2 - 459/2) + 500)
		end 
	end

	-- Go to right page
	if key == "right" and self.page2 == false or key == "d" and self.page2 == false then
		love.audio.play(self.select5)
		love.audio.stop(self.select6)
		self.page2 = true
	end

	-- go to left page
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

	-- set fullscreen on or off
	if key == "return" and self.fullscreenstate == true and self.page2 == true or key == " " and self.fullscreenstate == true and self.page2 == true then
		self.fullscreenarrowx = self.fullscreenarrowx + 118
	end

	-- set controls on or off
	if key == "return" and self.controlsstate == true and self.page2 == true or key == " " and self.controlsstate == true and self.page2 == true then
		Gamestate.push(controls)
	end

	-- set changelog on or off
	if key == "return" and self.changelogstate == true and self.page2 == true or key == " " and self.changelogstate == true and self.page2 == true then
		Gamestate.push(changelog)
	end

	-- go to moregames screen
	if key == "return" and self.moregamesstate == true and self.page2 == true or key == " " and self.moregamesstate == true and self.page2 == true then
		Gamestate.push(moregames)
	end

	-- Plays audio for fullscreen On & Off buttons
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

function options:mousepressed(mx, my, button)
	-- go to credits screen
	if button == "l" and self.creditsstatemouse == true and self.page2 == false then
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
	if button == "l" and self.fpsstatemouse == true and self.page2 == false then
		self.fpsarrowx = self.fpsarrowx + 118
	end

	-- set mute on or off
	if button == "l" and self.mutestatemouse == true and self.page2 == false then
		self.mutearrowx = self.mutearrowx + 118
	end

	-- set mouselock on or off
	if button == "l" and self.mouselockstatemouse == true and self.page2 == false then
		self.mouselockarrowx = self.mouselockarrowx + 118
	end

	-- Plays audio for FPS On & Off buttons
	if button == "l" and setfps == true and self.page2 == false and self.mouseover == true then
		love.audio.play(self.entersound1)
		love.audio.stop(self.entersound1a)
	elseif button == "l" and setfps == false and self.page2 == false and self.mouseover == true then
		love.audio.play(self.entersound1a)
		love.audio.stop(self.entersound1)
	end 

	-- Plays audio for mouselock On & Off buttons
	if button == "l" and setmouselock == true and self.page2 == false and self.mouseover == true then
		love.audio.play(self.entersound2a)
		love.audio.stop(self.entersound2)
	elseif button == "l" and setmouselock == false and self.page2 == false and self.mouseover == true then
		love.audio.play(self.entersound2)
		love.audio.stop(self.entersound2a)
	end

	-- set fullscreen on or off
	if button == "l" and self.fullscreenstatemouse == true and self.page2 == true then
		self.fullscreenarrowx = self.fullscreenarrowx + 118
	end

	-- set controls on or off
	if button == "l" and self.controlsstatemouse == true and self.page2 == true then
		Gamestate.push(controls)
	end

	-- set changelog on or off
	if button == "l" and self.changelogstatemouse == true and self.page2 == true then
		Gamestate.push(changelog)
	end

	-- go to credits screen
	if button == "l" and self.moregamesstatemouse == true and self.page2 == true then
		Gamestate.push(moregames)
	end

	-- Plays audio for fullscreen On & Off buttons
	if button == "l" and setfull == true and self.page2 == true and self.mouseover == true then
		love.audio.play(self.entersound3)
		love.audio.stop(self.entersound3a)
	elseif button == "l" and setfull == false and self.page2 == true and self.mouseover == true then
		love.audio.play(self.entersound3a)
		love.audio.stop(self.entersound3)
	end

	-- go to next page
	if button == "l" and self.mouseovernext == true and self.pg2 == false and self.mouseover == false then
		love.audio.stop(self.clickselect1)
		love.audio.play(self.clickselect2)
		self.page2 = true
	end

	-- go back a page
	if button == "l" and self.mouseovernext == true and self.pg1 == false and self.mouseover == false then
		love.audio.play(self.clickselect1)
		love.audio.stop(self.clickselect2)
		self.page2 = false
	end

	-- Go back to the start screen
	if button == "l" and self.backstatemouse == true and self.mouseover == false then
		Gamestate.pop()
		love.audio.play(self.backsound)
	end

	-- Go back to the start screen
	if button == "r" then
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
	if self.page2 == false then
		
		-- draw page 1 options
		love.graphics.setFont( start.font2 )
		love.graphics.print('DISPLAY FPS:', (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2) + self.fpsbtny, 0, self.scalefps)
		love.graphics.setColor(255, 255, 255, self.buttonflashfps)
		love.graphics.print('DISPLAY FPS:', (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2) + self.fpsbtny, 0, self.scalefps)
		love.graphics.setColor(160, 47, 0, 255)
		love.graphics.print('MUTE AUDIO:', (love.graphics.getWidth()/2 - start.font2:getWidth( "MUTE AUDIO:" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "MUTE AUDIO:" )/2) + self.mutebtny, 0, self.scalemute)
		love.graphics.setColor(255, 255, 255, self.buttonflashmute)
		love.graphics.print('MUTE AUDIO:', (love.graphics.getWidth()/2 - start.font2:getWidth( "MUTE AUDIO:" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "MUTE AUDIO:" )/2) + self.mutebtny, 0, self.scalemute)
		love.graphics.setColor(160, 47, 0, 255)
		love.graphics.print('WINDOW LOCK:', (love.graphics.getWidth()/2 - start.font2:getWidth( "WINDOW LOCK:" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "WINDOW LOCK:" )/2) + self.mouselockbtny, 0, self.scalemouselock)
		love.graphics.setColor(255, 255, 255, self.buttonflashmouselock)
		love.graphics.print('WINDOW LOCK:', (love.graphics.getWidth()/2 - start.font2:getWidth( "WINDOW LOCK:" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "WINDOW LOCK:" )/2) + self.mouselockbtny, 0, self.scalemouselock)
		love.graphics.setColor(160, 47, 0, 255)
		love.graphics.print('CREDITS', (love.graphics.getWidth()/2 - start.font2:getWidth( "CREDITS" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "CREDITS" )/2) + self.creditsbtny, 0, self.scalecredits)
		love.graphics.setColor(255, 255, 255, self.buttonflashcredits)
		love.graphics.print('CREDITS', (love.graphics.getWidth()/2 - start.font2:getWidth( "CREDITS" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "CREDITS" )/2) + self.creditsbtny, 0, self.scalecredits)
		love.graphics.setColor(160, 47, 0, 255)
		love.graphics.print('< 1/2 >', (love.graphics.getWidth()/2 - start.font2:getWidth( "< 1/2 >" )/2) +  300, (love.graphics.getHeight()/2 - start.font2:getHeight( "< 1/2 >" )/2) + self.creditsbtny + 60, 0, self.scalenext)
		love.graphics.setColor(255, 255, 255, self.buttonflashnext)
		love.graphics.print('< 1/2 >', (love.graphics.getWidth()/2 - start.font2:getWidth( "< 1/2 >" )/2) +  300, (love.graphics.getHeight()/2 - start.font2:getHeight( "< 1/2 >" )/2) + self.creditsbtny + 60, 0, self.scalenext)
		love.graphics.setColor(160, 47, 0, 255)

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
	
	elseif self.page2 == true then
		
		-- draw page 2 options
		love.graphics.setFont( start.font2 )
		love.graphics.print('FULLSCREEN:', (love.graphics.getWidth()/2 - start.font2:getWidth( "FULLSCREEN:" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "FULLSCREEN:" )/2) + self.fpsbtny, 0, self.scalefullscreen)
		love.graphics.setColor(255, 255, 255, self.buttonflashfullscreen)
		love.graphics.print('FULLSCREEN:', (love.graphics.getWidth()/2 - start.font2:getWidth( "FULLSCREEN:" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "FULLSCREEN:" )/2) + self.fpsbtny, 0, self.scalefullscreen)
		love.graphics.setColor(160, 47, 0, 255)
		love.graphics.print('CONTROLS', (love.graphics.getWidth()/2 - start.font2:getWidth( "CONTROLS" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "CONTROLS" )/2) + self.mutebtny, 0, self.scalecontrols)
		love.graphics.setColor(255, 255, 255, self.buttonflashcontrols)
		love.graphics.print('CONTROLS', (love.graphics.getWidth()/2 - start.font2:getWidth( "CONTROLS" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "CONTROLS" )/2) + self.mutebtny, 0, self.scalecontrols)
		love.graphics.setColor(160, 47, 0, 255)
		love.graphics.print('CHANGELOG', (love.graphics.getWidth()/2 - start.font2:getWidth( "CHANGELOG" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "CHANGELOG" )/2) + self.mouselockbtny, 0, self.scalechangelog)
		love.graphics.setColor(255, 255, 255, self.buttonflashchangelog)
		love.graphics.print('CHANGELOG', (love.graphics.getWidth()/2 - start.font2:getWidth( "CHANGELOG" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "CHANGELOG" )/2) + self.mouselockbtny, 0, self.scalechangelog)
		love.graphics.setColor(160, 47, 0, 255)
		love.graphics.print('MORE GAMES', (love.graphics.getWidth()/2 - start.font2:getWidth( "MORE GAMES" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "MORE GAMES" )/2) + self.creditsbtny, 0, self.scalemoregames)
		love.graphics.setColor(255, 255, 255, self.buttonflashmoregames)
		love.graphics.print('MORE GAMES', (love.graphics.getWidth()/2 - start.font2:getWidth( "MORE GAMES" )/2), (love.graphics.getHeight()/2 - start.font2:getHeight( "MORE GAMES" )/2) + self.creditsbtny, 0, self.scalemoregames)
		love.graphics.setColor(160, 47, 0, 255)
		love.graphics.print('< 2/2 >', (love.graphics.getWidth()/2 - start.font2:getWidth( "< 2/2 >" )/2) +  300, (love.graphics.getHeight()/2 - start.font2:getHeight( "< 2/2 >" )/2) + self.creditsbtny + 60, 0, self.scalenext)
		love.graphics.setColor(255, 255, 255, self.buttonflashnext)
		love.graphics.print('< 2/2 >', (love.graphics.getWidth()/2 - start.font2:getWidth( "< 2/2 >" )/2) +  300, (love.graphics.getHeight()/2 - start.font2:getHeight( "< 2/2 >" )/2) + self.creditsbtny + 60, 0, self.scalenext)
		love.graphics.setColor(160, 47, 0, 255)
	
		-- changes text from on and off for fullscreen
		if setfull == true then
			love.graphics.print('ON', (love.graphics.getWidth()/2 - start.font2:getWidth( "ON" )/2) + 285, (love.graphics.getHeight()/2 - start.font2:getHeight( "ON" )/2) + self.fpsbtny)
		elseif setfull == false then
			love.graphics.print('OFF', (love.graphics.getWidth()/2 - start.font2:getWidth( "OFF" )/2) + 300, (love.graphics.getHeight()/2 - start.font2:getHeight( "OFF" )/2) + self.fpsbtny)
		end
	end

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
		love.graphics.print('Pre-Alpha 0.1.2', 15, (love.graphics.getHeight() - start.font0:getHeight("Pre-Alpha 0.1.1") - 10))
		love.graphics.setColor(255, 255, 255)
	end
	------ TEXT ------
end

return options