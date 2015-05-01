-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates options as a new gamestate
options = Gamestate.new()

-- Loads credits script
credits = require 'menu/credits'


function options:init()


	self.bg = love.graphics.newImage("images/bg.png")

	------ AUDIO ------
	EnterOpt = love.audio.newSource("audio/enter.ogg")
	self.EnterOpt1 = love.audio.newSource("audio/enter.ogg")
	self.EnterOpt1a = love.audio.newSource("audio/enter.ogg")
	self.EnterOpt2 = love.audio.newSource("audio/enter.ogg")
	self.EnterOpt2a = love.audio.newSource("audio/enter.ogg")
	self.EnterOpt3 = love.audio.newSource("audio/enter.ogg")
	self.EnterOpt3a = love.audio.newSource("audio/enter.ogg")
	self.EnterOpt4 = love.audio.newSource("audio/enter.ogg")
	self.EnterOpt4a = love.audio.newSource("audio/enter.ogg")
	self.Select1 = love.audio.newSource("audio/sel.ogg")
	self.Select2 = love.audio.newSource("audio/sel.ogg")
	self.Select3 = love.audio.newSource("audio/sel.ogg")
	self.Select4 = love.audio.newSource("audio/sel.ogg")
	self.Select5 = love.audio.newSource("audio/sel.ogg")
	self.Select6 = love.audio.newSource("audio/sel.ogg")
	self.Select7 = love.audio.newSource("audio/sel.ogg")
	self.Select8 = love.audio.newSource("audio/sel.ogg")
	self.Select9 = love.audio.newSource("audio/sel.ogg")
	self.Select10 = love.audio.newSource("audio/sel.ogg")
	self.Select11 = love.audio.newSource("audio/sel.ogg")
	------ AUDIO ------

	------ VARIABLES ------
	-- Option menu state
	self.FPSState = false
	self.MuteState = false
	self.ChgState = false
	self.CrdState = false
	self.WinState = false
	self.DebState = false
	self.MouState = false
	self.ConState = false
	self.BackState = false

	-- FPS Button Y & X
	self.FPSBtnY = 242
	
	-- Mute Button Y & X
	self.MuteBtnY = 292

	-- Mouse Lock Button Y & X
	self.MouBtnY = 342

	-- Windowed Mode Button Y & X
	self.WinBtnY = 392

	-- Credits Button Y & X
	self.CrdBtnY = 442


	self.FPSBtnX = 492

	self.MuteBtnX = 502

	self.CrdBtnX = 550

	self.WinBtnX = 492

	self.MouBtnX = 507



	-- Button Selecter Y & X
	self.OptArrowY = (self.FPSBtnY)
	self.OptArrowX = 480

	-- FPS Selecter Y & X
	self.FPSArrowY = 232
	self.FPSArrowX = 665

	-- FPS On & Off Button Y & X
	self.FPSOnOffY = 232
	self.FPSOnOffX = 647
	
	-- Mute Selecter Y & X
	self.MuteArrowY = 347
	self.MuteArrowX = 665

	-- Mute On & Off Button Y & X
	self.MuteOnOffY = 347
	self.MuteOnOffX = 647

	-- Windowed Mode Selecter Y & X
	self.WinArrowY = 232
	self.WinArrowX = 665

	-- Mouse Lock Selecter Y & X
	self.MouArrowY = 462
	self.MouArrowX = 665

	-- Sets Menu font and size
	self.OptFont = love.graphics.newFont("fonts/PressStart.ttf", 30)
end

