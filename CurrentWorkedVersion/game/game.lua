-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads camera script
local camera = require "libs/hump/camera"

-- Loads Hardon Collider script
local HC = require 'libs/hardoncollider'

-- Loads pause script
pause = require 'game/pause'

-- Loads player script
player = require 'game/player'

-- Loads player script
gun = require 'game/gun'

-- Loads player script
ship = require 'game/ship'

-- Loads astroids script
astroids = require 'game/astroids'

-- Creates game as a new gamestate
game = Gamestate.new()


function game:init()

	-- Set up for hardon collider
	Collider = HC(100, on_collision, collision_stop)

	-- Load player
    player:initialize()
    
    -- Load gun
    gun:initialize()

    -- Load ship
    ship:initialize()
	
	------ VARIABLES ------
	-- Camera and zoom vars
	self.Cam = camera(plyr.x, plyr.y, 2.5)
	self.ZoomCam = false
	
	-- Button and arrow areas
	self.BtnY = 440	
	self.BtnX = 530
	self.ArrowX = 480

	-- Welcome message vars
	self.WelcomeButtonArea = false
	self.WelcomeMouseDetect = 0
	self.WelcomeMouseOnBtn = false
	self.Welcome = true

	-- GameOver vars
	self.GameOver = false
	self.GameOverMouseBackArea = false
	self.GameOverMouseDetect = 0
	self.GameOverMouseOnBtn = false
	self.GameOverArrowX = 450
	------ VARIABLES ------

	------ IMAGES ------
	self.GameBG = love.graphics.newImage("images/largespacebg.png")
	------ IMAGES ------

	------ AUDIO ------
	GameMusic = love.audio.newSource("audio/gamemusic.ogg")
	self.GameSelect1M = love.audio.newSource("audio/sel.ogg")
	self.GameEnter = love.audio.newSource("audio/enter.ogg")
	------ AUDIO ------

	------ FONTS ------
	self.InteractFont = love.graphics.newFont("fonts/xen3.ttf", 10)
	self.BtnFont = love.graphics.newFont("fonts/xen3.ttf", 50)
	self.GameOverText = love.graphics.newFont("fonts/xen3.ttf", 40)
	self.GameOverTitleFont = love.graphics.newFont("fonts/xen3.ttf", 90)
	self.WelcomeFont = love.graphics.newFont("fonts/xen3.ttf", 20)
	------ FONTS ------
end

function on_collision(dt, shape_a, shape_b)
	player:collision(dt, shape_a, shape_b)
	ship:collision(dt, shape_a, shape_b)
	astroids:collision(dt, shape_a, shape_b)
end

function collision_stop(dt, shape_a, shape_b)
	player:collisionstopped(dt, shape_a, shape_b)
	ship:collisionstopped(dt, shape_a, shape_b)
	astroids:collisionstopped(dt, shape_a, shape_b)
end

function game:keypressed(key)

  	if key == "return" and game.Welcome == true then
  		
  		-- turn game reset off
  		GameReset = false
  		
  		-- turn welcome screen off
  		game.Welcome = false
  		
  		-- play sound effect for enter
  		love.audio.play(game.GameEnter)
  	end

  	if key == "return" and game.GameOver == true then
  		
  		-- play sound effect for enter
  		love.audio.play(game.GameEnter)
    	
  		-- Tells the game script to switch to the menu script
    	Gamestate.switch(menu)
    	
    	-- Stops game music and plays menu music
    	love.audio.play(MenuMusic)
    	MenuMusic:setLooping(true)
   		love.audio.stop(GameMusic)
    	
   		-- Reset the game
    	GameReset = true
  	end

  	-- Pause the game
  	if key == "escape" and Paused == false and game.Welcome == false then
   		Paused = true
   		Resume = false
   		love.mouse.setCursor(cursor)
  	end

  	-- Zoom game camera in by 1
    if key == "x" and game.ZoomCam == false and game.GameOver == false then
		game.Cam:zoom(2)
		game.ZoomCam = true
	end

	-- Zoom game camera back to default
	if key == "z" and game.ZoomCam == true and game.GameOver == false then
		game.Cam:zoom(0.5)
		game.ZoomCam = false
	end

	-- If you are near the ship and you push "e" enter the ship
	if key == "e" and sship.yes == true then
		sship.entered = true
		sship.owned = true
		
		-- change cursor back to pointer
		love.mouse.setCursor(cursor)
	end

	-- If you are in the ship and you push "e" exit the ship
	if key == "e" and sship.entered == true and sship.exited == true then
		sship.entered = false
		sship.exited = false
		
		-- change cursor back to pointer
		love.mouse.setCursor(cursor)
		
		-- Stop all ship sounds
		love.audio.stop(ship.IdleSound)
		love.audio.stop(ship.ThrustSound)
		love.audio.stop(ship.BoostSound)
	end

	-- If you are near the gun and you push "e" pick up the gun
	if key == "e" and pistol.yes == true then
		pistol.HaveGun = true
	end

	-- If you have the gun and you push "q" then drop the gun
	if key == "q" and pistol.HaveGun == true and sship.entered == false then
		pistol.HaveGun = false
	end
