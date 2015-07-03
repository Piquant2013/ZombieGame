-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates credits as a new gamestate
changelog = Gamestate.new()


function changelog:init()

	------ AUDIO ------
	self.entersound = love.audio.newSource("audio/buttons/enter.ogg")
	self.backsound = love.audio.newSource("audio/buttons/back.ogg")
	------ AUDIO ------
end

function changelog:keypressed(key)
	
	-- Takes you back to the main menu
	if key == "escape" or key == "return" or key == " " then
		Gamestate.pop()
		love.audio.play(self.backsound)
		love.audio.stop(options.entersound1)
	end
end

function changelog:update(dt)
end

function changelog:draw()
	
	------ FILTERS ------
	start.bg:setFilter( 'nearest', 'nearest' )
	start.font2:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	------ IMAGE ------
	love.graphics.draw(start.bg, 0, -1000, 0, 3)
	------ IMAGE ------

	------ TEXT ------
	love.graphics.setColor(160, 47, 0)
	love.graphics.setFont( start.font2 )
	love.graphics.print('CHANGELOG', (love.graphics.getWidth()/2 - start.font2:getWidth( "CHANGELOG" )/2), 50)
	love.graphics.setColor(255, 255, 255, 255)
	------ TEXT ------
end

return changelog