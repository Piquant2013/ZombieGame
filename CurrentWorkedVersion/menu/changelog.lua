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
	
	love.graphics.print('Gameplay:', (love.graphics.getWidth()/2 - 580), 90)
	love.graphics.print('- "Endless" mode is now called', (love.graphics.getWidth()/2 - 580), 140)
	love.graphics.print('  "Arcade" mode, and vice versa.', (love.graphics.getWidth()/2 - 580), 165)
	love.graphics.print('- Added a grading system in SITM that', (love.graphics.getWidth()/2 - 580), 190)
	love.graphics.print('  works off accuracy. (“score” is now', (love.graphics.getWidth()/2 - 580), 215)
	love.graphics.print('  your kills * accuracy)', (love.graphics.getWidth()/2 - 580), 240)
	love.graphics.print('- New scoring system for Arcade.', (love.graphics.getWidth()/2 - 580), 265)
	love.graphics.print('- Changed Shield to Wave 5 onwards.', (love.graphics.getWidth()/2 - 580), 290)
	love.graphics.print('- Shield now lasts for 10 seconds.', (love.graphics.getWidth()/2 - 580), 315)
	love.graphics.print('- Shield can be used at the same time', (love.graphics.getWidth()/2 - 580), 340)
	love.graphics.print('  as other power-ups.', (love.graphics.getWidth()/2 - 580), 365)
	love.graphics.print('- Wave length now increases each wave', (love.graphics.getWidth()/2 - 580), 390)
	love.graphics.print('- Power-ups now spawn based on score.', (love.graphics.getWidth()/2 - 580), 415)
	love.graphics.print('- Power-ups can now spawn more than', (love.graphics.getWidth()/2 - 580), 440)
	love.graphics.print('  once in a wave.', (love.graphics.getWidth()/2 - 580), 465)
	love.graphics.print('- Added "1up" power-up - gives', (love.graphics.getWidth()/2 - 580), 490)
	love.graphics.print('  you an extra life.', (love.graphics.getWidth()/2 - 580), 515)
	love.graphics.print('- Added a mysterious new power-up,', (love.graphics.getWidth()/2 - 580), 540)
	love.graphics.print('  marked with a question mark.', (love.graphics.getWidth()/2 - 580), 565)
	love.graphics.print('- Continue screen now appears if', (love.graphics.getWidth()/2 - 580), 590)
	love.graphics.print('  you have an extra life.', (love.graphics.getWidth()/2 - 580), 615)
	love.graphics.print('- A shotgun now replaces the pistol', (love.graphics.getWidth()/2 - 580), 640)
	love.graphics.print('  as the default weapon past wave 10.', (love.graphics.getWidth()/2 - 580), 665)
	
	love.graphics.print('Menu:', (love.graphics.getWidth()/2 + 10), 90)
	love.graphics.print('- Changed button hitboxes to alleviate', (love.graphics.getWidth()/2 + 10), 140)
	love.graphics.print('  clicking issues.', (love.graphics.getWidth()/2 + 10), 165)
	love.graphics.print('Aesthetics and Sound:', (love.graphics.getWidth()/2 + 10), 215)
	love.graphics.print('- New UI! The HUD in-game is now a', (love.graphics.getWidth()/2 + 10), 265)
	love.graphics.print('  lot clearer and easier to understand.', (love.graphics.getWidth()/2 + 10), 290)
	love.graphics.print('  Details below...', (love.graphics.getWidth()/2 + 10), 315)
	love.graphics.print('	- Health now displays under the', (love.graphics.getWidth()/2 + 10), 340)
	love.graphics.print('	player when you are hit, disappears', (love.graphics.getWidth()/2 + 10), 365)
	love.graphics.print('	as you heal.', (love.graphics.getWidth()/2 + 10), 390)
	love.graphics.print('	- New power-up display: Power-up', (love.graphics.getWidth()/2 + 10), 415)
	love.graphics.print('	details are now displayed more', (love.graphics.getWidth()/2 + 10), 440)
	love.graphics.print('	clearly.', (love.graphics.getWidth()/2 + 10), 465)
	love.graphics.print('	- Health flashes during healing.', (love.graphics.getWidth()/2 + 10), 490)
	love.graphics.print('	- Increasing health with a power-up', (love.graphics.getWidth()/2 + 10), 515)
	love.graphics.print('	permanently adds extra health', (love.graphics.getWidth()/2 + 10), 540)
	love.graphics.print('	points and a secondary health bar.', (love.graphics.getWidth()/2 + 10), 565)
	love.graphics.print('- New look to game over screen for', (love.graphics.getWidth()/2 + 10), 590)
	love.graphics.print('  SITM.', (love.graphics.getWidth()/2 + 10), 615)
	love.graphics.print('- New music for SITM and Continue', (love.graphics.getWidth()/2 + 10), 640)
	love.graphics.print('- screen.', (love.graphics.getWidth()/2 + 10), 665)
	love.graphics.setColor(255, 255, 255, 255)
	------ TEXT ------
end

return changelog