end

function game:mousepressed(mx, my, button)

	-- Update the mousepressed of the gun
	gun:shooting(mx, my, button)

	------ WELCOME AND GAMEOVER BUTTONS ------
	-- Tells welcome to continue onto the game
	if button == "l" and game.WelcomeButtonArea == true and game.Welcome == true then
		
		-- turn game reset off
		GameReset = false
  		
  		-- turn welcome screen off
  		game.Welcome = false
  		
  		-- play sound effect for enter
  		love.audio.play(game.GameEnter)
  	end

  	-- Tells game to continue onto the main menu
  	if button == "l" and game.GameOverMouseBackArea == true and game.GameOver == true then
		
		-- play sound effect for enter
		love.audio.play(game.GameEnter)
    	
    	-- Tells the game script to switch to the menu script
    	Gamestate.switch(menu)
    	
    	-- Stops game music and plays menu music
    	love.audio.play(MenuMusic)
    	MenuMusic:setLooping(true)
   		love.audio.stop(GameMusic)
    	
    	-- Reset the game
    	GameReset = true
  	end
  	------ WELCOME AND GAMEOVER BUTTONS ------
end

function game:update(dt)

	------ CAMERA ------
	dx,dy = (plyr.x) - game.Cam.x, (plyr.y) - game.Cam.y
	game.Cam:move(dx/2, dy/2)
	mx1,my1 = game.Cam:mousepos()
	------ CAMERA ------

	-- Update player
	player:update(dt)
	player:health(dt)
	
	-- Update gun
	gun:update(dt)

	-- Update ship
	ship:update(dt)
	ship:health(dt)

	Collider:update(dt)

    -- if game is paused switch to the pause screen
	if Paused == true then
		Gamestate.switch(pause)

		-- Stop the ship idle sound for when you go to pause screen
		love.audio.stop(ship.IdleSound)
	end 

	-- Reset the game back to default for when you start a new game
	if GameReset == true then

		-- Reset player
		plyr.y = 400
		plyr.x = 800
		plyr.movementstop = false
		plyr.speed = 70
		plyr.health = 100
		player.Tired = false
		player.TiredTime = 0 
		player.Sprint = false
		player.SprintTime = 0

		-- Reset gun
		pistol.GunY = plyr.y
		pistol.GunX = plyr.x
		pistol.HaveGun = false
		pistol.yes = false
		pistol.itemx = 750
		pistol.itemy = 380
		gun.ShotTime = 0
		gun.ShotTimePlus = 0
		gun.Bullets = {}
		gun.GunShot = false
		gun.GunShot1 = false

		-- Reset ship
		sship.x = 456
		sship.y = 490
		sship.health = 200
		sship.entered = false
		sship.yes = false
		sship.owned = false
		sship.exited = false
		sship.dead = false
		ship.BoostTired = false
		ship.BoostTiredTime = 0 
		ship.Boost = false
		ship.BoostTime = 0

		-- Reset game vars
		game.Cam = camera(plyr.x, plyr.y, 2.5)
		game.ZoomCam = false
		Paused = false
		game.Welcome = true
		game.GameOver = false
		game.GameOverMouseBackArea = false
		game.GameOverMouseDetect = 0
		game.GameOverMouseOnBtn = false
		game.GameOverArrowX = 450
		
		-- Reset hardon collider hit boxes
		Collider = HC(100, on_collision, collision_stop)
		plyr.bb = Collider:addRectangle(plyr.x, plyr.y, plyr.w, plyr.h)
		sship.bb = Collider:addRectangle(sship.x, sship.y, sship.w, sship.h)
		pistol.bb = Collider:addRectangle(pistol.itemx, pistol.itemy,24,24)

		-- Reset/spawn astroids
		astroids:initialize()
		rock1 = astroids:spawn()
		rock2 = astroids:spawn()
		rock3 = astroids:spawn()
		rock4 = astroids:spawn()
		rock5 = astroids:spawn()
		rock6 = astroids:spawn()
		rock7 = astroids:spawn()
		rock8 = astroids:spawn()
		rock9 = astroids:spawn()
		rock10 = astroids:spawn()
	end
	
	------ WELCOME MOUSE ------
	-- MOUSE WELCOME AUDIO ONCE
	if game.WelcomeMouseOnBtn == false and game.Welcome == true then
		game.WelcomeMouseDetect = 0
		love.audio.stop(game.GameSelect1M)
	end

	if game.WelcomeMouseDetect == 1 and SetMute == false and game.Welcome == true then
		love.audio.play(game.GameSelect1M)
	end
	-- MOUSE WELCOME AUDIO ONCE
	
	-- Anything between the "MOUSE WELCOME AUDIO ONCE" comments:
	-- Ensures that the select audio only plays once for the welcome button when the mouse is moving over it


	-- MOUSE WELCOME OUT OF AREA	
	if love.mouse.getX() > ((love.graphics.getWidth()/2 - 320/2) + 320) and game.Welcome == true then
		game.WelcomeButtonArea = false
		game.WelcomeMouseOnBtn = false
	end

	if love.mouse.getX() < (love.graphics.getWidth()/2 - 320/2) and game.Welcome == true then
		game.WelcomeButtonArea = false
		game.WelcomeMouseOnBtn = false
	end

	if love.mouse.getY() < 440 and game.Welcome == true then
		game.WelcomeButtonArea = false
		game.WelcomeMouseOnBtn = false
	end

	if love.mouse.getY() > 485 and game.Welcome == true then
		game.WelcomeButtonArea = false
		game.WelcomeMouseOnBtn = false
	end
	-- MOUSE WELCOME OUT OF AREA

	-- Anything between the "MOUSE WELCOME OUT OF AREA" comments:
	-- makes sure that if the mouse goes out of a button area the button area is turned back to false


	-- MOUSE WELCOME BUTTON AREA
	if love.mouse.getX() > (love.graphics.getWidth()/2 - 320/2) and love.mouse.getX() < ((love.graphics.getWidth()/2 - 320/2) + 320) and love.mouse.getY() > 440 and love.mouse.getY() < 485 and game.Welcome == true then
		game.WelcomeButtonArea = true
		game.WelcomeMouseOnBtn = true
		game.WelcomeMouseDetect = game.WelcomeMouseDetect + 1
	end
	-- MOUSE WELCOME BUTTON AREA

	-- Anything between the "MOUSE WELCOME BUTTON AREA" comments:
	-- This tells the game if the mouse is over a certain button
	------ WELCOME MOUSE ------

	------ GAME OVER MOUSE ------
	-- MOUSE GAME OVER AUDIO ONCE
	if game.GameOverMouseOnBtn == false and game.GameOver == true then
		game.GameOverMouseDetect = 0
		love.audio.stop(game.GameSelect1M)
	end

	if game.GameOverMouseDetect == 1 and SetMute == false and game.GameOver == true then
		love.audio.play(game.GameSelect1M)
	end
	-- MOUSE GAME OVER AUDIO ONCE
	
	-- Anything between the "MOUSE GAME OVER AUDIO ONCE" comments:
	-- Ensures that the select audio only plays once for the game over button when the mouse is moving over it


	-- MOUSE GAME OVER OUT OF AREA
	if love.mouse.getX() > ((love.graphics.getWidth()/2 - 410/2) + 410) and game.GameOver == true then
		game.GameOverMouseBackArea = false
		game.GameOverMouseOnBtn = false
	end

	if love.mouse.getX() < (love.graphics.getWidth()/2 - 410/2) and game.GameOver == true then
		game.GameOverMouseBackArea = false
		game.GameOverMouseOnBtn = false
	end

	if love.mouse.getY() < 440 and game.GameOver == true then
		game.GameOverMouseBackArea = false
		game.GameOverMouseOnBtn = false
	end

	if love.mouse.getY() > 485 and game.GameOver == true then
		game.GameOverMouseBackArea = false
		game.GameOverMouseOnBtn = false
	end
	-- MOUSE GAME OVER OUT OF AREA

	-- Anything between the "MOUSE GAME OVER OUT OF AREA" comments:
	-- makes sure that if the mouse goes out of a button area the button area is turned back to false


	-- MOUSE GAME OVER BUTTON AREA
	if love.mouse.getX() > (love.graphics.getWidth()/2 - 410/2) and love.mouse.getX() < ((love.graphics.getWidth()/2 - 410/2) + 410) and love.mouse.getY() > 440 and love.mouse.getY() < 485 and game.GameOver == true then
		game.GameOverMouseBackArea = true
		game.GameOverMouseOnBtn = true
		game.GameOverMouseDetect = game.GameOverMouseDetect + 1
	end
	-- MOUSE GAME OVER BUTTON AREA

	-- Anything between the "MOUSE GAME OVER BUTTON AREA" comments:
	-- This tells the game if the mouse is over a certain button
	------ GAME OVER MOUSE ------
