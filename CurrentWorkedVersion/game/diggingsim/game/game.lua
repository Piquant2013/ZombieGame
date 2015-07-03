-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads camera script
local camera = require "libs/hump/camera"

-- Loads pause script
pausesim = require 'game/diggingsim/game/menus/pause'

-- Creates game as a new gamestate
gamesim = Gamestate.new()


function gamesim:init()

	------ VARIABLES ------
	-- kid table
	kid = {}
	kid.x = 640
	kid.y = 39
	kid.speed = 2
	kid.sprite = love.graphics.newImage("game/diggingsim/images/game/player.png")
	kid.shovel = love.graphics.newImage("game/diggingsim/images/game/shovel.png")
	
	-- various vars
	self.shovely = kid.y + 4
	self.shipx = -6000
	self.shipy = kid.y
	self.talktimer = 0
	self.speak = false
	self.achtimer = 0
	self.ach = false
	self.playerdeath = false
	self.wingame = false
	self.reddot = 158
	self.paused = false
	self.resume = true

	-- Camera
	self.Cam = camera(kid.x, kid.y, 2.5)
	------ VARIABLES ------

	------ IMAGES ------
	self.map = love.graphics.newImage("game/diggingsim/images/game/map.png")
	self.sky2 = love.graphics.newImage("game/diggingsim/images/game/end.png")
	self.sky = love.graphics.newImage("game/diggingsim/images/game/sky.png")
	self.dug = love.graphics.newImage("game/diggingsim/images/game/dug.png")
	self.flag1 = love.graphics.newImage("game/diggingsim/images/game/flag1.png")
	self.flag2 = love.graphics.newImage("game/diggingsim/images/game/flag2.png")
	self.achsprite = love.graphics.newImage("game/diggingsim/images/game/ach.png")
	self.ship = love.graphics.newImage("game/diggingsim/images/game/ship1.png")
	------ IMAGES ------

	------ AUDIO ------
	self.talk = love.audio.newSource("game/diggingsim/audio/game/talk.ogg")
	self.dig = love.audio.newSource("game/diggingsim/audio/game/dig.ogg")
	self.achsound = love.audio.newSource("game/diggingsim/audio/game/ach.ogg")
	------ AUDIO ------
end

function gamesim:keypressed(key)

	-- dig
	if key == "f" and self.wingame == false then
   		kid.y = kid.y + kid.speed
   		love.audio.play(self.dig)
  	end

  	-- Pause the game
  	if key == "escape" and self.paused == false then
   		self.paused = true
   		self.resume = false
  	end
end

function gamesim:update(dt)

	-- CAMERA --
	-- set up camera
	dx,dy = (kid.x) - self.Cam.x, (kid.y) - self.Cam.y
	mx1,my1 = self.Cam:mousepos()
	self.Cam:move(dx/2, dy/2)
	self.Cam:zoomTo(12)
	-- CAMERA --

    -- if game is paused switch to the pause screen
	if self.paused == true then
		Gamestate.push(pausesim)
	end

	-- GAME STUFF --
	if kid.y > 200 and kid.y < 400 then
		self.reddot = 170
	end

	if kid.y > 400 and kid.y < 600 then
		self.reddot = 182
	end

	if kid.y > 600 and kid.y < 800 then
		self.reddot = 194
	end

	if kid.y > 800 and kid.y < 1000 then
		self.reddot = 206
	end

	if kid.y > 1000 and kid.y < 1200 then
		self.reddot = 218
	end

	if kid.y > 1200 and kid.y < 1400 then
		self.reddot = 230
	end

	if kid.y > 1400 and kid.y < 1600 then
		self.reddot = 242
	end

	if kid.y > 1600 and kid.y < 1800 then
		self.reddot = 254
	end

	if kid.y > 1800 and kid.y < 2000 then
		self.reddot = 266
	end

	if kid.y > 2000 and kid.y < 2200 then
		self.reddot = 278
	end

	if kid.y > 2200 and kid.y < 2400 then
		self.reddot = 290
	end

	if kid.y > 2400 and kid.y < 2600 then
		self.reddot = 302
	end

	if kid.y > 2600 and kid.y < 2800 then
		self.reddot = 314
	end

	if kid.y > 2800 and kid.y < 3000 then
		self.reddot = 326
	end

	if kid.y > 3000 and kid.y < 3200 then
		self.reddot = 338
	end

	if kid.y > 3200 and kid.y < 3400 then
		self.reddot = 350
	end

	if kid.y > 3400 and kid.y < 3600 then
		self.reddot = 362
	end

	if kid.y > 3746 then
		self.wingame = true
	end

	if kid.y < 3748 then
		self.shovely = kid.y + 4
	end

	if self.wingame == true then
		kid.y = kid.y + 160 * dt
		self.shovely = self.shovely + 140 * dt
		self.shipx = self.shipx + 350 * dt
		self.shipy = kid.y - 10
	end

	if self.shipx > kid.x then
		self.playerdeath = true
	end

	if self.speak == true then
		self.talktimer = self.talktimer + dt
	end

	if self.speak == false then
		self.talktimer = 0
	end

	if self.talktimer < 2 and self.speak == true then
		love.audio.play(self.talk)
	end

	if self.ach == true then
		self.achtimer = self.achtimer + dt
	end

	if self.ach == false then
		self.achtimer = 0
	end

	if self.achtimer < 0.5 and self.ach == true then
		love.audio.play(self.achsound)
	end
	-- GAME STUFF --
