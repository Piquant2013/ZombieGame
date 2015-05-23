-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads start script
start = require 'menu/start'

-- Creates logo as a new gamestate
logo = Gamestate.new()


function logo:init()
	
	-- Set mouse visibility to false for the logo screen
	love.mouse.setVisible(false)
	
	------ VARIABLES ------
	self.timer = 0
	self.alpha = 0
	self.fadein  = 3
	self.display = 3
	self.fadeout = 5
	------ VARIABLES ------
	
	------ IMAGES ------
	self.image = love.graphics.newImage("images/teamlogo.png")
	------ IMAGES ------

	------ AUDIO ------
	self.chime = love.audio.newSource("audio/teamchime.ogg")
	love.audio.play(self.chime)
	------ AUDIO ------
end

function logo:update(dt)
	
	-- Set audio to a lower volume for the games logo sound
	love.audio.setVolume(0.5)

	-- Start logo timer
	self.timer = self.timer + dt

	-- Fades the logo in
	if self.timer < self.fadein then 
		self.alpha = self.timer / self.fadein
	elseif self.timer < self.display then 
		self.alpha = 1
	else 
		self.alpha = 1
	end

	-- unloads logo script, moves to the start script and sets volume back to default
	if  self.timer >= 8 then
		Gamestate.switch(start)
		love.audio.setVolume(1.0)
	end	
end

function logo:keypressed(key)
	
	-- Skips to start script if pressed
	if key == "enter" or "esc" or " " then
		Gamestate.switch(start)
		love.graphics.setColor(255, 255, 255)
		love.audio.stop(self.chime)
		love.audio.setVolume(1.0)
	end 
end

function logo:draw()
	
	------ FILTERS ------
	self.image:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------
	
	-- Draw logo
	love.graphics.setColor(255, 255, 255, self.alpha * 255)
	love.graphics.draw(self.image, (love.graphics.getWidth()/2 - self.image:getWidth()/2), (love.graphics.getHeight()/2 - self.image:getHeight()/2))
end

return logo