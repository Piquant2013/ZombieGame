-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads gamestate script
local endless = require 'game/gamemodes/endless'

-- Loads gamestate script
local stuckmode = require 'game/gamemodes/stuck'

-- Creates pause as a new gamestate
selectmode = Gamestate.new()


function selectmode:init()
  
  	------ VARIABLES ------
	-- survival Button Y & X 
	self.survivalbtny = 100
	self.survivalbtnx = 548

	-- Arcade menu Button Y & X  
	self.arcadebtny = 200
	self.arcadebtnx = 512

	-- Endless menu Button Y & X  
	self.endlessbtny = 300
	self.endlessbtnx = 476

	-- Stuck menu Button Y & X  
	self.stuckbtny = 400
	self.stuckbtnx = 476
 
	-- Button Selecter Y & X 
	self.arrowy = (self.survivalbtny)
	self.arrowx = 450

	-- Survival Selecter Y & X
	self.survivalarrowy = 232
	self.survivalarrowx = 665
	
	-- Arcade Selecter Y & X
	self.arcadearrowy = 347
	self.arcadearrowx = 665

	-- back arrow
	self.backy = -100

	-- Select mode menu state  
	self.survivalstate = false
	self.arcadestate = false
	self.endlessstate = false
	self.stuckstate = false

	-- If in area
	self.survival = false
	self.arcade = false











	self.scalesurvival = 1
	self.scalearcade = 1
	self.scaleendless = 1
	self.scalestuck = 1
	self.scaleback = 1

	self.flashbuttonsurvival = true
	self.buttonflashsurvival = 0

	self.flashbuttonarcade = true
	self.buttonflasharcade = 0

	self.flashbuttonendless = true
	self.buttonflashendless = 0

	self.flashbuttonstuck = true
	self.buttonflashstuck = 0

	self.flashbuttonback = true
	self.buttonflashback = 0

	self.survivalstatemouse = false
	self.arcadestatemouse = false
	self.endlessstatemouse = false
	self.stuckstatemouse = false
	self.stuckstateback = false

	self.mouseover = false
	self.mouseoverback = false
	self.mousedetect1 = 0
	self.mousedetect2 = 0
	self.mousedetect3 = 0
	self.mousedetect4 = 0
	self.mousedetect5 = 0











	------ VARIABLES ------
	
	------ IMAGES ------
	self.screenshot1 = love.graphics.newImage("images/menu/screenshot1.png")
	self.screenshot2 = love.graphics.newImage("images/menu/screenshot2.png")
	------ IMAGES ------

	------ AUDIO ------
	self.entersound1 = love.audio.newSource("audio/buttons/enter.ogg")
	self.backsound = love.audio.newSource("audio/buttons/back.ogg")
	self.select1 = love.audio.newSource("audio/buttons/select.ogg")
	self.select2 = love.audio.newSource("audio/buttons/select.ogg")
	self.select3 = love.audio.newSource("audio/buttons/select.ogg")
	self.select4 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover1 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover2 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover3 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover4 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover5 = love.audio.newSource("audio/buttons/select.ogg")
	------ AUDIO ------
end

