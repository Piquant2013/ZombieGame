-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates credits as a new gamestate
moregames = Gamestate.new()


function moregames:init()

	------ AUDIO ------
	self.select1 = love.audio.newSource("audio/buttons/select.ogg")
	self.select2 = love.audio.newSource("audio/buttons/select.ogg")
	self.entersound = love.audio.newSource("audio/buttons/enter.ogg")
	self.backsound = love.audio.newSource("audio/buttons/back.ogg")
	------ AUDIO ------

	self.page2 = false


	self.logodig = love.graphics.newImage("images/menu/logodig.png")
	self.screendig = love.graphics.newImage("images/menu/screendig.png")

	self.logospace = love.graphics.newImage("images/menu/logospace.png")
	self.screenspace1 = love.graphics.newImage("images/menu/screenspace1.png")
	self.screenspace2 = love.graphics.newImage("images/menu/screenspace2.png")
	self.spacebg = love.graphics.newImage("images/menu/spacebg.png")
end

function moregames:keypressed(key)

	if key == "right" and self.page2 == false or key == "d" and self.page2 == false then
		love.audio.play(self.select1)
		love.audio.stop(self.select2)
		self.page2 = true
	end

	if key == "left" and self.page2 == true or key == "a" and self.page2 == true then
		love.audio.stop(self.select1)
		love.audio.play(self.select2)
		self.page2 = false
	end
	
	-- Takes you back to the main menu
	if key == "escape" or key == "return" or key == " " then
		Gamestate.pop()
		love.audio.play(self.backsound)
		love.audio.stop(options.entersound1)
	end
end

function moregames:update(dt)
end

function moregames:draw()
	
	------ FILTERS ------
	self.logospace:setFilter( 'nearest', 'nearest' )
	self.logodig:setFilter( 'nearest', 'nearest' )
	self.spacebg:setFilter( 'nearest', 'nearest' )
	self.screenspace1:setFilter( 'nearest', 'nearest' )
	self.screenspace2:setFilter( 'nearest', 'nearest' )
	self.screendig:setFilter( 'nearest', 'nearest' )
	start.font7:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	if self.page2 == false then
		
		------ IMAGE ------
		love.graphics.draw(self.spacebg, -100, 0, 0, 1.1)
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
		love.graphics.print('< 1/2 >', (love.graphics.getWidth()/2 - start.font7:getWidth( "< 1/2 >" )/2) + 565, (love.graphics.getHeight()/2 - 25/2) + 322)
		love.graphics.setColor(255, 255, 255, 255)
		------ TEXT ------
	end

	if self.page2 == true then
		
		------ IMAGE ------
		love.graphics.draw(self.screendig, -220, 0, 0, 1.1)
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
		love.graphics.print('< 2/2 >', (love.graphics.getWidth()/2 - start.font7:getWidth( "< 2/2 >" )/2) + 565, (love.graphics.getHeight()/2 - 25/2) + 322)
		love.graphics.setColor(255, 255, 255, 255)
		------ TEXT ------
	end

end

return moregames