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
	fpsfont1 = love.graphics.newFont("fonts/xen3.ttf", 20)
	------ FONTS ------

	------ FILTERS ------
	fpsfont:setFilter( 'nearest', 'nearest' )
	fpsfont1:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	------ CURSOR ------
	crosshair = love.mouse.newCursor("images/crosshair.png", 14, 14)
	cursor = love.mouse.newCursor("images/cursor.png", 2, 2)
	------ CURSOR ------

	------ GOLBAL VARIABLES ------
	setfps = false
	setmute = false
	setmouselock = false
	setfull = false
	setfpslock = false
	paused = false
	resume = false
	gamereset = true
	setarcade = true
	setendless = true
	gameover = false
	welcomescreen = true
	mastervolume = 1
	musicvolume = 1
	sfxvolume = 1
	musicvolumelower = 0
	resselections = 1
	fullscreenon = false
	minihealthalwayson = false
	weapon = {}
	------ GOLBAL VARIABLES ------

	-- set master volume
	love.audio.setVolume(mastervolume)

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

	-- Unmute and mute audio
	if setmute == true then
		love.audio.setVolume(0.0)
	elseif setmute == false then
		love.audio.setVolume(mastervolume)
	end

	-- Locks the cursor to the screen
	if setmouselock == true then
		love.mouse.setGrabbed( true )
	elseif setmouselock == false then
		love.mouse.setGrabbed( false )
	end

	-- keep mini hud on or off
	if setfpslock == false then
		minihealthalwayson = false
	elseif setfpslock == true then
		minihealthalwayson = true
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

	-- Sets up each individual script to use its own love.update, love.load, etc
	Gamestate.draw()
	
	-- Displays FPS if the options script tells FPS to be true
	if setfps == true then
		love.graphics.setFont( fpsfont1 )
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("FPS: " .. love.timer.getFPS(), (love.graphics.getWidth( ) - fpsfont:getWidth( "FPS: " .. love.timer.getFPS()) + 15), 5)
	end
end

-- Run frame limter
frame_limiter.run()