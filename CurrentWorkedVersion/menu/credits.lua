-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates credits as a new gamestate
credits = Gamestate.new()


function credits:init()
	
	------ VARIABLES ------
	self.slider = 740
	------ VARIABLES ------

	------ AUDIO ------
	self.music = love.audio.newSource("audio/music/credits.ogg")
	self.entersound = love.audio.newSource("audio/buttons/enter.ogg")
	------ AUDIO ------
end

function credits:keypressed(key)
	
	-- Takes you back to the main menu
	if key == "escape" or key == "return" or key == " " then
		Gamestate.pop()
		love.audio.play(self.entersound)
		love.audio.stop(options.entersound1)
		love.audio.stop(self.music)
		love.audio.play(start.music)
	end
end

function credits:update(dt)

	-- SCROLL CREDITS --
	self.slider = self.slider + dt - 1

	if self.slider < -2450 then
		self.slider = 740
	end
	-- SCROLL CREDITS --
end

function credits:draw()
	
	------ FILTERS ------
	start.gamelogo:setFilter( 'nearest', 'nearest' )
	start.bg:setFilter( 'nearest', 'nearest' )
	start.font:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	------ IMAGES ------
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(start.bg, 0, -1000, 0, 3)
	love.graphics.draw(start.gamelogo, (love.graphics.getWidth()/2 - start.gamelogo:getWidth()/2), self.slider)
	love.graphics.setColor(160, 47, 0)
	love.graphics.draw(logo.image, (love.graphics.getWidth()/2 - 249.75), self.slider + 2150, 0 ,0.5)
	------ IMAGES ------

	------ TEXT ------
	love.graphics.setFont( start.font )
	love.graphics.print("PROGRAMER", (love.graphics.getWidth( )/2-start.font:getWidth("PROGRAMER")/2), self.slider + 450)
	love.graphics.print("THOMAS WILTSHIRE", (love.graphics.getWidth( )/2-start.font:getWidth("THOMAS WILTSHIRE")/2), self.slider + 500)
	love.graphics.print("MUSIC & SOUND", (love.graphics.getWidth( )/2-start.font:getWidth("MUSIC & SOUND")/2), self.slider + 600)
	love.graphics.print("TOBY LOWE", (love.graphics.getWidth( )/2-start.font:getWidth("TOBY LOWE")/2), self.slider + 650)
	love.graphics.print("GRAPHICS", (love.graphics.getWidth( )/2-start.font:getWidth("GRAPHICS")/2), self.slider + 750)
	love.graphics.print("THOMAS WILTSHIRE", (love.graphics.getWidth( )/2-start.font:getWidth("THOMAS WILTSHIRE")/2), self.slider + 800)
	love.graphics.print("PRESS START 2P FONT", (love.graphics.getWidth( )/2-start.font:getWidth("PRESS START 2P FONT")/2), self.slider + 900)
	love.graphics.print("CODEMAN38", (love.graphics.getWidth( )/2-start.font:getWidth("CODEMAN38")/2), self.slider + 950)
	love.graphics.print("HUMP LIBRARY", (love.graphics.getWidth( )/2-start.font:getWidth("HUMP LIBRARY")/2), self.slider + 1050)
	love.graphics.print("MATTHIAS RICHTER", (love.graphics.getWidth( )/2-start.font:getWidth("MATTHIAS RICHTER")/2), self.slider + 1100)
	love.graphics.print("HARDONCOLLIDER LIBRARY", (love.graphics.getWidth( )/2-start.font:getWidth("HARDONCOLLIDER LIBRARY")/2), self.slider + 1200)
	love.graphics.print("MATTHIAS RICHTER", (love.graphics.getWidth( )/2-start.font:getWidth("MATTHIAS RICHTER")/2), self.slider + 1250)
	love.graphics.print("SPECIAL THANKS", (love.graphics.getWidth( )/2-start.font:getWidth("SPECIAL THANKS")/2), self.slider + 1350)
	love.graphics.print("WOJAK", (love.graphics.getWidth( )/2-start.font:getWidth("WOJAK")/2), self.slider + 1400)
	love.graphics.print("PIQUANT TEAM", (love.graphics.getWidth( )/2-start.font:getWidth("PIQUANT TEAM")/2), self.slider + 1500)
	love.graphics.print("BRYCE DUNN", (love.graphics.getWidth( )/2-start.font:getWidth("BRYCE DUNN")/2), self.slider + 1550)
	love.graphics.print("TYRONNE CRISFIELD", (love.graphics.getWidth( )/2-start.font:getWidth("TTYRONNE CRISFIELD")/2), self.slider + 1600)
	love.graphics.print("TOBY LOWE", (love.graphics.getWidth( )/2-start.font:getWidth("TOBY LOWE")/2), self.slider + 1650)
	love.graphics.print("THOMAS WILTSHIRE", (love.graphics.getWidth( )/2-start.font:getWidth("THOMAS WILTSHIRE")/2), self.slider + 1700)
	love.graphics.print("CREATED WITH", (love.graphics.getWidth( )/2-start.font:getWidth("CREATED WITH")/2), self.slider + 1800)
	love.graphics.print("LöVE (LOVE2D)", (love.graphics.getWidth( )/2-start.font:getWidth("LöVE (LOVE2D)")/2), self.slider + 1850)
	love.graphics.print("BROUGHT TO YOU BY", (love.graphics.getWidth( )/2-start.font:getWidth("BROUGHT TO YOU BY")/2), self.slider + 2100)
	love.graphics.setColor(255, 255, 225)
	------ TEXT ------
end

return credits