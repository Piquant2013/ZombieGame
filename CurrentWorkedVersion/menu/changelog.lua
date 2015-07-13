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
	love.graphics.print('CHANGELOG', (love.graphics.getWidth()/2 - start.font2:getWidth( "CHANGELOG" )/2), 50)




	love.graphics.setFont( start.font1 )
	love.graphics.print('MENU', (love.graphics.getWidth()/2 - start.font2:getWidth( "MENU" )/2), 100)
	love.graphics.print('- Added back arrow to options menu', (love.graphics.getWidth()/2 - start.font2:getWidth( '- Added back arrow to options menu' )/2), 130)
	love.graphics.print('- Added second page to options', (love.graphics.getWidth()/2 - start.font2:getWidth( '- Added second page to options' )/2), 160)
	love.graphics.print('- Added change log to options', (love.graphics.getWidth()/2 - start.font2:getWidth( '- Added change log to options' )/2), 190)
	love.graphics.print('- Added controls to options', (love.graphics.getWidth()/2 - start.font2:getWidth( '- Added controls to options' )/2), 220)
	love.graphics.print('- Added fullscreen to options', (love.graphics.getWidth()/2 - start.font2:getWidth( '- Added fullscreen to options' )/2), 250)
	love.graphics.print('- Added new in-game cursor', (love.graphics.getWidth()/2 - start.font2:getWidth( '- Added new in-game cursor' )/2), 280)
	love.graphics.print('- Added "More games" to options', (love.graphics.getWidth()/2 - start.font2:getWidth( '- Added "More games" to options' )/2), 310)
	love.graphics.print('- Added mouse support for menu', (love.graphics.getWidth()/2 - start.font2:getWidth( '- Added mouse support for menu' )/2), 340)
	love.graphics.print('- Buttons slowly flash in menus if they are selected', (love.graphics.getWidth()/2 - start.font2:getWidth( '- Buttons slowly flash in menus if they are selected' )/2), 370)
	love.graphics.print('- Buttons get slightly larger if they are selected', (love.graphics.getWidth()/2 - start.font2:getWidth( '- Buttons get slightly larger if they are selected' )/2), 400)
	love.graphics.print('- "Press start button" text in gamemode welcome screens is now flashing', (love.graphics.getWidth()/2 - start.font2:getWidth( '- "Press start button" text in gamemode welcome screens is now flashing' )/2), 430)
	love.graphics.print('- Fixed credits spelling mistakes', (love.graphics.getWidth()/2 - start.font2:getWidth( '- Fixed credits spelling mistakes' )/2), 460)
	love.graphics.print('- Added Bryce to credits - "Technical Shizzle Wizzle"', (love.graphics.getWidth()/2 - start.font2:getWidth( '- Added Bryce to credits - "Technical Shizzle Wizzle"' )/2), 490)
	love.graphics.print('- Changed "Piquant Team" to Team Piquant in credits', (love.graphics.getWidth()/2 - start.font2:getWidth( '- Changed "Piquant Team" to Team Piquant in credits' )/2), 520)
	love.graphics.print('- Recentered credits', (love.graphics.getWidth()/2 - start.font2:getWidth( '- Recentered credits' )/2), 550)

	love.graphics.setColor(255, 255, 255, 255)
	------ TEXT ------
end

return changelog