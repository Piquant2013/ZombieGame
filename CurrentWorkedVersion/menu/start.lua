-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads menu script
menu = require 'menu/menu'

-- Creates start as a new gamestate
start = Gamestate.new()


function start:init()

	------ VARIABLES ------
	self.movelogo = 150
	self.textflash = 255
	self.flashtimer = 0
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
	------ FONTS ------
	
	------ AUDIO ------
	self.entersound = love.audio.newSource("audio/buttons/enter.ogg")
	self.music = love.audio.newSource("audio/music/menu.ogg")
	------ AUDIO ------

	-- play menu music and set to loop
	love.audio.play(self.music)
	self.music:setLooping(true)

	-- Set mouse visibility to true
	love.mouse.setVisible(true)
end

function start:update(dt)
	
	--- MOVE LOGO ---
	self.movelogo = self.movelogo + dt + 4

	if self.movelogo > 150 then
		self.movelogo = 150
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
end

function start:keypressed(key)

	-- move onto the menu script
	if key == " " or key == "return" then
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
	love.graphics.draw(self.gamelogo, (love.graphics.getWidth()/2 - self.gamelogo:getWidth()/2), self.movelogo)
	------ IMAGES ------

	------ TEXT ------
	love.graphics.setFont( self.font2 )
	love.graphics.setColor(160, 47, 0, self.textflash)
	love.graphics.print('PUSH START BUTTON', (love.graphics.getWidth( )/2-self.font2:getWidth("PUSH START BUTTON")/2), 480)
	love.graphics.setColor(160, 47, 0)
	love.graphics.print('© 2015 PIQUANT INTERACTIVE', (love.graphics.getWidth( )/2-self.font2:getWidth("© 2015 PIQUANT INTERACTIVE")/2), 540)
	love.graphics.setColor(255, 255, 255, 255)
	------ TEXT ------
end

return start