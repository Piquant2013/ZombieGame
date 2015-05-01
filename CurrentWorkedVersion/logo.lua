-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates logo as a new gamestate
logo = Gamestate.new()

-- Loads menu script
startscreen = require 'menu/startscreen'


function logo:init()
	
	-- Set mouse visibility to false
	love.mouse.setVisible(false)
	
	------ VARIABLES ------
	self.Timer = 0
	self.Alpha = 0
	self.Fadein  = 3
	self.Display = 3
	self.Fadeout = 5
	------ VARIABLES ------
	
	------ IMAGES ------
	self.PiquantLogo = love.graphics.newImage("images/hdlogo.png")
	------ IMAGES ------

	------ AUDIO ------
	self.LogoChime = love.audio.newSource("audio/logochime.ogg")
	love.audio.play(logo.LogoChime)
	------ AUDIO ------
end

function logo:update(dt)
	
	-- Set audio to a lower volume for the games boot sound
	love.audio.setVolume(0.5)

	-- Start logo timer
	logo.Timer = logo.Timer + dt

	-- Fades the logo in
	if logo.Timer < logo.Fadein then logo.Alpha = logo.Timer / logo.Fadein
		elseif logo.Timer < logo.Display then logo.Alpha = 1
		else logo.Alpha = 1
	end

	-- unloads logo script, moves to the menu script and sets volume back to default
	if  logo.Timer >= 8 then
		Gamestate.switch(startscreen)
		love.audio.setVolume(1.0)
	end	
end

function logo:keypressed(key)
	
	-- Skips to menu script if pressed
	if key == "enter" or "esc" or " " then
		Gamestate.switch(startscreen)
		love.graphics.setColor(255, 255, 255)
		love.audio.stop(logo.LogoChime)
		love.audio.setVolume(1.0)
	end 
end

function logo:draw()
	
	------ FILTERS ------
	logo.PiquantLogo:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------
	
	-- Draw logo
	love.graphics.setColor(255, 255, 255, logo.Alpha * 255)
	love.graphics.draw(logo.PiquantLogo, (love.graphics.getWidth()/2 - logo.PiquantLogo:getWidth()/2), (love.graphics.getHeight()/2 - logo.PiquantLogo:getHeight()/2))
end

return logo