function options:update(dt)
	
	-- OPTION MENU STATES
	if options.OptArrowY == options.FPSBtnY then
		self.OptArrowX = love.graphics.getWidth()/2 + 10 /2
		options.FPSState = true
		options.MuteState = false
		options.CrdState = false
		options.WinState = false
		options.MouState = false
		love.audio.stop(options.Select1)
		love.audio.stop(options.Select2)
		love.audio.stop(options.Select3)
		love.audio.stop(options.Select4)
		love.audio.stop(options.Select6)
		love.audio.stop(options.Select7)
		love.audio.stop(options.Select8)
		love.audio.stop(options.Select9)
	end

	if options.OptArrowY == options.CrdBtnY then
		self.OptArrowX = love.graphics.getWidth()/2 + 170 /2
		options.FPSState = false
		options.MuteState = false
		options.CrdState = true
		options.WinState = false
		options.MouState = false
		love.audio.stop(options.Select1)
		love.audio.stop(options.Select2)
		love.audio.stop(options.Select4)
		love.audio.stop(options.Select5)
		love.audio.stop(options.Select6)
		love.audio.stop(options.Select7)
		love.audio.stop(options.Select8)
		love.audio.stop(options.Select9)
	end

	if options.OptArrowY < options.MouBtnY and options.OptArrowY > options.FPSBtnY then
		self.OptArrowX = love.graphics.getWidth()/2 + 40 /2
		options.FPSState = false
		options.MuteState = true
		options.CrdState = false
		options.WinState = false
		options.MouState = false
		love.audio.stop(options.Select2)
		love.audio.stop(options.Select3)
		love.audio.stop(options.Select4)
		love.audio.stop(options.Select5)
		love.audio.stop(options.Select6)
		love.audio.stop(options.Select7)
		love.audio.stop(options.Select8)
		love.audio.stop(options.Select9)
	end

	if options.OptArrowY < options.CrdBtnY and options.OptArrowY > options.MouBtnY then
		self.OptArrowX = love.graphics.getWidth()/2 - 50 /2
		options.FPSState = false
		options.MuteState = false
		options.CrdState = false
		options.WinState = true
		options.MouState = false
		love.audio.stop(options.Select1)
		love.audio.stop(options.Select2)
		love.audio.stop(options.Select3)
		love.audio.stop(options.Select4)
		love.audio.stop(options.Select5)
		love.audio.stop(options.Select7)
		love.audio.stop(options.Select8)
		love.audio.stop(options.Select9)
	end
	
	if options.OptArrowY < options.WinBtnY and options.OptArrowY > options.MuteBtnY then
		self.OptArrowX = love.graphics.getWidth()/2 + 10 /2
		options.FPSState = false
		options.MuteState = false
		options.CrdState = false
		options.WinState = false
		options.MouState = true
		love.audio.stop(options.Select1)
		love.audio.stop(options.Select2)
		love.audio.stop(options.Select3)
		love.audio.stop(options.Select4)
		love.audio.stop(options.Select5)
		love.audio.stop(options.Select6)
		love.audio.stop(options.Select7)
		love.audio.stop(options.Select9)
	end

	-- Makes sure the arrow doesnt go past FPS
	if options.OptArrowY < options.FPSBtnY then
		options.OptArrowY = options.FPSBtnY
	end

	if options.OptArrowY > options.CrdBtnY then
		options.OptArrowY = options.CrdBtnY
	end




	-- Pushes FPS arrow back if it trys to pass off
	if options.FPSArrowX > options.FPSBtnX then
		options.FPSArrowX = options.FPSBtnX - 118
	end

	-- Sets FPS to Off
	if options.FPSArrowX == options.FPSBtnX - 118 then
		SetFPS = false
	end

	-- Sets FPS to On
	if options.FPSArrowX == options.FPSBtnX then	
		SetFPS = true
	end

	-- Pushes Mute arrow back if it trys to pass off
	if options.MuteArrowX > options.MuteBtnX then
		options.MuteArrowX = options.MuteBtnX - 118
	end

	-- Sets Mute to Off
	if options.MuteArrowX == options.MuteBtnX - 118 then
		SetMute = false
	end

	-- Sets Mute to On
	if options.MuteArrowX == options.MuteBtnX then	
		SetMute = true
	end

	-- Pushes Win arrow back if it trys to pass off
	if options.WinArrowX > options.WinBtnX then
		options.WinArrowX = options.WinBtnX - 118
	end

	-- Sets Win to Off
	if options.WinArrowX == options.WinBtnX - 118 then
		SetWin = true
	end

	-- Sets Win to On
	if options.WinArrowX == options.WinBtnX then	
		SetWin = false
	end

	-- Pushes Mou arrow back if it trys to pass off
	if options.MouArrowX > options.MouBtnX then
		options.MouArrowX = options.MouBtnX - 118
	end

	-- Sets Mou to Off
	if options.MouArrowX == options.MouBtnX - 118 then
		SetMou = false
	end

	-- Sets Mou to On
	if options.MouArrowX == options.MouBtnX then	
		SetMou = true
	end
end

