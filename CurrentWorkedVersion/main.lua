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

	------ CURSOR ------
	crosshair = love.mouse.newCursor("images/crosshair.png", 14, 14)
	cursor = love.mouse.newCursor("images/cursor.png", 2, 2)
	------ CURSOR ------

	------ GOLBAL VARIABLES ------
	setfps = false
	setmute = false
	setmouselock = false
	setfull = false
	--setgamefull = false
	setfpslock = false
	paused = false
	resume = false
	gamereset = true
	setarcade = true
	gameover = false
	welcomescreen = true
	weapon = {}
	------ GOLBAL VARIABLES ------




	mastervolume = 1
	musicvolume = 1
	sfxvolume = 1
	musicvolumelower = 0
	love.audio.setVolume(mastervolume)
	minihealthalwayson = false
	resselections = 1
	fullscreenon = false






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

	-- Set game audio to 0 if the options script tells mute to be true
	if setmute == true then
		love.audio.setVolume(0.0)
	end

	-- Set game audio back to default if the options script tells mute to be false
	if setmute == false then
		love.audio.setVolume(mastervolume)
	end

	-- Locks the cursor to the screen
	if setmouselock == true then
		love.mouse.setGrabbed( true )
	elseif setmouselock == false then
		love.mouse.setGrabbed( false )
	end

	-- Locks the fps to the screen
	if setfpslock == false then
		--frame_limiter.set(999)
		minihealthalwayson = false
	elseif setfpslock == true then
		--frame_limiter.set(60)
		minihealthalwayson = true
	end

	-- Set game fullscreen
	if setfull == true then -- cant be in update
		--love.window.setMode(1280, 720, {fullscreen=true})
	elseif setfull == false then
		--love.window.setMode(1280, 720, {fullscreen=false})
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
	love.graphics.setFont( fpsfont1 )
	
	-- Displays FPS if the options script tells FPS to be true
	if setfps == true then
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("FPS: " .. love.timer.getFPS(), (love.graphics.getWidth( ) - fpsfont:getWidth( "FPS: " .. love.timer.getFPS()) + 15), 5)
		love.graphics.setColor(255, 255, 255)
	end

	-- Displays "Mute: ON" if the options script tells mute to be true 
	if setmute == true then
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("MUTE: ON", (love.graphics.getWidth( ) - fpsfont:getWidth( "Mute: ON" ) - 100), 5)
		love.graphics.setColor(255, 255, 255)
	end
end

-- Run frame limter
frame_limiter.run()