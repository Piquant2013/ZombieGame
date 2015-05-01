-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads game script
menu = require 'menu/menu'

-- Creates menu as a new gamestate
startscreen = Gamestate.new()


function startscreen:init()

	logomovestart = 150
	textflash = 255
	starttimer = 0

	------ IMAGES ------
	self.MenuTitle = love.graphics.newImage("images/menutext.png")
	self.bg = love.graphics.newImage("images/bg.png")

	-- Sets Menu fonts and size
	self.MenuFont = love.graphics.newFont("fonts/PressStart.ttf", 30)

	MenuMusic = love.audio.newSource("audio/menumusic.ogg")
	love.audio.play(MenuMusic)
	MenuMusic:setLooping(true)

	-- Set mouse visibility to true
	love.mouse.setVisible(true)
end

function startscreen:update(dt)
	
	logomovestart = logomovestart + dt + 4

	if logomovestart > 150 then
		logomovestart = 150
	end

	starttimer = starttimer + dt
	
	if starttimer > 4 then
		textflash = 0
	end

	if starttimer > 4.5 then
		textflash = 255
		starttimer = 0
	end
end

function startscreen:keypressed(key)

	if key == " " or key == "return" then
		Gamestate.push(menu)
	end
end

function startscreen:draw()

	self.MenuTitle:setFilter( 'nearest', 'nearest' )
	self.MenuFont:setFilter( 'nearest', 'nearest' )

	love.graphics.draw(self.bg, 0, love.graphics.getHeight() - self.bg:getHeight() + 16)

	love.graphics.setFont( self.MenuFont )

	love.graphics.setColor(160, 47, 0, textflash)
	love.graphics.print('PUSH START BUTTON', (love.graphics.getWidth( )/2-self.MenuFont:getWidth("PUSH START BUTTON")/2), 480)
	
	love.graphics.setColor(160, 47, 0)
	love.graphics.print('© 2015 PIQUANT INTERACTIVE', (love.graphics.getWidth( )/2-self.MenuFont:getWidth("© 2015 PIQUANT INTERACTIVE")/2), 540)
	
	love.graphics.setColor(255, 255, 255, 255)

	love.graphics.draw(self.MenuTitle, (love.graphics.getWidth()/2 - self.MenuTitle:getWidth()/2), logomovestart)

end

return startscreen