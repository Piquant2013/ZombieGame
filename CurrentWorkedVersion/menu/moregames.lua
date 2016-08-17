-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates moregames as a new gamestate
moregames = Gamestate.new()


function moregames:init()

	------ VARIABLES ------
	-- Scale vars for buttons
	self.scalenext = 1
	self.scaleback = 1

	-- Flash vars for next button
	self.flashbuttonnext = true
	self.buttonflashnext = 0

	-- Flash vars for back button
	self.flashbuttonback = true
	self.buttonflashback = 0

	-- mouse button state
	self.nextstatemouse = false
	self.backstatemouse = false

	-- Mouse Dectect vars for sound
	self.mouseovernext = false
	self.mouseoverback = false
	self.mousedetect1 = 0
	self.mousedetect2 = 0

	-- Page vars
	self.space = true
	self.dig = false
	self.page2 = false

	-- button pressed vars
	self.rightpressed = false
	self.leftpressed = false
	self.backpressed = false
	------ VARIABLES ------

	------ IMAGES ------
	self.logodig = love.graphics.newImage("images/menu/logodig.png")
	self.screendig = love.graphics.newImage("images/menu/screendig.png")
	self.logospace = love.graphics.newImage("images/menu/logospace.png")
	self.screenspace1 = love.graphics.newImage("images/menu/screenspace1.png")
	self.screenspace2 = love.graphics.newImage("images/menu/screenspace2.png")
	self.spacebg = love.graphics.newImage("images/menu/spacebg.png")
	------ IMAGES ------

	------ FILTERS ------
	self.logospace:setFilter( 'nearest', 'nearest' )
	self.logodig:setFilter( 'nearest', 'nearest' )
	self.spacebg:setFilter( 'nearest', 'nearest' )
	self.screenspace1:setFilter( 'nearest', 'nearest' )
	self.screenspace2:setFilter( 'nearest', 'nearest' )
	self.screendig:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	------ AUDIO ------
	self.select1 = love.audio.newSource("audio/buttons/select.ogg")
	self.select2 = love.audio.newSource("audio/buttons/select.ogg")
	self.entersound = love.audio.newSource("audio/buttons/enter.ogg")
	self.backsound = love.audio.newSource("audio/buttons/back.ogg")
	self.mouseover1 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover2 = love.audio.newSource("audio/buttons/select.ogg")
	------ AUDIO ------
end