end

function love.focus(f)
	
	-- If the mouse loses focus from the game window pause the game
	if not f and not Paused and not game.Welcome then
		Paused = true
		Resume = false
   		love.mouse.setCursor(cursor)
	end
end

function game:draw()
	
	------ FILTERS ------
	game.GameBG:setFilter( 'nearest', 'nearest' )
	game.InteractFont:setFilter( 'nearest', 'nearest' )
	game.InteractFont:setFilter( 'nearest', 'nearest' )
	game.BtnFont:setFilter( 'nearest', 'nearest' )
	game.GameOverText:setFilter( 'nearest', 'nearest' )
	game.GameOverTitleFont:setFilter( 'nearest', 'nearest' )
	game.WelcomeFont:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------
	
	------ IN CAMERA ------
	-- Start of camera
	game.Cam:attach()
	
	-- Draws space background
	love.graphics.draw(game.GameBG, 0, 0)

	-- draw bullets
	gun:bulletdraw()

	-- Draw ship
	ship:draw()

	-- Draw player
	player:draw()

	-- Draw gun
	gun:draw()

	-- Draw astroids
	astroids:draw()

	-- Draw game hitboxes and other info when debugmode is active
	if SetDeb == true then
		debugmode:hitbox()
		debugmode:astroids()
		debugmode:bullets()
	end
	
	-- End of camera
	game.Cam:detach()
	------ IN CAMERA -----

	-- Draws Player Health and game hud
	love.graphics.setFont( game.WelcomeFont )
	love.graphics.setColor(25, 25, 25)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), 30 )
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("fill", 0, 30, love.graphics.getWidth(), 2 )
	love.graphics.setColor(0, 90, 255)
	love.graphics.rectangle("fill", 6, 6, plyr.health, 18 )
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("line", 6, 6, 100, 18 )
	love.graphics.setColor(255, 255, 255)
	love.graphics.print('Health', 20, 6)

	-- Draws ship health once you have obtained it
	if sship.owned == true then
		love.graphics.setColor(0, 255, 0)
		love.graphics.rectangle("fill", 112, 6, sship.health/2, 18 )
		love.graphics.setColor(255, 255, 255)
		love.graphics.rectangle("line", 112, 6, 100, 18 )
		love.graphics.setColor(255, 255, 255)
		love.graphics.print('Ship', 144, 6)
	end

	-- Draws game inventory hot bar
	love.graphics.rectangle("fill", (love.graphics.getWidth()/2 - 804/2), love.graphics.getHeight() - 62, 804, 64 )
	love.graphics.setColor(25, 25, 25)
	love.graphics.rectangle("fill", (love.graphics.getWidth()/2 + 2 - 804/2), love.graphics.getHeight() - 60, 800, 60 )
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("fill", (love.graphics.getWidth()/2 - 2 - 2/2), love.graphics.getHeight() - 60, 2, 60 )
	love.graphics.rectangle("fill", (love.graphics.getWidth()/2 - 102 - 2/2), love.graphics.getHeight() - 60, 2, 60 )
	love.graphics.rectangle("fill", (love.graphics.getWidth()/2 - 202 - 2/2), love.graphics.getHeight() - 60, 2, 60 )
	love.graphics.rectangle("fill", (love.graphics.getWidth()/2 - 302 - 2/2), love.graphics.getHeight() - 60, 2, 60 )
	love.graphics.rectangle("fill", (love.graphics.getWidth()/2 + 102 - 2/2), love.graphics.getHeight() - 60, 2, 60 )
	love.graphics.rectangle("fill", (love.graphics.getWidth()/2 + 202 - 2/2), love.graphics.getHeight() - 60, 2, 60 )
	love.graphics.rectangle("fill", (love.graphics.getWidth()/2 + 302 - 2/2), love.graphics.getHeight() - 60, 2, 60 )

	-- draw gun in inventory bar
	gun:hotbaritem()

	if game.GameOver == true then

		-- If you get a game over limt these varibles from change
		gun.ShotTime = 0
		gun.ShotTimePlus = 0
		gun.Bullets = { }
		gun.GunShot = false
		gun.GunShot1 = false
		plyr.movementstop = true
		sship.entered = false
		sship.yes = false
		sship.exited = false
		gun.HaveGun = false

		-- Game over text, box and button
		love.mouse.setCursor(cursor)
		love.graphics.rectangle("fill", (love.graphics.getWidth()/2 - 910/2), 55, 910, 510 )
    	love.graphics.setColor(0, 0, 0)
    	love.graphics.rectangle("fill", (love.graphics.getWidth()/2 - 900/2), 60, 900, 500 )
    	love.graphics.setColor(255,255,255)
    	love.graphics.setFont( game.GameOverTitleFont )
    	love.graphics.print('GAME OVER', (love.graphics.getWidth()/2 - game.GameOverTitleFont:getWidth( "GAME OVER" )/2), 120)
    	love.graphics.setFont( game.GameOverText )
		love.graphics.rectangle("fill", (love.graphics.getWidth()/2 - 410/2), game.BtnY + 5, 29, 35 )
  		love.graphics.rectangle("fill", (love.graphics.getWidth()/2 - 410/2) + 381, game.BtnY + 5, 29, 35 )
		love.graphics.print("Good game, well played,", (love.graphics.getWidth()/2 - game.GameOverText:getWidth( "Good game, well played," )/2), 230)
		love.graphics.print("my friend, however you", (love.graphics.getWidth()/2 - game.GameOverText:getWidth( "my friend, however you" )/2), 270)
		love.graphics.print("were utterly obliterated", (love.graphics.getWidth()/2 - game.GameOverText:getWidth( "were utterly obliterated" )/2), 310)
		love.graphics.print("in these circumstances", (love.graphics.getWidth()/2 - game.GameOverText:getWidth( "in these circumstances" )/2), 350)
		love.graphics.setFont( game.BtnFont )
		love.graphics.print('Main Menu', (love.graphics.getWidth()/2 - game.BtnFont:getWidth( "Main Menu" )/2), game.BtnY)
	end

    if game.Welcome == true then
    	
    	-- Welcome text, box and button
    	love.mouse.setCursor(cursor)
    	love.graphics.rectangle("fill", (love.graphics.getWidth()/2 - 910/2), 55, 910, 510 )
    	love.graphics.setColor(0, 0, 0)
    	love.graphics.rectangle("fill", (love.graphics.getWidth()/2 - 900/2), 60, 900, 500 )
    	love.graphics.setColor(255,255,255)
    	love.graphics.setFont( game.WelcomeFont )
		love.graphics.rectangle("fill", (love.graphics.getWidth()/2 - 320/2), game.BtnY + 5, 29, 35 )
		love.graphics.rectangle("fill", (love.graphics.getWidth()/2 - 320/2) + 291, game.BtnY + 5, 29, 35 )
		love.graphics.print('Welcome!', (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "Welcome!" )/2), 110)
		love.graphics.print("Thank you for taking the time to test Piquant Interactive's project, Space Game.", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "Thank you for taking the time to test Piquant Interactive's project, Space Game." )/2), 176)
		love.graphics.print("The current version solely involves a minigame which has you battle inanimate", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "The current version solely involves a minigame which has you battle inanimate!" )/2), 194)
		love.graphics.print("asteroids in a star field. Exhilarating, right??", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "asteroids in a star field. Exhilarating, right??" )/2), 212)
		love.graphics.print("Leave any feedback you may have at [http://www.reddit.com/r/piquant2013/]", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "Leave any feedback you may have at [http://www.reddit.com/r/piquant2013/]" )/2), 248)
		love.graphics.print("as we love player interaction.", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "as we love player interaction." )/2), 266)
		love.graphics.print("Controls:", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "Controls:" )/2), 302)
		love.graphics.print("Movement - W = Up, S = Down, A = Left, D = Right", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "Movement - W = Up, S = Down, A = Left, D = Right" )/2), 320)
		love.graphics.print("Gun - Mouse = Aim, LeftClick = Shoot", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "Gun - Mouse = Aim, LeftClick = Shoot" )/2), 338)
		love.graphics.print("Camera - X = Zoom In, Z = Zoom Out", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "Camera - X = Zoom In, Z = Zoom Out" )/2), 356)
		love.graphics.print("Interaction - E = Activate, Q = Drop", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "Interaction - E = Activate, Q = Drop" )/2), 374)
		love.graphics.print("Other - Esc = Pause, LeftShift = Sprint/Boost", (love.graphics.getWidth()/2 - game.WelcomeFont:getWidth( "Other - Esc = Pause, LeftShift = Sprint/Boost" )/2), 392)
		love.graphics.setFont( game.BtnFont )
		love.graphics.print('Continue', (love.graphics.getWidth()/2 - game.BtnFont:getWidth( "Continue" )/2), game.BtnY)
	end
end

return game