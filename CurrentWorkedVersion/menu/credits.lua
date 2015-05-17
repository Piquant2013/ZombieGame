-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates credits as a new gamestate
credits = Gamestate.new()


function credits:init()
	
	------ FONTS ------
	self.CrdFont = love.graphics.newFont("fonts/PressStart.ttf", 30)

	self.bg = love.graphics.newImage("images/bg.png")

	------ AUDIO ------
	EnterCrd = love.audio.newSource("audio/enter.ogg")
	self.Select1M = love.audio.newSource("audio/sel.ogg")
	------ AUDIO ------
end

function credits:update(dt)

end

function credits:keypressed(key)
	
	-- Takes you back to the main menu
	if key == "escape" then
		
		-- Tells the game script to unload itslef and go back to previous gamestate in stack
		Gamestate.pop()

		-- Plays enter sound and stops previous enter sound
		love.audio.play(EnterCrd)
		love.audio.stop(EnterOpt)
	end
end

function credits:draw()
	
	------ FILTERS ------
	credits.CrdFont:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	------ TEXT ------
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(self.bg, 0, -1000, 0, 3)

	love.graphics.setFont( credits.CrdFont )
	love.graphics.setColor(160, 47, 0)
	love.graphics.print("PROGRAMER", (love.graphics.getWidth( )/2-credits.CrdFont:getWidth("PROGRAMER")/2), 100)
	love.graphics.print("THOMAS WILTSHIRE", (love.graphics.getWidth( )/2-credits.CrdFont:getWidth("THOMAS WILTSHIRE")/2), 150)

	love.graphics.print("MUSIC AND SOUND", (love.graphics.getWidth( )/2-credits.CrdFont:getWidth("MUSIC AND SOUND")/2), 250)
	love.graphics.print("TOBY LOWE", (love.graphics.getWidth( )/2-credits.CrdFont:getWidth("TOBY LOWE")/2), 300)

	love.graphics.print("GRAPHICS", (love.graphics.getWidth( )/2-credits.CrdFont:getWidth("GRAPHICS")/2), 400)
	love.graphics.print("THOMAS WILTSHIRE", (love.graphics.getWidth( )/2-credits.CrdFont:getWidth("THOMAS WILTSHIRE")/2), 450)

	love.graphics.print("BROUGHT TO YOU BY", (love.graphics.getWidth( )/2-credits.CrdFont:getWidth("BROUGHT TO YOU BY")/2), 550)
	love.graphics.print("PIQUANT INTERACTIVE", (love.graphics.getWidth( )/2-credits.CrdFont:getWidth("PIQUANT INTERACTIVE")/2), 600)
	love.graphics.setColor(255, 255, 225)
end

return credits