function moregames:update(dt)

	-- Set volume for audio
	self.select1:setVolume(sfxvolume)
	self.select2:setVolume(sfxvolume)
	self.entersound:setVolume(sfxvolume)
	self.backsound:setVolume(sfxvolume)
	self.mouseover1:setVolume(sfxvolume)
	self.mouseover2:setVolume(sfxvolume)

	-- Set the current page
	if self.page2 == true then
		self.space = false
		self.dig = true
	elseif self.page2 == false then
		self.dig = false
		self.space = true
	end

	-- MOUSE AREAS --
	-- Mouse area of next button
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font7:getWidth( "< 1/2 >" )/2) + 440 + start.font2:getWidth( "< 1/2 >" ) + 30 and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font7:getWidth( "< 1/2 >" )/2) + 565 - 40 and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "< 1/2 >" )/2) + 322 - 40 and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "< 1/2 >" )/2) + 322 + start.font2:getHeight( "< 1/2 >" ) + 30 then
		self.nextstatemouse = true
		self.backstatemouse = false
		self.scaleback = 1
		self.scalenext = 1.2
		self.mouseovernext = true
		self.mouseoverback = false
		self.mousedetect1 = self.mousedetect1 + 1
		self.mousedetect2 = 0
	end

	-- Mouse area of back button
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font7:getWidth( "< BACK" )/2) - 660 + start.font2:getWidth( "< BACK" ) + 30 and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font7:getWidth( "< BACK" )/2) - 565 - 40 and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font7:getWidth( "< BACK" )/2) - 295 - 40 and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font7:getWidth( "< BACK" )/2) - 295 + start.font2:getHeight( "< BACK" ) + 30 then
		self.nextstatemouse = false
		self.backstatemouse = true
		self.scaleback = 1.2
		self.scalenext = 1
		self.mouseovernext = false
		self.mouseoverback = true
		self.mousedetect1 = 0
		self.mousedetect2 = self.mousedetect2 + 1
	end
	-- MOUSE AREAS --

	-- MOUSE OUT OF AREA --
	-- Out of areas for the back button
	if love.mouse.getX() > (love.graphics.getWidth()/2 - start.font7:getWidth( "< BACK" )/2) - 660 + start.font2:getWidth( "< BACK" ) + 30 then
		self.backstatemouse = false
		self.mouseoverback = false
		self.scaleback = 1
	end 
	
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font7:getWidth( "< BACK" )/2) - 565 - 40 then
		self.backstatemouse = false
		self.mouseoverback = false
		self.scaleback = 1
	end

	if love.mouse.getY() < (love.graphics.getHeight()/2 - start.font7:getWidth( "< BACK" )/2) - 295 - 40 then
		self.backstatemouse = false
		self.mouseoverback = false
		self.scaleback = 1
	end 

	if love.mouse.getY() > (love.graphics.getHeight()/2 - start.font7:getWidth( "< BACK" )/2) - 295 + start.font2:getHeight( "< BACK" ) + 30 then
		self.backstatemouse = false
		self.mouseoverback = false
		self.scaleback = 1
	end

	-- Out of areas for the next button
	if love.mouse.getX() > (love.graphics.getWidth()/2 - start.font7:getWidth( "< 1/2 >" )/2) + 440 + start.font2:getWidth( "< 1/2 >" ) + 30 then
		self.nextstatemouse = false
		self.mouseovernext = false
		self.scalenext = 1
	end 
	
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font7:getWidth( "< 1/2 >" )/2) + 565 - 40 then
		self.nextstatemouse = false
		self.mouseovernext = false
		self.scalenext = 1
	end

	if love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "< 1/2 >" )/2) + 322 - 40 then
		self.nextstatemouse = false
		self.mouseovernext = false
		self.scalenext = 1
	end 

	if love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "< 1/2 >" )/2) + 322 + start.font2:getHeight( "< 1/2 >" ) + 30 then
		self.nextstatemouse = false
		self.mouseovernext = false
		self.scalenext = 1
	end
	-- MOUSE OUT OF AREA --

	-- BUTTON FLASHING -- 
	-- Flashing for the back button
	if self.backstatemouse == true then
		if self.flashbuttonback == true then
			self.buttonflashback = self.buttonflashback + dt + 2
		elseif self.flashbuttonback == false then
			self.buttonflashback = self.buttonflashback + dt - 2
		end
	
		if self.buttonflashback > 150 then
			self.flashbuttonback = false
		elseif self.buttonflashback < 2 then
			self.flashbuttonback = true
		end
	
	elseif self.backstatemouse == false then
		self.flashbuttonback = true
		self.buttonflashback = 0
	end

	-- Flashing for the next button
	if self.nextstatemouse == true then
		if self.flashbuttonnext == true then
			self.buttonflashnext = self.buttonflashnext + dt + 2
		elseif self.flashbuttonnext == false then
			self.buttonflashnext = self.buttonflashnext + dt - 2
		end
	
		if self.buttonflashnext > 150 then
			self.flashbuttonnext = false
		elseif self.buttonflashnext < 2 then
			self.flashbuttonnext = true
		end
	
	elseif self.nextstatemouse == false then
		self.flashbuttonnext = true
		self.buttonflashnext = 0
	end
	-- BUTTON FLASHING --

	-- MOUSE DECTECTS --
	if self.mouseovernext == false then
		self.mousedetect1 = 0
		love.audio.stop(self.mouseover1)
	end

	if self.mouseoverback == false then
		self.mousedetect2 = 0
		love.audio.stop(self.mouseover2)
	end

	if self.mousedetect1 == 1 then
		love.audio.play(self.mouseover1)
		love.audio.stop(self.mouseover2)
	end

	if self.mousedetect2 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.play(self.mouseover2)
	end
	-- MOUSE DECTECTS --

	-- ACTIVATE BUTTONS --
	-- Takes you back to the main menu
	if self.backpressed == true then
		Gamestate.pop()
		love.audio.play(self.backsound)
		love.audio.stop(options.entersound1)
		self.backpressed = false
	end

	-- Go to the next page
	if self.rightpressed == true then
		love.audio.play(self.select1)
		love.audio.stop(self.select2)
		self.page2 = true
		self.rightpressed = false
	end

	-- Go to the next page
	if self.leftpressed == true then
		love.audio.stop(self.select1)
		love.audio.play(self.select2)
		self.page2 = false
		self.leftpressed = false
	end
	-- ACTIVATE BUTTONS --
end

function moregames:keypressed(key)

	-- Go to right page
	if key == "right" and self.page2 == false or key == "d" and self.page2 == false then
		self.rightpressed = true
	end

	-- go to left page
	if key == "left" and self.page2 == true or key == "a" and self.page2 == true then
		self.leftpressed = true
	end
	
	-- Takes you back to the main menu
	if key == "escape" or key == "return" or key == "space" then
		self.backpressed = true
	end
end

function moregames:mousepressed(mx, my, button)

	-- Takes you back to the main menu
	if button == 2 then
		self.backpressed = true
	end

	-- Go to the next page
	if button == 1 and self.mouseovernext == true and self.dig == false then
		self.rightpressed = true
	end

	-- go to the next page
	if button == 1 and self.mouseovernext == true and self.space == false then
		self.leftpressed = true
	end
	
	-- Takes you back to the main menu
	if button == 1 and self.mouseoverback == true then
		self.backpressed = true
	end
