-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads menu script
menu = require 'menu/menu'

-- Creates start as a new gamestate
start = Gamestate.new()


function start:init()

	------ VARIABLES ------
	-- Start vars
	self.movelogo = 80
	self.textflash = 255
	self.flashtimer = 0

	-- Color goes here easter egg variables
	self.eggtimer = 0
	self.easteregg = false
	self.eggcount = 0
	------ VARIABLES ------

	------ IMAGES ------
	self.gamelogo = love.graphics.newImage("images/menu/gamelogo.png")
	self.bg = love.graphics.newImage("images/menu/bg.png")
	------ IMAGES ------

	------ FONTS ------
	self.font0 = love.graphics.newFont("fonts/PressStart.ttf", 15)
	self.font1 = love.graphics.newFont("fonts/PressStart.ttf", 20)
	self.font2 = love.graphics.newFont("fonts/PressStart.ttf", 30)
	self.font3 = love.graphics.newFont("fonts/PressStart.ttf", 40)
	self.font4 = love.graphics.newFont("fonts/PressStart.ttf", 50)
	self.font5 = love.graphics.newFont("fonts/PressStart.ttf", 50)
	self.font6 = love.graphics.newFont("fonts/xen3.ttf", 20)
	self.font7 = love.graphics.newFont("fonts/xen3.ttf", 25)
	self.font8 = love.graphics.newFont("fonts/PressStart.ttf", 70)
	self.font9 = love.graphics.newFont("fonts/PressStart.ttf", 12)
	------ FONTS ------
	
	------ AUDIO ------
	self.entersound = love.audio.newSource("audio/buttons/enter.ogg")
	self.music = love.audio.newSource("audio/music/menu.ogg")
	self.colorgoeshere = love.audio.newSource("audio/music/colorgoeshere.ogg")

	-- set volume
	--self.music:setVolume(musicvolume)
	--self.colorgoeshere:setVolume(musicvolume)
	------ AUDIO ------

	-- play menu music and set to loop
	love.audio.play(self.music)
	self.music:setLooping(true)

	-- Set mouse visibility to true
	love.mouse.setVisible(true)
end

function start:update(dt)

	self.entersound:setVolume(sfxvolume)
	
	--- MOVE LOGO ---
	self.movelogo = self.movelogo - dt - 4

	if self.movelogo < 80 then
		self.movelogo = 80
	end
	--- MOVE LOGO ---

	--- TEXT FLASH ---
	-- start flash timer
	self.flashtimer = self.flashtimer + dt
	
	-- flashing times
	if self.flashtimer > 4 then
		self.textflash = 0
	end

	if self.flashtimer > 4.5 then
		self.textflash = 255
		self.flashtimer = 0
	end
	--- TEXT FLASH ---

	-- if fullscreens was on before you entered a game switch it back on
	--if setfull == false and setgamefull == true then
		--setfull = true
	--end

	-- Update easter egg
	start:colorupdate(dt)
end

function start:colorupdate(dt)

-- COLOR GOES HERE EASTER EGG --
	-- Activate the easter egg
	if self.easteregg == true then
		love.audio.play(self.colorgoeshere)
		love.audio.stop(self.music)
		self.eggtimer = 0
		self.eggcount = 0
	end

	-- If egg is false stop audio
	if self.easteregg == false then
		love.audio.stop(self.colorgoeshere)
	end

	-- Starts the egg timer
	self.eggtimer = self.eggtimer + dt

	-- Reset timer if over a certain time
	if self.eggtimer > 4 then
		self.eggtimer = 0
		self.eggcount = 0
	end
	-- COLOR GOES HERE EASTER EGG --
end

function start:colorkeypressed(key)

	-- SEQUENCE FOR EASTER EGG --
	-- Starts easter eggs sequence and resets it
	if key == "c" then
		self.eggcount = self.eggcount + 1
		self.eggtimer = 0
	end

	-- Only works if pressed within time of pressing previous
	if key == "g" and self.eggcount == 1 and self.eggtimer < 2 then
		self.eggcount = self.eggcount + 1
	end

	-- Only works if pressed within time of pressing previous
	if key == "h" and self.eggcount == 2 and self.eggtimer < 4 then
		self.easteregg = true
		self.eggcount = 0
	end
	-- SEQUENCE FOR EASTER EGG --
end

function start:keypressed(key)

	-- move onto the menu script
	if key == "space" or key == "return" then
		Gamestate.push(menu)
		love.audio.play(self.entersound)
		paused = false
	end

	-- Keypressed for easter egg
	start:colorkeypressed(key)
end

function start:mousepressed(mx, my, button)

	-- move onto the menu script
	if button == 1 then
		Gamestate.push(menu)
		love.audio.play(self.entersound)
		paused = false
	end
end

function start:draw()

	------ FILTERS ------
	self.gamelogo:setFilter( 'nearest', 'nearest' )
	self.bg:setFilter( 'nearest', 'nearest' )
	self.font2:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	------ IMAGES ------
	love.graphics.draw(self.bg, -10, 0, 0, 1)
	love.graphics.draw(self.gamelogo, (love.graphics.getWidth()/2 - self.gamelogo:getWidth()/2), (love.graphics.getHeight()/2 - self.gamelogo:getHeight()/2 - self.movelogo))
	------ IMAGES ------

	------ TEXT ------
	love.graphics.setFont( self.font2 )
	love.graphics.setColor(160, 47, 0, self.textflash)
	love.graphics.print('PUSH START BUTTON', (love.graphics.getWidth( )/2-self.font2:getWidth("PUSH START BUTTON")/2), (love.graphics.getHeight( )/2 - fpsfont:getHeight( "PUSH START BUTTON" )/2 + 130))
	love.graphics.setColor(160, 47, 0)
	love.graphics.print('© 2015 PIQUANT INTERACTIVE', (love.graphics.getWidth( )/2-self.font2:getWidth("© 2015 PIQUANT INTERACTIVE")/2), (love.graphics.getHeight( )/2 - fpsfont:getHeight( "PUSH START BUTTON" )/2 + 190))
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.setFont( start.font0 )
	love.graphics.setColor(160, 47, 0)
	love.graphics.print('Pre-Alpha 0.1.3', 15, (love.graphics.getHeight() - start.font0:getHeight("Pre-Alpha 0.1.3") - 10))
	love.graphics.setColor(255, 255, 255, 255)
	------ TEXT ------
end

return start