end

function gamesim:draw()
		
	------ FILTERS ------	
	self.map:setFilter( 'nearest', 'nearest' )
	kid.sprite:setFilter( 'nearest', 'nearest' )
	kid.shovel:setFilter( 'nearest', 'nearest' )
	self.flag1:setFilter( 'nearest', 'nearest' )
	self.flag2:setFilter( 'nearest', 'nearest' )
	self.sky:setFilter( 'nearest', 'nearest' )
	self.sky2:setFilter( 'nearest', 'nearest' )
	self.ship:setFilter( 'nearest', 'nearest' )
	self.achsprite:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	------ CAMERA ------
	self.Cam:attach()
	
	love.graphics.draw(self.map, (love.graphics.getWidth()/2 - self.map:getWidth()/2), 0)
	
	if self.playerdeath == false then
		love.graphics.draw(self.dug, kid.x - 9, kid.y - 589)
	end
	
	love.graphics.draw(self.sky, (love.graphics.getWidth()/2 - self.sky:getWidth()/2), 0)
	love.graphics.draw(self.sky2, (love.graphics.getWidth()/2 - self.sky:getWidth()/2), 3758)
	
	if self.playerdeath == false then
		love.graphics.draw(kid.sprite, kid.x, kid.y)
		love.graphics.draw(kid.shovel, kid.x - 2, self.shovely)
	end
	
	love.graphics.draw(self.ship, self.shipx, self.shipy)
	
	self.Cam:detach()
	------ CAMERA ------

	-- GAME STUFF --
	love.graphics.setFont( startsim.font1 )

	if kid.y > 42 and kid.y < 82 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("The meaning of life, the universe", 30, 50)
		love.graphics.print("and everything", 30, 70)
		self.ach = true
	end

	if kid.y > 100 and kid.y < 140 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("Digging", 30, 50)
		self.ach = true
	end

	if kid.y > 200 and kid.y < 240 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("Talking to your self", 30, 50)
		self.ach = true
	end

	if kid.y > 300 and kid.y < 340 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("Getting this far", 30, 50)
		self.ach = true
	end

	if kid.y > 400 and kid.y < 440 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("400", 30, 50)
		self.ach = true
	end

	if kid.y > 500 and kid.y < 540 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("Still playing this game", 30, 50)
		self.ach = true
	end

	if kid.y > 600 and kid.y < 640 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("dirt acquired", 30, 50)
		self.ach = true
	end

	if kid.y > 700 and kid.y < 740 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("life goal", 30, 50)
		self.speak = true
	end

	if kid.y > 800 and kid.y < 840 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("shovel love", 30, 50)
		self.ach = true
	end

	if kid.y > 900 and kid.y < 940 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("half way", 30, 50)
		self.ach = true
	end

	if kid.y > 1000 and kid.y < 1040 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("Minecrafted", 30, 50)
		self.ach = true
	end

	if kid.y > 1100 and kid.y < 1140 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("Fast Digging", 30, 50)
		self.ach = true
	end

	if kid.y > 1200 and kid.y < 1240 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("Almost there", 30, 50)
		self.ach = true
	end

	if kid.y > 1300 and kid.y < 1340 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("dirt acquired", 30, 50)
		self.ach = true
	end

	if kid.y > 1400 and kid.y < 1440 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("the impossible", 30, 50)
		self.ach = true
	end

	if kid.y > 1500 and kid.y < 1540 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("Digging", 30, 50)
		self.ach = true
	end

	if kid.y > 1600 and kid.y < 1640 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("nice meme", 30, 50)
		self.ach = true
	end

	if kid.y > 1700 and kid.y < 1740 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("Core", 30, 50)
		self.ach = true
	end

	if kid.y > 1800 and kid.y < 1840 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("Darkness", 30, 50)
		self.ach = true
	end

	if kid.y > 2000 and kid.y < 2040 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("new shovel acquired", 30, 50)
		self.ach = true
	end

	if kid.y > 2100 and kid.y < 2140 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("2000", 30, 50)
		self.ach = true
	end

	if kid.y > 2200 and kid.y < 2240 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("Repetitive Strain Injury", 30, 50)
		self.ach = true
	end

	if kid.y > 2300 and kid.y < 2340 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("23", 30, 50)
		self.ach = true
	end

	if kid.y > 2400 and kid.y < 2440 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("dirt acquired", 30, 50)
		self.ach = true
	end

	if kid.y > 2500 and kid.y < 2540 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("Why??!", 30, 50)
		self.speak = true
	end

	if kid.y > 2600 and kid.y < 2640 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("FUCKING HELL NOW I FEEL BAD FOR", 30, 50)
		love.graphics.print("MAKING YOU PLAY THIS FAR", 30, 70)
		self.ach = true
	end

	if kid.y > 2700 and kid.y < 2740 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("SORRY NOT SORRY", 30, 50)
		self.ach = true
	end

	if kid.y > 2800 and kid.y < 2840 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("3000", 30, 50)
		self.ach = true
	end

	if kid.y > 2900 and kid.y < 2940 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("Digging", 30, 50)
		self.ach = true
	end

	if kid.y > 3000 and kid.y < 3040 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("ffffffffffffff", 30, 50)
		ach = true
	end

	if kid.y > 3100 and kid.y < 3140 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("How are you at the end?", 30, 50)
		self.ach = true
	end

	if kid.y > 3200 and kid.y < 3240 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("No Life", 30, 50)
		self.ach = true
	end

	if kid.y > 3300 and kid.y < 3340 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("dirt acquired", 30, 50)
		self.ach = true
	end

	if kid.y > 3400 and kid.y < 3440 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("Time waster", 30, 50)
		self.ach = true
	end


	if kid.y > 3700 and kid.y < 3740 then 
		love.graphics.draw(self.achsprite, 10, 10)
		love.graphics.print("Win Game", 30, 50)
		self.ach = true
	end

	if kid.y > 82 and kid.y < 100 then 
		self.ach = false
	end

	if kid.y > 140 and kid.y < 200 then 
		self.ach = false
	end

	if kid.y > 240 and kid.y < 300 then 
		self.ach = false
	end

	if kid.y > 340 and kid.y < 400 then 
		self.ach = false
	end

	if kid.y > 440 and kid.y < 500 then 
		self.ach = false
	end

	if kid.y > 540 and kid.y < 600 then 
		self.ach = false
	end

	if kid.y > 640 and kid.y < 700 then 
		self.ach = false
	end

	if kid.y > 740 and kid.y < 800 then 
		self.speak = false
	end

	if kid.y > 840 and kid.y < 900 then 
		self.ach = false
	end

	if kid.y > 940 and kid.y < 1000 then 
		self.ach = false
	end

	if kid.y > 1040 and kid.y < 1100 then 
		self.ach = false
	end

	if kid.y > 1140 and kid.y < 1200 then 
		self.ach = false
	end

	if kid.y > 1240 and kid.y < 1300 then 
		self.ach = false
	end

	if kid.y > 1340 and kid.y < 1400 then 
		self.ach = false
	end

	if kid.y > 1440 and kid.y < 1500 then 
		self.ach = false
	end

	if kid.y > 1540 and kid.y < 1600 then 
		self.ach = false
	end

	if kid.y > 1640 and kid.y < 1700 then 
		self.ach = false
	end

	if kid.y > 1740 and kid.y < 1800 then 
		self.ach = false
	end

	if kid.y > 1840 and kid.y < 1900 then 
		self.ach = false
	end

	if kid.y > 1940 and kid.y < 2000 then 
		self.ach = false
	end

	if kid.y > 2040 and kid.y < 2100 then 
		self.ach = false
	end

	if kid.y > 2140 and kid.y < 2200 then 
		self.ach = false
	end

	if kid.y > 2240 and kid.y < 2300 then 
		self.ach = false
	end

	if kid.y > 2340 and kid.y < 2400 then 
		self.ach = false
	end

	if kid.y > 2440 and kid.y < 2500 then 
		self.ach = false
	end

	if kid.y > 2540 and kid.y < 2600 then 
		self.ach = false
	end

	if kid.y > 2640 and kid.y < 2700 then 
		self.ach = false
	end

	if kid.y > 2740 and kid.y < 2800 then 
		self.ach = false
	end

	if kid.y > 2840 and kid.y < 2900 then 
		self.ach = false
	end

	if kid.y > 2940 and kid.y < 3000 then 
		self.ach = false
	end

	if kid.y > 3040 and kid.y < 3100 then 
		self.ach = false
	end

	if kid.y > 3140 and kid.y < 3200 then 
		self.ach = false
	end

	if kid.y > 3240 and kid.y < 3300 then 
		self.ach = false
	end

	if kid.y > 3340 and kid.y < 3400 then 
		self.ach = false
	end

	if kid.y > 3740 and kid.y < 3800 then 
		self.ach = false
	end

	love.graphics.setFont( startsim.font2 )
	
	if kid.y > 30 and kid.y < 50 then 
		love.graphics.print("[F] TO DIG", love.graphics.getWidth()/2 + 150, 200)
	end

	if kid.y > 80 and kid.y < 160 then 
		love.graphics.print("Huh. Not even breaking a sweat. --", love.graphics.getWidth()/2 - 500, 400)
		self.speak = true
	end

	if kid.y > 160 and kid.y < 240 then 
		self.speak = false
	end

	if kid.y > 240 and kid.y < 320 then 
		love.graphics.print("I can already taste the rice --", love.graphics.getWidth()/2 - 450, 400)
		love.graphics.print("from here.", love.graphics.getWidth()/2 - 450, 430)
		self.speak = true
	end

	if kid.y > 320 and kid.y < 400 then 
		self.speak = false
	end

	if kid.y > 400 and kid.y < 480 then 
		love.graphics.print("I'm hungry. Shoulda brought --", love.graphics.getWidth()/2 - 440, 400)
		love.graphics.print("some ramen with me.", love.graphics.getWidth()/2 - 440, 430)
		self.speak = true
	end

	if kid.y > 480 and kid.y < 560 then 
		self.speak = false
	end

	if kid.y > 560 and kid.y < 640 then 
		love.graphics.print("Ouch. Splinter. --", love.graphics.getWidth()/2 - 230, 400)
		self.speak = true
	end

	if kid.y > 640 and kid.y < 720 then 
		self.speak = false
	end

	if kid.y > 720 and kid.y < 800 then 
		love.graphics.print("Damn, dirt in my shoes. Dirt --", love.graphics.getWidth()/2 - 430, 400)
		love.graphics.print("everywhere, actually.", love.graphics.getWidth()/2 - 430, 430)
		self.speak = true
	end

	if kid.y > 800 and kid.y < 880 then 
		self.speak = false
	end

	if kid.y > 880 and kid.y < 960 then 
		love.graphics.print("I was wearing a white shirt when --", love.graphics.getWidth()/2 - 520, 400)
		love.graphics.print("i woke up this morning. Huh.", love.graphics.getWidth()/2 - 520, 430)
		self.speak = true
	end

	if kid.y > 960 and kid.y < 1040 then 
		self.speak = false
	end

	if kid.y > 1040 and kid.y < 1120 then 
		love.graphics.print("I've been doing this so long i think --", love.graphics.getWidth()/2 - 540, 400)
		love.graphics.print("i'm attracted to my shovel.", love.graphics.getWidth()/2 - 540, 430)
		self.speak = true
	end

	if kid.y > 1120 and kid.y < 1200 then 
		self.speak = false
	end

	if kid.y > 1200 and kid.y < 1280 then 
		love.graphics.print("I think i might name my --", love.graphics.getWidth()/2 - 360, 400)
		love.graphics.print("shovel Betsy.", love.graphics.getWidth()/2 - 360, 430)
		self.speak = true
	end

	if kid.y > 1280 and kid.y < 1360 then 
		self.speak = false
	end

	if kid.y > 1360 and kid.y < 1440 then 
		love.graphics.print("Haven't even seen a single --", love.graphics.getWidth()/2 - 430, 400)
		love.graphics.print("dinosaur bone yet.", love.graphics.getWidth()/2 - 430, 430)
		self.speak = true
	end

	if kid.y > 1440 and kid.y < 1520 then 
		self.speak = false
	end

	if kid.y > 1520 and kid.y < 1600 then 
		love.graphics.print("I wonder how deep i am now. Heh, --", love.graphics.getWidth()/2 - 520, 400)
		love.graphics.print("that's what she said.", love.graphics.getWidth()/2 - 520, 430)
		self.speak = true
	end

	if kid.y > 1600 and kid.y < 1680 then 
		self.speak = false
	end

	if kid.y > 1680 and kid.y < 1760 then 
		love.graphics.print("I could make so many hole --", love.graphics.getWidth()/2 - 430, 400)
		love.graphics.print("innuendos right now.", love.graphics.getWidth()/2 - 430, 430)
		self.speak = true
	end

	if kid.y > 1760 and kid.y < 1840 then 
		self.speak = false
	end

	if kid.y > 1840 and kid.y < 1920 then 
		love.graphics.print("I hope nobody falls down this --", love.graphics.getWidth()/2 - 480, 400)
		love.graphics.print("hole. I forgot to fence it off.", love.graphics.getWidth()/2 - 480, 430)
		self.speak = true
	end

	if kid.y > 1920 and kid.y < 2000 then 
		self.speak = false
	end

	if kid.y > 2000 and kid.y < 2080 then 
		love.graphics.print("Where is all the dirt going as --", love.graphics.getWidth()/2 - 480, 400)
		love.graphics.print("i dig the hole? How is this", love.graphics.getWidth()/2 - 480, 430)
		love.graphics.print("even possible?", love.graphics.getWidth()/2 - 480, 460)
		self.speak = true
	end

	if kid.y > 2080 and kid.y < 2160 then 
		self.speak = false
	end

	if kid.y > 2160 and kid.y < 2240 then 
		love.graphics.print("What if i hit concrete in China? --", love.graphics.getWidth()/2 - 490, 400)
		love.graphics.print("How am i supposed to dig", love.graphics.getWidth()/2 - 490, 430)
		love.graphics.print("through that?!", love.graphics.getWidth()/2 - 490, 460)
		self.speak = true
	end

	if kid.y > 2240 and kid.y < 2320 then 
		self.speak = false
	end

	if kid.y > 2320 and kid.y < 2400 then 
		love.graphics.print("If someone falls through the --", love.graphics.getWidth()/2 - 485, 400)
		love.graphics.print("Earth, do they get stuck in", love.graphics.getWidth()/2 - 485, 430)
		love.graphics.print("the Core?", love.graphics.getWidth()/2 - 485, 460)
		self.speak = true
	end

	if kid.y > 2400 and kid.y < 2480 then 
		self.speak = false
	end

	if kid.y > 2480 and kid.y < 2560 then 
		love.graphics.print("I hope I don't fall into Space --", love.graphics.getWidth()/2 - 460, 400)
		love.graphics.print("when i hit the other side.", love.graphics.getWidth()/2 - 460, 430)
		love.graphics.print("That would be unfortunate.", love.graphics.getWidth()/2 - 460, 460)
		self.speak = true
	end

	if kid.y > 2560 and kid.y < 2640 then 
		self.speak = false
	end

	if kid.y > 2640 and kid.y < 2720 then 
		love.graphics.print("sadfklasdf --", love.graphics.getWidth()/2 - 200, 400)
		love.graphics.print("sdfasdf", love.graphics.getWidth()/2 - 200, 430)
		love.graphics.print("sdaf?", love.graphics.getWidth()/2 - 200, 460)
		self.speak = true
	end

	if kid.y > 2720 and kid.y < 2800 then 
		self.speak = false
	end

	if kid.y > 2800 and kid.y < 2880 then 
		love.graphics.print("I Might be losing it --", love.graphics.getWidth()/2 - 300, 400)
		self.speak = true
	end

	if kid.y > 2880 and kid.y < 2960 then 
		self.speak = false
	end

	if kid.y > 2960 and kid.y < 3040 then 
		love.graphics.print("This is nothing like the movie holes --", love.graphics.getWidth()/2 - 560, 400)
		self.speak = true
	end

	if kid.y > 3040 and kid.y < 3120 then 
		self.speak = false
	end

	if kid.y > 3120 and kid.y < 3200 then 
		love.graphics.print("what happens if it rains? --", love.graphics.getWidth()/2 - 400, 400)
		self.speak = true
	end

	if kid.y > 3200 and kid.y < 3280 then 
		self.speak = false
	end

	if kid.y > 3280 and kid.y < 3360 then 
		love.graphics.print("OMG I THINK IM ALMOST THERE!! --", love.graphics.getWidth()/2 - 450, 400)
		self.speak = true
	end

	if kid.y > 3360 and kid.y < 3440 then 
		self.speak = false
	end

	if kid.y > 3440 and kid.y < 3520 then 
		love.graphics.print("I can actually taste the rice!!  --", love.graphics.getWidth()/2 - 500, 400)
		self.speak = true
	end

	if kid.y > 3520 and kid.y < 3600 then 
		self.speak = false
	end

	if kid.y > 3600 and kid.y < 3680 then 
		love.graphics.print("YE YE YE YE!! IM HERE!!  --", love.graphics.getWidth()/2 - 350, 400)
		self.speak = true
	end

	if kid.y > 3680 and kid.y < 3900 then 
		self.speak = false
	end

	if kid.y > 3900 and kid.y < 4600 then 
		love.graphics.print("WTF??!  --", love.graphics.getWidth()/2 - 120, 480)
		self.speak = true
	end

	if kid.y > 4600 and kid.y < 5000 then 
		self.speak = false
	end

	if kid.y > 5000 and kid.y < 5900 then 
		love.graphics.print("WELL THIS IS SHIT..  --", love.graphics.getWidth()/2 - 300, 480)
		self.speak = true
	end

	if kid.y > 5900 and kid.y < 6300 then 
		self.speak = false
	end

	if kid.y > 7200 and self.playerdeath == true then
		love.graphics.setFont( startsim.font3 )
		love.graphics.print("GAME OVER", (love.graphics.getWidth()/2 - startsim.font3:getWidth( "GAME OVER" )/2), 200)
		love.graphics.print("SCORE: 23/42", (love.graphics.getWidth()/2 - startsim.font3:getWidth( "SCORE: 23/42" )/2), 280)
	end

	love.graphics.draw(self.flag1, (love.graphics.getWidth()/2 + 420), 50, 0, 10)
	love.graphics.draw(self.flag2, (love.graphics.getWidth()/2 + 420), 390, 0, 10)
	love.graphics.rectangle("fill", (love.graphics.getWidth()/2 + 495), 158, 12, 108 + 108 )

	love.graphics.setColor(160, 40, 0)
	love.graphics.rectangle("fill", (love.graphics.getWidth()/2 + 495), self.reddot, 12, 12 )
	love.graphics.setColor(255, 255, 255, 255)
	-- GAME STUFF --
end

return gamesim