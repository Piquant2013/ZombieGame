-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Controls credits as a new gamestate
controls = Gamestate.new()


function controls:init()
	
	------ IMAGES ------
	self.image = love.graphics.newImage("images/menu/controls.png")
	------ IMAGES ------

	------ AUDIO ------
	self.entersound = love.audio.newSource("audio/buttons/enter.ogg")
	self.backsound = love.audio.newSource("audio/buttons/back.ogg")
	------ AUDIO ------
end

function controls:keypressed(key)
	
	-- Takes you back to the main menu
	if key == "escape" or key == "return" or key == " " then
		Gamestate.pop()
		love.audio.play(self.backsound)
		love.audio.stop(options.entersound1)
	end
end

function controls:mousepressed(mx, my, button)

	-- Go back to the start screen
	if button == "l" or button == "r" then
		Gamestate.pop()
		love.audio.play(self.backsound)
		love.audio.stop(options.entersound1)
	end
end

function controls:update(dt)
end

function controls:draw()
	
	------ FILTERS ------
	start.bg:setFilter( 'nearest', 'nearest' )
	start.font2:setFilter( 'nearest', 'nearest' )
	self.image:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	------ IMAGE ------
	love.graphics.draw(start.bg, 0, -1000, 0, 3)
	love.graphics.draw(self.image, (love.graphics.getWidth()/2 - 1074/2), (love.graphics.getHeight()/2 - 400/2), 0, 0.3)
	------ IMAGE ------

	------ TEXT ------
	love.graphics.setColor(160, 47, 0)
	love.graphics.setFont( start.font2 )
	love.graphics.print('CONTROLS', (love.graphics.getWidth()/2 - start.font2:getWidth( "CONTROLS" )/2), 50)
	love.graphics.setColor(255, 255, 255, 255)
	------ TEXT ------
end

return controls