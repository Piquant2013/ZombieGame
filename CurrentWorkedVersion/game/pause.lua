-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates pause as a new gamestate
pause = Gamestate.new()


function pause:init()
  
  	------ VARIABLES ------
  	-- What state the pause menu is in
  	Resume = false

	-- Resume Button Y & X 
	self.ResumeBtnY = 300
	self.ResumeBtnX = 548
 
	-- Main menu Button Y & X  
	self.MainMenuBtnY = 400
	self.MainMenuBtnX = 476

	-- Main menu Button Y & X  
	self.OptionsBtnY = 350
	self.OptionsBtnX = 512
 
	-- Pause menu state  
	self.ResumeState = false
	self.OptionsState = false
	self.MainMenuState = false

	-- Button Selecter Y & X 
	self.ArrowY = (pause.ResumeBtnY)
	self.ArrowX = 450
  
	------ FONTS ------
	self.PauseFont = love.graphics.newFont("fonts/PressStart.ttf", 30)
	------ FONTS ------

	self.bg = love.graphics.newImage("images/bg.png")

	------ AUDIO ------
	self.Enter = love.audio.newSource("audio/enter.ogg")
	self.Select1 = love.audio.newSource("audio/sel.ogg")
	self.Select2 = love.audio.newSource("audio/sel.ogg")
	self.Select3 = love.audio.newSource("audio/sel.ogg")
	PauseMusic = love.audio.newSource("audio/pausemusic.ogg")
	------ AUDIO ------
end

function pause:keypressed(key)

	------ SELECT BUTTONS ------
	-- Moves arrow up and down through pause states
	if key == "up" or key == "w" then
		love.audio.play(pause.Select1)
		love.audio.play(pause.Select2)
		love.audio.play(pause.Select3)
		pause.ArrowY = pause.ArrowY - 50
	end

	if key == "down" or key == "s" then
		love.audio.play(pause.Select1)
		love.audio.play(pause.Select2)
		love.audio.play(pause.Select3)
		pause.ArrowY = pause.ArrowY + 50
	end
	------ SELECT BUTTONS ------
 
 	------ ACTIVATE BUTTONS ------
	-- Tells pause menu to resume game script
	if key == "return" and pause.ResumeState == true or key == " " and pause.ResumeState == true then
		
		-- play sound effect for enter
		love.audio.play(pause.Enter)
		
		-- Changes the pause state
		Resume = true
	end

	if key == "return" and pause.OptionsState == true or key == " " and pause.OptionsState == true then
		
		-- play sound effect for enter
		love.audio.play(pause.Enter)
		
		-- Tells the pause menu script to switch to the options script
		Gamestate.push(options)
	end
  
	if key == "return" and pause.MainMenuState == true or key == " " and pause.MainMenuState == true then
		
		-- play sound effect for enter
		love.audio.play(pause.Enter)

		-- Reset the game
		GameReset = true
		Paused = false
		game.Welcome = true
		
		-- Tells the pause menu script to switch to the menu script
		Gamestate.switch(menu)
		
		-- Stops pause menu music and plays menu music
		love.audio.play(MenuMusic)
		MenuMusic:setLooping(true)
		love.audio.stop(PauseMusic)
		love.audio.stop(GameMusic)
	end
	------ ACTIVATE BUTTONS ------

	-- Tells pause menu to resume game script
	if key == 'escape' then
		
		-- Changes the pause state
		Resume = true
	end
end

function pause:update(dt)

	-- Plays pause music on loop and pauses game music
	if Resume == false then
		love.audio.play(PauseMusic)
		PauseMusic:setLooping(true)
		love.audio.pause(GameMusic)
		love.mouse.setCursor(cursor)
	end

	-- Switches back to the game script
	if Resume == true then
		
		-- Tells the pause menu script to switch to the game script
		Gamestate.switch(game)
		
		-- Sets pause menu to off
		Paused = false
		
		-- Sets cursor back
		love.mouse.setCursor(crosshair)

		-- Stops pause menu music and plays menu music
		love.audio.resume(GameMusic)
		GameMusic:setLooping(true)
		love.audio.stop(PauseMusic)
	end 

	-- PAUSE STATES
	if pause.ArrowY == pause.ResumeBtnY then
		self.ArrowX = love.graphics.getWidth()/2 - 320 /2
		pause.ResumeState = true
		pause.MainMenuState = false
		pause.OptionsState = false
		love.audio.stop(pause.Select1)
		love.audio.stop(pause.Select2)
	end

	if pause.ArrowY == pause.MainMenuBtnY then
		self.ArrowX = love.graphics.getWidth()/2 - 260 /2
		pause.ResumeState = false
		pause.MainMenuState = true
		pause.OptionsState = false
		love.audio.stop(pause.Select1)
		love.audio.stop(pause.Select3)
	end

	if pause.ArrowY < pause.MainMenuBtnY and pause.ArrowY > pause.ResumeBtnY then
		self.ArrowX = love.graphics.getWidth()/2 - 380 /2
		pause.ArrowY = pause.OptionsBtnY
		pause.ResumeState = false
		pause.MainMenuState = false
		pause.OptionsState = true
		love.audio.stop(pause.Select2)
		love.audio.stop(pause.Select3)
	end
	-- PAUSE STATES

	-- Anything between the "PAUSE STATES" comments:
	-- This piece of code is everything that tells the pause menu what state it is at

  
  	-- Makes sure the arrow doesnt go past resume or main menu
	if pause.ArrowY > pause.MainMenuBtnY then
		pause.ArrowY = pause.MainMenuBtnY
	end

	if pause.ArrowY < pause.ResumeBtnY then
		pause.ArrowY = pause.ResumeBtnY
	end
end

function pause:draw()
	
	------ FILTERS ------
	pause.PauseFont:setFilter( 'nearest', 'nearest' )
	FPSfont:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	love.graphics.draw(self.bg, 0, -1000, 0, 3)

	-- Tells Menu to use PauseFont
	love.graphics.setFont( pause.PauseFont )
	love.graphics.setColor(160, 47, 0)
		

	love.graphics.rectangle("fill", self.ArrowX, pause.ArrowY - 8, 28, 28 )

	------ TEXT ------
	love.graphics.print('RESUME', (love.graphics.getWidth()/2 - pause.PauseFont:getWidth( "RESUME" )/2), pause.ResumeBtnY)
	love.graphics.print('SETTINGS', (love.graphics.getWidth()/2 - pause.PauseFont:getWidth( "SETTINGS" )/2), pause.OptionsBtnY)
	love.graphics.print('MENU', (love.graphics.getWidth()/2 - pause.PauseFont:getWidth( "MENU" )/2), pause.MainMenuBtnY)
	
	love.graphics.setColor(255, 255, 255)
end

return pause