function selectmode:update(dt)

	-- Stop arrow from moving and sounds when in survival or arcade screens
	if self.survival == true then
		self.arrowy = self.survivalbtny
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
		love.audio.stop(self.select4)
	end

	if self.arcade == true then
		self.arrowy = self.arcadebtny
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
		love.audio.stop(self.select4)
	end

	-- SELECT MODE MENU STATES -- 
	-- survival pause menu state
	if self.arrowy == self.survivalbtny then
		self.arrowx = love.graphics.getWidth()/2 - 510 /2
		self.survivalstate = true
		self.endlessstate = false
		self.arcadestate = false
		self.stuckstate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
		love.audio.stop(self.select4)
		self.scalesurvival = 1.1
		self.scalearcade = 1
		self.scaleendless = 1
		self.scalestuck = 1
		self.scaleback = 1
	end

	-- Arcade pause menu state
	if self.arrowy < self.endlessbtny and self.arrowy > self.survivalbtny then
		self.arrowx = love.graphics.getWidth()/2 - 455 /2
		self.survivalstate = false
		self.endlessstate = false
		self.arcadestate = true
		self.stuckstate = false
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
		love.audio.stop(self.select4)
		self.scalesurvival = 1
		self.scalearcade = 1.1
		self.scaleendless = 1
		self.scalestuck = 1
		self.scaleback = 1
	end

	-- Endless pause pause menu state
	if self.arrowy > self.arcadebtny and self.arrowy < self.stuckbtny then
		self.arrowx = love.graphics.getWidth()/2 - 490 /2
		self.survivalstate = false
		self.endlessstate = true
		self.arcadestate = false
		self.stuckstate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select3)
		love.audio.stop(self.select4)
		self.scalesurvival = 1
		self.scalearcade = 1
		self.scaleendless = 1.1
		self.scalestuck = 1
		self.scaleback = 1
	end

	-- Stuck pause menu state
	if self.arrowy == self.stuckbtny then
		self.arrowx = love.graphics.getWidth()/2 - 515 /2
		self.survivalstate = false
		self.endlessstate = false
		self.arcadestate = false
		self.stuckstate = true
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
		self.scalesurvival = 1
		self.scalearcade = 1
		self.scaleendless = 1
		self.scalestuck = 1.1
		self.scaleback = 1
	end
	-- SELECT MODE MENU STATES --  

  	-- Make sure the arrow doesnt go past survival or endless
	if self.arrowy > self.stuckbtny then
		self.arrowy = self.stuckbtny
	elseif self.arrowy < self.survivalbtny then
		self.arrowy = self.survivalbtny
	end

	-- Pushes survival arrow back if it trys to pass off else turn survival true or false
	if self.survivalarrowx > self.survivalbtnx then
		self.survivalarrowx = self.survivalbtnx - 118
	elseif self.survivalarrowx == self.survivalbtnx - 118 then
		self.survival = false
	elseif self.survivalarrowx == self.survivalbtnx then	
		self.survival = true
	end

	-- Pushes arcade arrow back if it trys to pass off else turn arcade true or false
	if self.arcadearrowx > self.arcadebtnx then
		self.arcadearrowx = self.arcadebtnx - 118
	elseif self.arcadearrowx == self.arcadebtnx - 118 then
		self.arcade = false
	elseif self.arcadearrowx == self.arcadebtnx then	
		self.arcade = true
	end





















	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "SURVIVAL MODE" )/2 + start.font2:getWidth( "SURVIVAL MODE" )/2) + 250
	and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "SURVIVAL MODE" )/2) - 50
	and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "SURVIVAL MODE" )/2 - 250) 
	and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "SURVIVAL MODE" )/2 - 250) + start.font2:getHeight( "SURVIVAL MODE" ) then
		self.survivalstatemouse = true
		self.arcadestatemouse = false
		self.endlessstatemouse = false
		self.stuckstatemouse = false
		self.backstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 - 510 /2
		self.arrowy = self.survivalbtny
		self.scalesurvival = 1.1
		self.scalearcade = 1
		self.scaleendless = 1
		self.scalestuck = 1
		self.scaleback = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mousedetect1 = self.mousedetect1 + 1
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = 0
		self.mousedetect5 = 0
	end

	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "SURVIVAL MODE" )/2 + start.font2:getWidth( "SURVIVAL MODE" )/2) + 250
	and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "SURVIVAL MODE" )/2) - 50
	and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "ARCADE MODE" )/2 - 150) 
	and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "ARCADE MODE" )/2 - 150) + start.font2:getHeight( "ARCADE MODE" ) then
		self.survivalstatemouse = false
		self.arcadestatemouse = true
		self.endlessstatemouse = false
		self.stuckstatemouse = false
		self.backstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 - 455 /2
		self.arrowy = self.arcadebtny
		self.scalesurvival = 1
		self.scalearcade = 1.1
		self.scaleendless = 1
		self.scalestuck = 1
		self.scaleback = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mousedetect1 = 0
		self.mousedetect2 = self.mousedetect2 + 1
		self.mousedetect3 = 0
		self.mousedetect4 = 0
		self.mousedetect5 = 0
	end

	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "SURVIVAL MODE" )/2 + start.font2:getWidth( "SURVIVAL MODE" )/2) + 250
	and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "SURVIVAL MODE" )/2) - 50
	and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "ENDLESS MODE" )/2 - 50) 
	and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "ENDLESS MODE" )/2 - 50) + start.font2:getHeight( "ENDLESS MODE" ) then
		self.survivalstatemouse = false
		self.arcadestatemouse = false
		self.endlessstatemouse = true
		self.stuckstatemouse = false
		self.backstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 - 490 /2
		self.arrowy = self.endlessbtny
		self.scalesurvival = 1
		self.scalearcade = 1
		self.scaleendless = 1.1
		self.scalestuck = 1
		self.scaleback = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = self.mousedetect3 + 1
		self.mousedetect4 = 0
		self.mousedetect5 = 0
	end

	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "SURVIVAL MODE" )/2 + start.font2:getWidth( "SURVIVAL MODE" )/2) + 250
	and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "SURVIVAL MODE" )/2) - 50
	and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "STUCKINTHEMUD" )/2 + 50) 
	and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "STUCKINTHEMUD" )/2 + 50) + start.font2:getHeight( "STUCKINTHEMUD" ) then
		self.survivalstatemouse = false
		self.arcadestatemouse = false
		self.endlessstatemouse = false
		self.stuckstatemouse = true
		self.backstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 - 515 /2
		self.arrowy = self.stuckbtny
		self.scalesurvival = 1
		self.scalearcade = 1
		self.scaleendless = 1
		self.scalestuck = 1.1
		self.scaleback = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = self.mousedetect4 + 1
		self.mousedetect5 = 0
	end

	if love.mouse.getX() < (love.graphics.getWidth()/2 - 290) - start.font2:getWidth( "<" )/2 + start.font2:getWidth( "<" )
	and love.mouse.getX() > (love.graphics.getWidth()/2 - 310) - start.font2:getWidth( "<" )/2
	and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "<" )/2) + self.backy -20
	and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "<" )/2) + self.backy + start.font2:getHeight( "<" ) then
		self.survivalstatemouse = false
		self.arcadestatemouse = false
		self.endlessstatemouse = false
		self.stuckstatemouse = false
		self.backstatemouse = true
		self.scaleback = 1.4
		self.mouseover = false
		self.mouseoverback = true
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = 0
		self.mousedetect5 = self.mousedetect5 + 1
	end







	if love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "SURVIVAL MODE" )/2 + start.font2:getWidth( "SURVIVAL MODE" )) + 250 then
		self.survivalstatemouse = false
		self.arcadestatemouse = false
		self.endlessstatemouse = false
		self.stuckstatemouse = false
		self.mouseover = false
	end
	
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "SURVIVAL MODE" )/2) - 50 then
		self.survivalstatemouse = false
		self.arcadestatemouse = false
		self.endlessstatemouse = false
		self.stuckstatemouse = false
		self.mouseover = false
	end
	
	if love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "SURVIVAL MODE" )/2 - 245) then
		self.survivalstatemouse = false
		self.arcadestatemouse = false
		self.endlessstatemouse = false
		self.stuckstatemouse = false
		self.mouseover = false
	end

	if love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "STUCKINTHEMUD" )/2 + 55 + start.font2:getHeight( "STUCKINTHEMUD" )) then
		self.survivalstatemouse = false
		self.arcadestatemouse = false
		self.endlessstatemouse = false
		self.stuckstatemouse = false
		self.mouseover = false
	end


	if love.mouse.getX() > (love.graphics.getWidth()/2 - 290) - start.font2:getWidth( "<" )/2 + start.font2:getWidth( "<" ) then
		self.backstatemouse = false
		self.mouseoverback = false
	end 
	
	if love.mouse.getX() < (love.graphics.getWidth()/2 - 310) - start.font2:getWidth( "<" )/2 then
		self.backstatemouse = false
		self.mouseoverback = false
	end

	if love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "<" )/2) + self.backy -20 then
		self.backstatemouse = false
		self.mouseoverback = false
	end 

	if love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "<" )/2) + self.backy + start.font2:getHeight( "<" ) then
		self.backstatemouse = false
		self.mouseoverback = false
	end







	if self.survivalstatemouse == true or self.survivalstate == true then
		if self.flashbuttonsurvival == true then
			self.buttonflashsurvival = self.buttonflashsurvival + dt + 2
		elseif self.flashbuttonsurvival == false then
			self.buttonflashsurvival = self.buttonflashsurvival + dt - 2
		end
	
		if self.buttonflashsurvival > 100 then
			self.flashbuttonsurvival = false
		elseif self.buttonflashsurvival < 2 then
			self.flashbuttonsurvival = true
		end
	
	elseif self.survivalstatemouse == false or self.survivalstate == false then
		self.flashbuttonsurvival = true
		self.buttonflashsurvival = 0
	end




	if self.arcadestatemouse == true or self.arcadestate == true then
		if self.flashbuttonarcade == true then
			self.buttonflasharcade = self.buttonflasharcade + dt + 2
		elseif self.flashbuttonarcade == false then
			self.buttonflasharcade = self.buttonflasharcade + dt - 2
		end
	
		if self.buttonflasharcade > 100 then
			self.flashbuttonarcade = false
		elseif self.buttonflasharcade < 2 then
			self.flashbuttonarcade = true
		end
	
	elseif self.arcadestatemouse == false or self.arcadestate == false then
		self.flashbuttonarcade = true
		self.buttonflasharcade = 0
	end




	if self.endlessstatemouse == true or self.endlessstate == true then
		if self.flashbuttonendless == true then
			self.buttonflashendless = self.buttonflashendless + dt + 2
		elseif self.flashbuttonendless == false then
			self.buttonflashendless = self.buttonflashendless + dt - 2
		end
	
		if self.buttonflashendless > 100 then
			self.flashbuttonendless = false
		elseif self.buttonflashendless < 2 then
			self.flashbuttonendless = true
		end
	
	elseif self.endlessstatemouse == false or self.endlessstate == false then
		self.flashbuttonendless = true
		self.buttonflashendless = 0
	end




	if self.stuckstatemouse == true or self.stuckstate == true then
		if self.flashbuttonstuck == true then
			self.buttonflashstuck = self.buttonflashstuck + dt + 2
		elseif self.flashbuttonstuck == false then
			self.buttonflashstuck = self.buttonflashstuck + dt - 2
		end
	
		if self.buttonflashstuck > 100 then
			self.flashbuttonstuck = false
		elseif self.buttonflashstuck < 2 then
			self.flashbuttonstuck = true
		end
	
	elseif self.stuckstatemouse == false or self.stuckstate == false then
		self.flashbuttonstuck = true
		self.buttonflashstuck = 0
	end




	if self.backstatemouse == true or self.backstate == true then
		if self.flashbuttonback == true then
			self.buttonflashback = self.buttonflashback + dt + 2
		elseif self.flashbuttonback == false then
			self.buttonflashback = self.buttonflashback + dt - 2
		end
	
		if self.buttonflashback > 100 then
			self.flashbuttonback = false
		elseif self.buttonflashback < 2 then
			self.flashbuttonback = true
		end
	
	elseif self.backstatemouse == false or self.backstate == false then
		self.flashbuttonback = true
		self.buttonflashback = 0
	end







	


	if self.mouseover == false then
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = 0
		love.audio.stop(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.stop(self.mouseover4)
	end

	if self.mousedetect1 == 1 then
		love.audio.play(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.stop(self.mouseover4)
		love.audio.stop(self.mouseover5)
	end

	if self.mousedetect2 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.play(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.stop(self.mouseover4)
		love.audio.stop(self.mouseover5)
	end

	if self.mousedetect3 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.play(self.mouseover3)
		love.audio.stop(self.mouseover4)
		love.audio.stop(self.mouseover5)
	end

	if self.mousedetect4 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.play(self.mouseover4)
		love.audio.stop(self.mouseover5)
	end





	if self.mouseoverback == false then
		self.mousedetect5 = 0
		love.audio.stop(self.mouseover5)
	end

	if self.mousedetect5 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.stop(self.mouseover4)
		love.audio.play(self.mouseover5)
	end



























end

function selectmode:keypressed(key)

	-- SELECT BUTTONS --
	-- Move arrow up through select mode menu states
	if key == "up" or key == "w" then
		love.audio.play(self.select1)
		love.audio.play(self.select2)
		love.audio.play(self.select3)
		love.audio.play(self.select4)
		self.arrowy = self.arrowy - 100

		if self.mouseover == true then
			love.mouse.setX((love.graphics.getWidth()/2 - 459/2) + 500)
		end
	end

	-- Move arrow up through select mode menu states
	if key == "down" or key == "s" then
		love.audio.play(self.select1)
		love.audio.play(self.select2)
		love.audio.play(self.select3)
		love.audio.play(self.select4)
		self.arrowy = self.arrowy + 100

		if self.mouseover == true then
			love.mouse.setX((love.graphics.getWidth()/2 - 459/2) + 500)
		end
	end
	-- SELECT BUTTONS --
 
 	-- ACTIVATE BUTTONS --
	-- Go back and forth between surival
	if key == "return" and self.survivalstate == true or key == " " and self.survivalstate == true or key == 'escape' and self.survival == true then
		self.survivalarrowx = self.survivalarrowx + 118
	end

	-- Go back and forth between arcade
	if key == "return" and self.arcadestate == true or key == " " and self.arcadestate == true or key == 'escape' and self.arcade == true then
		self.arcadearrowx = self.arcadearrowx + 118
	end
  
  	-- Go to the endless game mode
	if key == "return" and self.endlessstate == true or key == " " and self.endlessstate == true then
		Gamestate.push(endless)
		game.endless = true
		love.audio.play(self.entersound1)
		love.audio.stop(start.music)
		love.audio.play(game.intromusic)
		start.easteregg = false
		love.audio.stop(start.colorgoeshere)
		game.intromusic:setVolume(0.6)
		game.intromusic:setLooping(true)
	end

	-- Go to the stuck game mode
	if key == "return" and self.stuckstate == true or key == " " and self.stuckstate == true then
		Gamestate.push(stuckmode)
		game.stuck = true
		love.audio.play(self.entersound1)
		love.audio.stop(start.music)
		love.audio.play(game.intromusic)
		start.easteregg = false
		love.audio.stop(start.colorgoeshere)
		game.intromusic:setVolume(0.6)
		game.intromusic:setLooping(true)
	end

	-- Enter sounds for survial and arcade
	if key == "return" and self.survivalstate == true and self.survival == false or key == " " and self.survivalstate == true and self.survival == false then
		love.audio.play(self.entersound1)
	end	

	if key == "return" and self.arcadestate == true and self.arcade == false or key == " " and self.arcadestate == true and self.arcade == false then
		love.audio.play(self.entersound1)
	end

	-- Exit sounds for survival and arcade
	if key == "return" and self.survivalstate == true and self.survival == true or key == " " and self.survivalstate == true and self.survival == true or key == 'escape' and self.survivalstate == true and self.survival == true then
		love.audio.play(self.backsound)
	end	

	if key == "return" and self.arcadestate == true and self.arcade == true or key == " " and self.arcadestate == true and self.arcade == true or key == 'escape' and self.arcadestate == true and self.arcade == true then
		love.audio.play(self.backsound)
	end
	-- ACTIVATE BUTTONS --

	-- Go back to main menu
	if key == 'escape' and self.survival == false and self.arcade == false then
		Gamestate.pop()
		love.audio.play(self.backsound)
	end
end
















function selectmode:mousepressed(mx, my, button)

	if button == "l" and self.survivalstate == true and self.backstatemouse == false or button == "r" and self.survivalstate == true and self.backstatemouse == false then
		self.survivalarrowx = self.survivalarrowx + 118
	end

	if button == "l" and self.arcadestate == true and self.backstatemouse == false or button == "r" and self.arcadestate == true and self.backstatemouse == false then
		self.arcadearrowx = self.arcadearrowx + 118
	end

	if button == "l" and self.endlessstatemouse == true and self.backstatemouse == false then
		Gamestate.push(endless)
		game.endless = true
		love.audio.play(self.entersound1)
		love.audio.stop(start.music)
		love.audio.play(game.intromusic)
		start.easteregg = false
		love.audio.stop(start.colorgoeshere)
		game.intromusic:setVolume(0.6)
		game.intromusic:setLooping(true)
	end

	if button == "l" and self.stuckstatemouse == true and self.backstatemouse == false then
		Gamestate.push(stuckmode)
		game.stuck = true
		love.audio.play(self.entersound1)
		love.audio.stop(start.music)
		love.audio.play(game.intromusic)
		start.easteregg = false
		love.audio.stop(start.colorgoeshere)
		game.intromusic:setVolume(0.6)
		game.intromusic:setLooping(true)
	end

	if button == "l" and self.survivalstate == true and self.survival == false and self.backstatemouse == false or button == "r" and self.survivalstate == true and self.survival == false and self.backstatemouse == false then
		love.audio.play(self.entersound1)
	end
	
	if button == "l" and self.arcadestate == true and self.arcade == false and self.backstatemouse == false or button == "r" and self.arcadestate == true and self.arcade == false and self.backstatemouse == false then
		love.audio.play(self.entersound1)
	end
	
	if button == "l" and self.survivalstate == true and self.survival == true and self.backstatemouse == false or button == "r" and self.survivalstate == true and self.survival == true and self.backstatemouse == false then
		love.audio.play(self.backsound)
	end
	
	if button == "l" and self.arcadestate == true and self.arcade == true and self.backstatemouse == false or button == "r" and self.arcadestate == true and self.arcade == true and self.backstatemouse == false then
		love.audio.play(self.backsound)
	end

	if button == "l" and self.backstatemouse == true then
		Gamestate.pop()
		love.audio.play(self.backsound)
	end

	if button == "r" and self.survival == false and self.arcade == false then
		Gamestate.pop()
		love.audio.play(self.backsound)
	end
end



















function selectmode:draw()
	
	------ FILTERS ------
	start.bg:setFilter( 'nearest', 'nearest' )
	start.font1:setFilter( 'nearest', 'nearest' )
	start.font2:setFilter( 'nearest', 'nearest' )
	self.screenshot1:setFilter( 'nearest', 'nearest' )
	self.screenshot2:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	------ IMAGES ------
	love.graphics.draw(start.bg, 0, -1000, 0, 3)
	
	-- Draws screenshot if in survival
	if self.survival == true then
		love.graphics.draw(self.screenshot2, 0, -50, 0, 0.6)
	end

	-- Draws screenshot if in arcade
	if self.arcade == true then
		love.graphics.draw(self.screenshot1, 0, -50, 0, 0.6)
	end
	------ IMAGES ------

	------ SHAPES ------
	-- Only draw arrow if not in survival or arcade
	if self.survival == false and self.arcade == false then
		love.graphics.setColor(160, 47, 0)
		love.graphics.rectangle("fill", self.arrowx, (love.graphics.getHeight()/2 - 28/2) + self.arrowy - 8 - 345, 28, 28 )
	end
	------ SHAPES ------

	------ TEXT ------
	-- Only draw buttons if not in survival or arcade
	if self.survival == false and self.arcade == false then
		love.graphics.setFont( start.font2 )
		love.graphics.setColor(160, 47, 0, 100)
		love.graphics.print('SURVIVAL MODE', (love.graphics.getWidth()/2 - start.font2:getWidth( "SURVIVAL MODE" )/2), (love.graphics.getHeight()/2 - 30/2 - 245), 0, self.scalesurvival)
		love.graphics.setColor(255, 255, 255, self.buttonflashsurvival)
		love.graphics.print('SURVIVAL MODE', (love.graphics.getWidth()/2 - start.font2:getWidth( "SURVIVAL MODE" )/2), (love.graphics.getHeight()/2 - 30/2 - 245), 0, self.scalesurvival)
		love.graphics.setColor(160, 47, 0, 255)
		love.graphics.setFont( start.font1 )
		love.graphics.setColor(160, 47, 0, 100)
		love.graphics.print('(COMING SOON)', (love.graphics.getWidth()/2 - start.font1:getWidth( "(COMING SOON)" )/2), (love.graphics.getHeight()/2 - 30/2 - 245 + 35))
		love.graphics.setFont( start.font2 )
		love.graphics.setColor(160, 47, 0, 100)
		love.graphics.print('ARCADE MODE', (love.graphics.getWidth()/2 - start.font2:getWidth( "ARCADE MODE" )/2), (love.graphics.getHeight()/2 - 30/2 - 145), 0, self.scalearcade)
		love.graphics.setColor(255, 255, 255, self.buttonflasharcade)
		love.graphics.print('ARCADE MODE', (love.graphics.getWidth()/2 - start.font2:getWidth( "ARCADE MODE" )/2), (love.graphics.getHeight()/2 - 30/2 - 145), 0, self.scalearcade)
		love.graphics.setColor(160, 47, 0, 255)
		love.graphics.setFont( start.font1 )
		love.graphics.setColor(160, 47, 0, 100)
		love.graphics.print('(COMING SOON)', (love.graphics.getWidth()/2 - start.font1:getWidth( "(COMING SOON)" )/2), (love.graphics.getHeight()/2 - 30/2 - 145 + 35))
		love.graphics.setFont( start.font2 )
		love.graphics.setColor(160, 47, 0)
		love.graphics.print('ENDLESS MODE', (love.graphics.getWidth()/2 - start.font2:getWidth( "ENDLESS MODE" )/2), (love.graphics.getHeight()/2 - 30/2 - 45), 0, self.scaleendless)
		love.graphics.setColor(255, 255, 255, self.buttonflashendless)
		love.graphics.print('ENDLESS MODE', (love.graphics.getWidth()/2 - start.font2:getWidth( "ENDLESS MODE" )/2), (love.graphics.getHeight()/2 - 30/2 - 45), 0, self.scaleendless)
		love.graphics.setColor(160, 47, 0, 255)
		love.graphics.print('STUCKINTHEMUD', (love.graphics.getWidth()/2 - start.font2:getWidth( "STUCKINTHEMUD" )/2), (love.graphics.getHeight()/2 - 30/2 + 55), 0, self.scalestuck)
		love.graphics.setColor(255, 255, 255, self.buttonflashstuck)
		love.graphics.print('STUCKINTHEMUD', (love.graphics.getWidth()/2 - start.font2:getWidth( "STUCKINTHEMUD" )/2), (love.graphics.getHeight()/2 - 30/2 + 55), 0, self.scalestuck)
		love.graphics.setColor(160, 47, 0, 255)

		-- Back arrow for mouse
		love.graphics.print('<', (love.graphics.getWidth()/2 - 320), (love.graphics.getHeight()/2 - start.font2:getHeight( "<" )/2) + self.backy, 0, self.scaleback)
		love.graphics.setColor(255, 255, 255, self.buttonflashback)
		love.graphics.print('<', (love.graphics.getWidth()/2 - 320), (love.graphics.getHeight()/2 - start.font2:getHeight( "<" )/2) + self.backy, 0, self.scaleback)
		love.graphics.setColor(160, 47, 0, 255)

		-- Draw discription text for each gamemode
		if self.survivalstate == true then
			love.graphics.setFont( start.font1 )
			love.graphics.print("SURVIVE! FIND FOOD, SHELTER,", (love.graphics.getWidth()/2 - start.font1:getWidth( "SURVIVE! FIND FOOD, SHELTER," )/2), (love.graphics.getHeight()/2 - 30/2 + 190))
			love.graphics.print("WEAPONS, AMMUNITION AND TOOLS TO", (love.graphics.getWidth()/2 - start.font1:getWidth( "WEAPONS, AMMUNITION AND TOOLS TO" )/2), (love.graphics.getHeight()/2 - 30/2 + 225))
			love.graphics.print("HELP YOU FEND OFF THE UNDEAD.", (love.graphics.getWidth()/2 - start.font1:getWidth( "HELP YOU FEND OFF THE UNDEAD." )/2), (love.graphics.getHeight()/2 - 30/2 + 260))
		end

		if self.arcadestate == true then
			love.graphics.setFont( start.font1 )
			love.graphics.print("SURVIVE! (UNTIL THE END) FIGHT WAVES", (love.graphics.getWidth()/2 - start.font1:getWidth( "SURVIVE! (UNTIL THE END) FIGHT WAVES" )/2), (love.graphics.getHeight()/2 - 30/2 + 190))
			love.graphics.print("OF UNDEAD AND UPGRADE YOUR ARSENAL", (love.graphics.getWidth()/2 - start.font1:getWidth( "OF UNDEAD AND UPGRADE YOUR ARSENAL" )/2), (love.graphics.getHeight()/2 - 30/2 + 225))
			love.graphics.print("WHILE YOURE AT IT.", (love.graphics.getWidth()/2 - start.font1:getWidth( "WHILE YOURE AT IT." )/2), (love.graphics.getHeight()/2 - 30/2 + 260))
		end

		if self.endlessstate == true then
			love.graphics.setFont( start.font1 )
			love.graphics.print("SURVIVE! (AS LONG AS YOU CAN)", (love.graphics.getWidth()/2 - start.font1:getWidth( "SURVIVE! (AS LONG AS YOU CAN)" )/2), (love.graphics.getHeight()/2 - 30/2 + 190))
			love.graphics.print("DEFEND YOURSELF AGAINST AN ENDLESS HORDE", (love.graphics.getWidth()/2 - start.font1:getWidth( "DEFEND YOURSELF AGAINST AN ENDLESS HORDE" )/2), (love.graphics.getHeight()/2 - 30/2 + 225))
			love.graphics.print("OF ZOMBIES FOR THAT SWEET HIGH SCORE.", (love.graphics.getWidth()/2 - start.font1:getWidth( "OF ZOMBIES FOR THAT SWEET HIGH SCORE." )/2), (love.graphics.getHeight()/2 - 30/2 + 260))
		end

		if self.stuckstate == true then
			love.graphics.setFont( start.font1 )
			love.graphics.print("SURVIVE! (YOU'RE STUCK IN MUD, BY THE WAY.)", (love.graphics.getWidth()/2 - start.font1:getWidth( "SURVIVE! (YOU'RE STUCK IN MUD, BY THE WAY.)" )/2), (love.graphics.getHeight()/2 - 30/2 + 190))
			love.graphics.print("FAST REFLEXES AND A QUICK TRIGGER FINGER", (love.graphics.getWidth()/2 - start.font1:getWidth( "FAST REFLEXES AND A QUICK TRIGGER FINGER" )/2), (love.graphics.getHeight()/2 - 30/2 + 225))
			love.graphics.print("ARE KEY TO SURVIVING IN THIS GAME MODE.", (love.graphics.getWidth()/2 - start.font1:getWidth( "ARE KEY TO SURVIVING IN THIS GAME MODE." )/2), (love.graphics.getHeight()/2 - 30/2 + 260))
		end
	end

	-- Draw text if in survival
	if self.survival == true then
		love.graphics.setFont( start.font2 )
		love.graphics.setColor(160, 47, 0)
		love.graphics.print('SURVIVAL MODE (COMING SOON)', (love.graphics.getWidth()/2 - start.font2:getWidth( "SURVIVAL MODE (COMING SOON)" )/2), (love.graphics.getHeight()/2 - 30/2 + 150))
	end

	-- Draw text if in arcade
	if self.arcade == true then
		love.graphics.setFont( start.font2 )
		love.graphics.setColor(160, 47, 0)
		love.graphics.print('ARCADE MODE (COMING SOON)', (love.graphics.getWidth()/2 - start.font2:getWidth( "ARCADE MODE (COMING SOON)" )/2), (love.graphics.getHeight()/2 - 30/2 + 150))
	end

	love.graphics.setColor(255, 255, 255)
	------ TEXT ------
end

return selectmode