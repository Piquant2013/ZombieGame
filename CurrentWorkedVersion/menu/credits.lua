-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates credits as a new gamestate
credits = Gamestate.new()


function credits:init()
	
	------ VARIABLES ------
	self.slider = love.graphics.getHeight() + 20
	------ VARIABLES ------

	------ AUDIO ------
	self.music = love.audio.newSource("audio/music/credits.ogg")
	self.entersound = love.audio.newSource("audio/buttons/enter.ogg")
	self.backsound = love.audio.newSource("audio/buttons/back.ogg")
	------ AUDIO ------
end

function credits:keypressed(key)
	
	-- Takes you back to the main menu
	if key == "escape" or key == "return" or key == " " then
		Gamestate.pop()
		love.audio.play(self.backsound)
		love.audio.stop(options.entersound1)
		love.audio.stop(self.music)
		
		-- resume game music if its playing or play music if its not and not in pause
		if paused == false then
			love.audio.resume(start.music)
		elseif paused == true then
			love.audio.resume(game.music1)
		end

		-- resume easteregg music if its paused
		if start.easteregg == true then
			love.audio.resume(start.colorgoeshere)
		end
	end
end





function credits:mousepressed(mx, my, button)

	-- Go back to the start screen
	if button == "l" or button == "r" then
		Gamestate.pop()
		love.audio.play(self.backsound)
		love.audio.stop(options.entersound1)
		love.audio.stop(self.music)
		
		-- resume game music if its playing or play music if its not and not in pause
		if paused == false then
			love.audio.resume(start.music)
		elseif paused == true then
			love.audio.resume(game.music1)
		end

		-- resume easteregg music if its paused
		if start.easteregg == true then
			love.audio.resume(start.colorgoeshere)
		end
	end
end






function credits:update(dt)

	-- SCROLL CREDITS --
	self.slider = self.slider + dt - 1

	if self.slider < -2650 then
		self.slider = love.graphics.getHeight() + 20
	end
	-- SCROLL CREDITS --
end

function credits:draw()
	
	------ FILTERS ------
	start.gamelogo:setFilter( 'nearest', 'nearest' )
	start.bg:setFilter( 'nearest', 'nearest' )
	start.font2:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	------ IMAGES ------
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(start.bg, 0, -1000, 0, 3)
	love.graphics.draw(start.gamelogo, (love.graphics.getWidth()/2 - start.gamelogo:getWidth()/2), self.slider)
	love.graphics.setColor(160, 47, 0)
	love.graphics.draw(logo.image, (love.graphics.getWidth()/2 - 249.75), self.slider + 2350, 0 ,0.5)
	------ IMAGES ------

	------ TEXT ------
	love.graphics.setFont( start.font2 )
	love.graphics.print("PROGRAMMER", (love.graphics.getWidth( )/2-start.font2:getWidth("PROGRAMMER")/2), self.slider + 450)
	love.graphics.print("THOMAS WILTSHIRE", (love.graphics.getWidth( )/2-start.font2:getWidth("THOMAS WILTSHIRE")/2), self.slider + 500)
	love.graphics.print("MUSIC & SOUND", (love.graphics.getWidth( )/2-start.font2:getWidth("MUSIC & SOUND")/2), self.slider + 600)
	love.graphics.print("TOBY LOWE", (love.graphics.getWidth( )/2-start.font2:getWidth("TOBY LOWE")/2), self.slider + 650)
	love.graphics.print("GRAPHICS", (love.graphics.getWidth( )/2-start.font2:getWidth("GRAPHICS")/2), self.slider + 750)
	love.graphics.print("THOMAS WILTSHIRE", (love.graphics.getWidth( )/2-start.font2:getWidth("THOMAS WILTSHIRE")/2), self.slider + 800)
	love.graphics.print("TECHNICAL SHIZZLE WIZZLE", (love.graphics.getWidth( )/2-start.font2:getWidth("TECHNICAL SHIZZLE WIZZLE")/2), self.slider + 900)
	love.graphics.print("BRYCE DUNN", (love.graphics.getWidth( )/2-start.font2:getWidth("BRYCE DUNN")/2), self.slider + 950)
	love.graphics.print("PRESS START 2P FONT", (love.graphics.getWidth( )/2-start.font2:getWidth("PRESS START 2P FONT")/2), self.slider + 1050)
	love.graphics.print("CODEMAN38", (love.graphics.getWidth( )/2-start.font2:getWidth("CODEMAN38")/2), self.slider + 1100)
	love.graphics.print("HUMP LIBRARY", (love.graphics.getWidth( )/2-start.font2:getWidth("HUMP LIBRARY")/2), self.slider + 1200)
	love.graphics.print("MATTHIAS RICHTER", (love.graphics.getWidth( )/2-start.font2:getWidth("MATTHIAS RICHTER")/2), self.slider + 1250)
	love.graphics.print("HARDONCOLLIDER LIBRARY", (love.graphics.getWidth( )/2-start.font2:getWidth("HARDONCOLLIDER LIBRARY")/2), self.slider + 1350)
	love.graphics.print("MATTHIAS RICHTER", (love.graphics.getWidth( )/2-start.font2:getWidth("MATTHIAS RICHTER")/2), self.slider + 1400)
	love.graphics.print("SPECIAL THANKS", (love.graphics.getWidth( )/2-start.font2:getWidth("SPECIAL THANKS")/2), self.slider + 1500)
	love.graphics.print("WOJAK", (love.graphics.getWidth( )/2-start.font2:getWidth("WOJAK")/2), self.slider + 1550)
	love.graphics.print("TEAM PIQUANT", (love.graphics.getWidth( )/2-start.font2:getWidth("TEAM PIQUANT")/2), self.slider + 1650)
	love.graphics.print("BRYCE DUNN", (love.graphics.getWidth( )/2-start.font2:getWidth("BRYCE DUNN")/2), self.slider + 1700)
	love.graphics.print("BRAYDEN WATTS", (love.graphics.getWidth( )/2-start.font2:getWidth("BRAYDEN WATTS")/2), self.slider + 1750)
	love.graphics.print("TYRONNE CRISFIELD", (love.graphics.getWidth( )/2-start.font2:getWidth("TYRONNE CRISFIELD")/2), self.slider + 1800)
	love.graphics.print("TOBY LOWE", (love.graphics.getWidth( )/2-start.font2:getWidth("TOBY LOWE")/2), self.slider + 1850)
	love.graphics.print("THOMAS WILTSHIRE", (love.graphics.getWidth( )/2-start.font2:getWidth("THOMAS WILTSHIRE")/2), self.slider + 1900)
	love.graphics.print("CREATED WITH", (love.graphics.getWidth( )/2-start.font2:getWidth("CREATED WITH")/2), self.slider + 2000)
	love.graphics.print("LöVE (LOVE2D)", (love.graphics.getWidth( )/2-start.font2:getWidth("LöVE (LOVE2D)")/2), self.slider + 2050)
	love.graphics.print("BROUGHT TO YOU BY", (love.graphics.getWidth( )/2-start.font2:getWidth("BROUGHT TO YOU BY")/2), self.slider + 2300)
	love.graphics.setColor(255, 255, 225)
	------ TEXT ------
end

return credits