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
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 115-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 - 580), 140-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 - 580), 165-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 - 580), 190-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 - 580), 215-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 - 580), 240-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 - 580), 265-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 - 580), 290-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 - 580), 315-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 - 580), 340-25)
	love.graphics.print('  ', (love.graphics.getWidth()/2 - 580), 360-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 - 580), 385-25)
	love.graphics.print('  ', (love.graphics.getWidth()/2 - 580), 405-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 - 580), 430-25)
	love.graphics.print('  ', (love.graphics.getWidth()/2 - 580), 450-25)
	love.graphics.print('  ', (love.graphics.getWidth()/2 - 580), 470-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 - 580), 495-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 - 580), 520-25)
	love.graphics.print('  ', (love.graphics.getWidth()/2 - 580), 540-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 - 580), 565-25)
	love.graphics.print('  ', (love.graphics.getWidth()/2 - 580), 585-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 - 580), 610-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 - 580), 635-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 - 580), 660-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 - 580), 685-25)
	love.graphics.print('', (love.graphics.getWidth()/2 + 10), 115-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 + 10), 140-25)
	love.graphics.print('  ', (love.graphics.getWidth()/2 + 10), 160-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 + 10), 185-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 + 10), 210-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 + 10), 235-25)
	love.graphics.print('  ', (love.graphics.getWidth()/2 + 10), 255-25)
	love.graphics.print('', (love.graphics.getWidth()/2 + 10), 305-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 + 10), 330-25)
	love.graphics.print('  ', (love.graphics.getWidth()/2 + 10), 350-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 + 10), 375-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 + 10), 400-25)
	love.graphics.print('  ', (love.graphics.getWidth()/2 + 10), 420-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 + 10), 445-25)
	love.graphics.print('  ', (love.graphics.getWidth()/2 + 10), 465-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 + 10), 490-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 + 10), 515-25)
	love.graphics.print('', (love.graphics.getWidth()/2 + 10), 565-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 + 10), 590-25)
	love.graphics.print('  ', (love.graphics.getWidth()/2 + 10), 610-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 + 10), 635-25)
	love.graphics.print('  ', (love.graphics.getWidth()/2 + 10), 655-25)
	love.graphics.print('- ', (love.graphics.getWidth()/2 + 10), 680-25)
	love.graphics.print('  ', (love.graphics.getWidth()/2 + 10), 700-25)
	love.graphics.setColor(255, 255, 255, 255)
	------ TEXT ------
end

return changelog