end

function moregames:draw()

	------ IMAGE ------
	love.graphics.draw(start.bg, 0, -1000, 0, 3)
	------ IMAGE ------

	-- Display SpaceGame page
	if self.page2 == false then
		
		------ IMAGE ------
		love.graphics.draw(self.spacebg, (love.graphics.getWidth()/2 - self.spacebg:getWidth()/2), (love.graphics.getHeight()/2 - self.spacebg:getHeight()/2), 0)
		love.graphics.draw(self.logospace, (love.graphics.getWidth()/2 - 300/2) - 440, (love.graphics.getHeight()/2 - 300/2) - 160, 0, 0.2)
		love.graphics.draw(self.screenspace1, (love.graphics.getWidth()/2 - self.screenspace1:getWidth()/2) - 400, (love.graphics.getHeight()/2 - self.screenspace1:getHeight()/2) + 193)
		love.graphics.draw(self.screenspace2, (love.graphics.getWidth()/2 - self.screenspace2:getWidth()/2) - 117, (love.graphics.getHeight()/2 - self.screenspace2:getHeight()/2) + 193)
		------ IMAGE ------

		------ TEXT ------
		love.graphics.setFont( start.font7 )
		love.graphics.print('We have begun working on a new project called SpaceGame,', (love.graphics.getWidth()/2 - start.font7:getWidth( "We have begun working on a new project called SpaceGame," )/2) + 170, (love.graphics.getHeight()/2 - 25/2) - 260)
		love.graphics.print('its not too far into development as of yet, but we have a', (love.graphics.getWidth()/2 - start.font7:getWidth( "its not too far into development as of yet, but we have a" )/2) + 170, (love.graphics.getHeight()/2 - 25/2) - 235)
		love.graphics.print('start! The game currently consists of a main menu with', (love.graphics.getWidth()/2 - start.font7:getWidth( "start! The game currently consists of a main menu with" )/2) + 170, (love.graphics.getHeight()/2 - 25/2) - 210)
		love.graphics.print('some very nice music, minimalistic yet neat graphics, a', (love.graphics.getWidth()/2 - start.font7:getWidth( "some very nice music, minimalistic yet neat graphics, a" )/2) + 170, (love.graphics.getHeight()/2 - 25/2) - 185)
		love.graphics.print('scrolling background, as well as the very first example of', (love.graphics.getWidth()/2 - start.font7:getWidth( "scrolling background, as well as the very first example of" )/2) + 170, (love.graphics.getHeight()/2 - 25/2) - 160)
		love.graphics.print('simple gameplay with a moveable character along with a', (love.graphics.getWidth()/2 - start.font7:getWidth( "simple gameplay with a moveable character along with a" )/2) + 170, (love.graphics.getHeight()/2 - 25/2) - 135)
		love.graphics.print('camera that follows; and that is all. We plan to expand', (love.graphics.getWidth()/2 - start.font7:getWidth( "camera that follows; and that is all. We plan to expand" )/2) + 170, (love.graphics.getHeight()/2 - 25/2) - 110)
		love.graphics.print('upon this prototype and push features into the game, until', (love.graphics.getWidth()/2 - start.font7:getWidth( "upon this prototype and push features into the game, until" )/2) + 170, (love.graphics.getHeight()/2 - 25/2) - 85)
		love.graphics.print('it fully meets our goals and expectations of ourselves,', (love.graphics.getWidth()/2 - start.font7:getWidth( "it fully meets our goals and expectations of ourselves," )/2) + 170, (love.graphics.getHeight()/2 - 25/2) - 60)
		love.graphics.print('which are by no means short sighted.', (love.graphics.getWidth()/2 - start.font7:getWidth( "which are by no means short sighted." )/2) + 170, (love.graphics.getHeight()/2 - 25/2) - 35)
		love.graphics.print('Try it out here:', (love.graphics.getWidth()/2 - start.font7:getWidth( "Try it out here:" )/2) + 300, (love.graphics.getHeight()/2 - 25/2) + 152)
		love.graphics.print('http://teampiquant.com/games/spacegame', (love.graphics.getWidth()/2 - start.font7:getWidth( "http://teampiquant.com/games/spacegame" )/2) + 300, (love.graphics.getHeight()/2 - 25/2) + 177)
		love.graphics.print('http://reddit/r/piquant2013', (love.graphics.getWidth()/2 - start.font7:getWidth( "http://reddit/r/piquant2013" )/2) + 300, (love.graphics.getHeight()/2 - 25/2) + 202)
		love.graphics.print('< 1/2 >', (love.graphics.getWidth()/2 - start.font7:getWidth( "< 1/2 >" )/2) + 565, (love.graphics.getHeight()/2 - 25/2) + 322, 0, self.scalenext)
		love.graphics.setColor(160, 47, 0, self.buttonflashnext)
		love.graphics.print('< 1/2 >', (love.graphics.getWidth()/2 - start.font7:getWidth( "< 1/2 >" )/2) + 565, (love.graphics.getHeight()/2 - 25/2) + 322, 0, self.scalenext)
		love.graphics.setColor(255, 255, 255, 255)
		------ TEXT ------
	end

	-- Display Digging Sim page
	if self.page2 == true then
		
		------ IMAGE ------
		love.graphics.draw(self.screendig, (love.graphics.getWidth()/2 - self.screendig:getWidth()/2), (love.graphics.getHeight()/2 - self.screendig:getHeight()/2), 0)
		love.graphics.draw(self.logodig, (love.graphics.getWidth()/2 - 300/2) - 440, (love.graphics.getHeight()/2 - 300/2) - 160, 0, 0.2)
		------ IMAGE ------

		------ TEXT ------
		love.graphics.setFont( start.font7 )
		love.graphics.print('As some of you may know, we do the BaconGameJam', (love.graphics.getWidth()/2 - start.font7:getWidth( "As some of you may know, we do the BaconGameJam" )/2) + 170, (love.graphics.getHeight()/2 - 25/2) - 210)
		love.graphics.print('sometimes, and as a result we have a brand new game to', (love.graphics.getWidth()/2 - start.font7:getWidth( "sometimes, and as a result we have a brand new game to" )/2) + 170, (love.graphics.getHeight()/2 - 25/2) - 185)
		love.graphics.print('showcase! Say hello, to Digging Simulator! Join the', (love.graphics.getWidth()/2 - start.font7:getWidth( "showcase! Say hello, to Digging Simulator! Join the" )/2) + 170, (love.graphics.getHeight()/2 - 25/2) - 160)
		love.graphics.print('protagonist and his shovel on an epic journey to Bejing,', (love.graphics.getWidth()/2 - start.font7:getWidth( "protagonist and his shovel on an epic journey to Bejing," )/2) + 170, (love.graphics.getHeight()/2 - 25/2) - 135)
		love.graphics.print('China. Along the way youll meet absolutely nobody, do', (love.graphics.getWidth()/2 - start.font7:getWidth( "China. Along the way youll meet absolutely nobody, do" )/2) + 170, (love.graphics.getHeight()/2 - 25/2) - 110)
		love.graphics.print('absolutely nothing exciting, and probably get a splinter.', (love.graphics.getWidth()/2 - start.font7:getWidth( "absolutely nothing exciting, and probably get a splinter." )/2) + 170, (love.graphics.getHeight()/2 - 25/2) - 85)
		love.graphics.print('Try it out here:', (love.graphics.getWidth()/2 - start.font7:getWidth( "Try it out here:" )/2) + 300, (love.graphics.getHeight()/2 - 25/2) + 152)
		love.graphics.print('http://teampiquant.com/games/diggingsim', (love.graphics.getWidth()/2 - start.font7:getWidth( "http://teampiquant.com/games/diggingsim" )/2) + 300, (love.graphics.getHeight()/2 - 25/2) + 177)
		love.graphics.print('http://reddit/r/piquant2013', (love.graphics.getWidth()/2 - start.font7:getWidth( "http://reddit/r/piquant2013" )/2) + 300, (love.graphics.getHeight()/2 - 25/2) + 202)
		love.graphics.print('< 2/2 >', (love.graphics.getWidth()/2 - start.font7:getWidth( "< 2/2 >" )/2) + 565, (love.graphics.getHeight()/2 - 25/2) + 322, 0, self.scalenext)
		love.graphics.setColor(160, 47, 0, self.buttonflashnext)
		love.graphics.print('< 2/2 >', (love.graphics.getWidth()/2 - start.font7:getWidth( "< 2/2 >" )/2) + 565, (love.graphics.getHeight()/2 - 25/2) + 322, 0, self.scalenext)
		love.graphics.setColor(255, 255, 255, 255)
		------ TEXT ------
	end

	------ TEXT ------
	love.graphics.print('< BACK', (love.graphics.getWidth()/2 - start.font7:getWidth( "< BACK" )/2) - 565, (love.graphics.getHeight()/2 - 25/2) - 322, 0, self.scaleback)
	love.graphics.setColor(160, 47, 0, self.buttonflashback)
	love.graphics.print('< BACK', (love.graphics.getWidth()/2 - start.font7:getWidth( "< BACK" )/2) - 565, (love.graphics.getHeight()/2 - 25/2) - 322, 0, self.scaleback)
	love.graphics.setColor(255, 255, 255, 255)
	------ TEXT ------
end

return moregames