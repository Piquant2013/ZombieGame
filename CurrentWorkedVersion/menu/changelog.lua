-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- changelog credits as a new gamestate
changelog = Gamestate.new()


function changelog:init()

	------ VARIABLES ------
	self.backpressed = false
	------ VARIABLES ------

	------ AUDIO ------
	self.entersound = love.audio.newSource("audio/buttons/enter.ogg")
	self.backsound = love.audio.newSource("audio/buttons/back.ogg")
	------ AUDIO ------
end

function changelog:update(dt)

	-- Set volume for audio
	self.entersound:setVolume(sfxvolume)
	self.backsound:setVolume(sfxvolume)

	-- Takes you back to the main menu
	if self.backpressed == true then
		Gamestate.pop()
		love.audio.play(self.backsound)
		love.audio.stop(options.entersound1)
		self.backpressed = false
	end
end

function changelog:keypressed(key)
	
	-- Takes you back to the main menu
	if key == "escape" or key == "return" or key == "space" then
		self.backpressed = true
	end
end

function changelog:mousepressed(mx, my, button)

	-- Go back to the start screen
	if button == 1 or button == 2 then
		self.backpressed = true
	end
end

function changelog:draw()

	------ IMAGE ------
	love.graphics.draw(start.bg, 0, -1000, 0, 3)
	------ IMAGE ------

	------ TEXT ------
	love.graphics.setColor(160, 47, 0)
	love.graphics.setFont( start.font2 )
	love.graphics.print('CHANGELOG', (love.graphics.getWidth()/2 - start.font2:getWidth( "CHANGELOG" )/2), 30)
	love.graphics.setFont( start.font0 )
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 90 - 15)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 115- 15)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 140- 15)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 165- 15)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 190- 15)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 215- 15)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 265- 15)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 290- 15)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 315- 15)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 365- 15)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 390- 15)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 415- 15)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 440- 15)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 465- 15)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 490- 15)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 540- 15)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 565- 15)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 590- 15)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 615- 15)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 665- 15)
	love.graphics.print('', (love.graphics.getWidth()/2 - 580), 690- 15)
	love.graphics.setColor(255, 255, 255, 255)
	------ TEXT ------
end

return changelog