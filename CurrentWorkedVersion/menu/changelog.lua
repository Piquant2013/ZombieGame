-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- changelog credits as a new gamestate
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

function changelog:mousepressed(mx, my, button)

	-- Go back to the start screen
	if button == "l" or button == "r" then
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
	love.graphics.print('CHANGELOG', (love.graphics.getWidth()/2 - start.font2:getWidth( "CHANGELOG" )/2), 30)
	love.graphics.setFont( start.font0 )
	
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 90)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 140)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 165)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 190)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 215)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 240)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 265)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 290)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 315)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 340)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 365)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 390)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 415)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 440)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 465)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 490)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 515)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 540)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 565)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 590)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 615)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 640)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 665)
	
	love.graphics.print('', (love.graphics.getWidth()/2 + 10), 90)
	love.graphics.print('', (love.graphics.getWidth()/2 + 10), 140)
	love.graphics.print('', (love.graphics.getWidth()/2 + 10), 165)
	love.graphics.print('', (love.graphics.getWidth()/2 + 10), 215)
	love.graphics.print('', (love.graphics.getWidth()/2 + 10), 265)
	love.graphics.print('', (love.graphics.getWidth()/2 + 10), 290)
	love.graphics.print('', (love.graphics.getWidth()/2 + 10), 315)
	love.graphics.print('', (love.graphics.getWidth()/2 + 10), 340)
	love.graphics.print('', (love.graphics.getWidth()/2 + 10), 365)
	love.graphics.print('', (love.graphics.getWidth()/2 + 10), 390)
	love.graphics.print('', (love.graphics.getWidth()/2 + 10), 415)
	love.graphics.print('', (love.graphics.getWidth()/2 + 10), 440)
	love.graphics.print('', (love.graphics.getWidth()/2 + 10), 465)
	love.graphics.print('', (love.graphics.getWidth()/2 + 10), 490)
	love.graphics.print('', (love.graphics.getWidth()/2 + 10), 515)
	love.graphics.print('', (love.graphics.getWidth()/2 + 10), 540)
	love.graphics.print('', (love.graphics.getWidth()/2 + 10), 565)
	love.graphics.print('', (love.graphics.getWidth()/2 + 10), 590)
	love.graphics.print('', (love.graphics.getWidth()/2 + 10), 615)
	love.graphics.print('', (love.graphics.getWidth()/2 + 10), 640)
	love.graphics.print('', (love.graphics.getWidth()/2 + 10), 665)
	love.graphics.setColor(255, 255, 255, 255)
	------ TEXT ------
end

return changelog