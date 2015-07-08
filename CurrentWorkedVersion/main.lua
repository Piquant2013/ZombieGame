-- Function run for FPS limiter
function love.run() end

-- Loads gamestate script
Gamestate = require 'libs/hump/gamestate'

-- Loads logo script
logo = require 'logo'

-- Loads frame limiter script
frame_limiter = require 'libs/fpslimter'


function love.load()

	------ FONTS ------
	fpsfont = love.graphics.newFont("fonts/PressStart.ttf", 15)
	------ FONTS ------

	------ CURSOR ------
	crosshair = love.mouse.newCursor("images/crosshair.png", 14, 14)
	cursor = love.mouse.newCursor("images/cursor.png", 2, 2)
	------ CURSOR ------

	------ GOLBAL VARIABLES ------
	setfps = false
	setmute = false
	setmouselock = true
	setfull = false
	paused = false
	resume = false
	gamereset = true
	setendless = true
	gameover = false
	welcomescreen = true
	weapon = {}
	------ GOLBAL VARIABLES ------

	-- Set system cursor
	love.mouse.setCursor(cursor)
	
	-- Tells game to start with the logo script
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
	if setmute == true then
		love.audio.setVolume(0.0)
	end

	-- Set game audio back to default if the options script tells mute to be false
	if setmute == false then
		love.audio.setVolume(1.0)
	end

	-- Locks the cursor to the screen
	if setmouselock == true then
		love.mouse.setGrabbed( true )
	elseif setmouselock == false then
		love.mouse.setGrabbed( false )
	end

	-- Set game fullscreen
	if setfull == true then
		love.window.setFullscreen(true, "desktop")
	elseif setfull == false then
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
	fpsfont:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	-- Sets up each individual script to use its own love.update, love.load, etc
	Gamestate.draw()

	-- Set font for fps and mute
	love.graphics.setFont( fpsfont )
	
	-- Displays FPS if the options script tells FPS to be true
	if setfps == true then
		love.graphics.setColor(160, 47, 0)
		love.graphics.print("FPS: " .. love.timer.getFPS(), (love.graphics.getWidth( ) - fpsfont:getWidth( "FPS: " .. love.timer.getFPS()) - 15), (love.graphics.getHeight( ) - fpsfont:getHeight(  "FPS: " .. love.timer.getFPS()) - 10))
		love.graphics.setColor(255, 255, 255)
	end

	-- Displays "Mute: ON" if the options script tells mute to be true 
	if setmute == true then
		love.graphics.setColor(160, 47, 0)
		love.graphics.print("MUTE: ON", (love.graphics.getWidth( ) - fpsfont:getWidth( "Mute: ON" ) - 150), (love.graphics.getHeight( ) - fpsfont:getHeight( "Mute: ON" ) - 10))
		love.graphics.setColor(255, 255, 255)
	end
end

-- Run frame limter
frame_limiter.run()