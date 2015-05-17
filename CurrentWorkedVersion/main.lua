-- Function run for FPS limiter
function love.run() end

-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads logo script
logo = require 'logo'

-- Loads frame limiter script
frame_limiter = require 'libs/fpslimter'


function love.load()

	FPSfont = love.graphics.newFont("fonts/PressStart.ttf", 20)

	crosshair = love.mouse.newCursor("images/crosshair.png", 14, 14)

	-- FPS, Mute, Win, Deb and Mou states
	SetFPS = false
	SetMute = false
	SetWin = true
	SetMou = false
	Paused = false
	
	-- Tells game to continue onto the logo script
	Gamestate.switch(logo)
end

function love.mousepressed(mx, my, button)
	
	-- Sets up each individual script to use its own love.update, love.load, etc
	Gamestate.mousepressed(mx, my, button)
end

function love.update(dt)
	
	-- Set the frame rate limit to 60
	frame_limiter.set(60)

	-- Set game audio to 0 if the options script tells mute to be true
	if SetMute == true then
		love.audio.setVolume(0.0)
	end

	-- Set game audio back to default if the options script tells mute to be false
	if SetMute == false then
		love.audio.setVolume(1.0)
	end

	-- Locks the cursor to the screen
	if SetMou == true then
		love.mouse.setGrabbed( true )
	elseif SetMou == false then
		love.mouse.setGrabbed( false )
	end

	-- Sets if the game is in windowed mode or not
    if SetWin == false then
    	love.window.setFullscreen(true, "desktop")
    elseif SetWin == true then
    	love.window.setFullscreen(false, "desktop")
    end

	-- Sets up each individual script to use its own love.update, love.load, etc
	Gamestate.update(dt)
end

function love.keyreleased(key)
	
	-- Sets up each individual script to use its own love.update, love.load, etc
	Gamestate.keyreleased(key)
end

function love.keypressed(key)
	
	-- Sets up each individual script to use its own love.update, love.load, etc
	Gamestate.keypressed(key)
end

function love.draw()

	------ FILTERS ------
	FPSfont:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	-- Sets up each individual script to use its own love.update, love.load, etc
	Gamestate.draw()

	-- Tells FPS to use FPSfont
	love.graphics.setFont( FPSfont )
	
	-- Displays FPS if the options script tells FPS to be true
	if SetFPS == true then
		love.graphics.setColor(160, 47, 0)
		love.graphics.print("FPS: " .. love.timer.getFPS(), (love.graphics.getWidth( ) - FPSfont:getWidth( "FPS: " .. love.timer.getFPS()) - 10), 40)
		love.graphics.setColor(255, 255, 255)
	end

	-- Displays "Mute: ON" if the options script tells mute to be true 
	if SetMute == true then
		love.graphics.setColor(160, 47, 0)
		love.graphics.print("MUTE: ON", (love.graphics.getWidth( ) - FPSfont:getWidth( "Mute: ON" ) - 200), 40)
		love.graphics.setColor(255, 255, 255)
	end
end

-- Run frame limter
frame_limiter.run()