function options:keypressed(key)
	
	------ SELECT BUTTONS ------
	-- Moves arrow up and down through option menu states
	if key == "up" or key == "w" then
		love.audio.play(options.Select1)
		love.audio.play(options.Select2)
		love.audio.play(options.Select3)
		love.audio.play(options.Select4)
		love.audio.play(options.Select5)
		love.audio.play(options.Select6)
		love.audio.play(options.Select7)
		love.audio.play(options.Select8)
		love.audio.play(options.Select9)
		options.OptArrowY = options.OptArrowY - 50
	end

	if key == "down" or key == "s" then
		love.audio.play(options.Select1)
		love.audio.play(options.Select2)
		love.audio.play(options.Select3)
		love.audio.play(options.Select4)
		love.audio.play(options.Select5)
		love.audio.play(options.Select6)
		love.audio.play(options.Select7)
		love.audio.play(options.Select8)
		love.audio.play(options.Select9)
		options.OptArrowY = options.OptArrowY + 50
	end

	if key == "escape" then
		Gamestate.pop()
		love.audio.play(EnterOpt)
	end

	-- If the arrow is on credits and return is true then display credits
	if key == "return" and options.CrdState == true then
		Gamestate.push(credits)
		love.audio.play(EnterOpt)
		love.audio.stop(EnterCrd)
	end


	-- If the arrow is on FPS and return is true then move FPS On & Off arrow
	if key == "return" and options.FPSState == true then
		options.FPSArrowX = options.FPSArrowX + 118
	end

	-- If the arrow is on Mute and return is true then move Mute On & Off arrow
	if key == "return" and options.MuteState == true then
		options.MuteArrowX = options.MuteArrowX + 118
	end

	-- If the arrow is on Win and return is true then move Win On & Off arrow
	if key == "return" and options.WinState == true then
		options.WinArrowX = options.WinArrowX + 118
	end

	-- If the arrow is on Mou and return is true then move Mou On & Off arrow
	if key == "return" and options.MouState == true then
		options.MouArrowX = options.MouArrowX + 118
	end

	-- Plays audio for FPS On & Off buttons
	if key == "return" and SetFPS == true then
		love.audio.play(options.EnterOpt1)
		love.audio.stop(options.EnterOpt1a)
	end

	if key == "return" and SetFPS == false then
		love.audio.play(options.EnterOpt1a)
		love.audio.stop(options.EnterOpt1)
	end 

	-- Plays audio for Win On & Off buttons
	if key == "return" and SetWin == true then
		love.audio.play(options.EnterOpt2)
		love.audio.stop(options.EnterOpt2a)
	end

	if key == "return" and SetWin == false then
		love.audio.play(options.EnterOpt2a)
		love.audio.stop(options.EnterOpt2)
	end

	-- Plays audio for Mou On & Off buttons
	if key == "return" and SetMou == true then
		love.audio.play(options.EnterOpt4)
		love.audio.stop(options.EnterOpt4a)
	end

	if key == "return" and SetMou == false then
		love.audio.play(options.EnterOpt4a)
		love.audio.stop(options.EnterOpt4)
	end
end

function options:draw()

	options.OptFont:setFilter( 'nearest', 'nearest' )
	FPSfont:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	if Paused == false then
		love.graphics.draw(self.bg, 0, love.graphics.getHeight() - self.bg:getHeight() + 16)
	end

	love.graphics.setColor(160, 47, 0)

	------ SHAPES ------
	love.graphics.rectangle("fill", options.OptArrowX - 250, options.OptArrowY - 8, 28, 28 )

	love.graphics.setFont( options.OptFont )

	love.graphics.print('DISPLAY FPS:', (love.graphics.getWidth()/2 - options.OptFont:getWidth( "DISPLAY FPS:" )/2), options.FPSBtnY)
	love.graphics.print('MUTE AUDIO:', (love.graphics.getWidth()/2 - options.OptFont:getWidth( "MUTE AUDIO:" )/2), options.MuteBtnY)
	love.graphics.print('WINDOW LOCK:', (love.graphics.getWidth()/2 - options.OptFont:getWidth( "WINDOW LOCK:" )/2), options.MouBtnY)
	love.graphics.print('WINDOWED MODE:', (love.graphics.getWidth()/2 - options.OptFont:getWidth( "WINDOWED MODE:" )/2), options.WinBtnY)
	love.graphics.print('CREDITS', (love.graphics.getWidth()/2 - options.OptFont:getWidth( "CREDITS" )/2), options.CrdBtnY)

	-- Puts the fade on the On & Off buttons for FPS
	if SetFPS == true then
		love.graphics.print('ON', (love.graphics.getWidth()/2 - options.OptFont:getWidth( "ON" )/2) + 285, options.FPSBtnY)
	end

	if SetFPS == false then
		love.graphics.print('OFF', (love.graphics.getWidth()/2 - options.OptFont:getWidth( "OFF" )/2) + 300, options.FPSBtnY)
	end

	-- Puts the fade on the On & Off buttons for Mute
	if SetMute == true then
		love.graphics.print('ON', (love.graphics.getWidth()/2 - options.OptFont:getWidth( "ON" )/2) + 285, options.MuteBtnY)
	end

	if SetMute == false then
		love.graphics.print('OFF', (love.graphics.getWidth()/2 - options.OptFont:getWidth( "OFF" )/2) + 300, options.MuteBtnY)
	end

	-- Puts the fade on the On & Off buttons for Win
	if SetWin == true then
		love.graphics.print('ON', (love.graphics.getWidth()/2 - options.OptFont:getWidth( "ON" )/2) + 285, options.WinBtnY)
	end

	if SetWin == false then
		love.graphics.print('OFF', (love.graphics.getWidth()/2 - options.OptFont:getWidth( "OFF" )/2) + 300, options.WinBtnY)
	end

	-- Puts the fade on the On & Off buttons for Mou
	if SetMou == true then
		love.graphics.print('ON', (love.graphics.getWidth()/2 - options.OptFont:getWidth( "ON" )/2) + 285, options.MouBtnY)
	end

	if SetMou == false then
		love.graphics.print('OFF', (love.graphics.getWidth()/2 - options.OptFont:getWidth( "OFF" )/2) + 300, options.MouBtnY)
	end

	love.graphics.setColor(255, 255, 255)

	--love.graphics.draw(menu.MenuTitle, (love.graphics.getWidth()/2 - menu.MenuTitle:getWidth()/2), 100)
end

return options