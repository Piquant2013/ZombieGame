-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads Hardon Collider script
local HC = require 'libs/hardoncollider'

-- Loads gamestate script
game = require 'game/game'

-- Creates stuckmode as a new gamestate
stuckmode = Gamestate.new()


function stuckmode:init()

	------ VARIABLES ------
	-- load main game mechanics
	game:init()
	
	-- scores
	self.score = 0
	self.time = 0
	self.wave = 1

	-- For the spawn system
	self.kills = 0
	self.wavedrawtime = 0
	self.wavestart = true
	self.wavezombiecount = 14
	------ VARIABLES ------

	------ IMAGES ------
	self.layer1 = love.graphics.newImage("images/maps/endless-layer1.png")
	self.layer2 = love.graphics.newImage("images/maps/endless-layer2.png")
	------ IMAGES ------
end

function stuckmode:keypressed(key)
	
	-- load game keyborad inputs for welcome screen, gameover, etc
	game:keypressed(key)
end

function stuckmode:mousepressed(mx, my, button)
	
	-- load crpistol mouse input
	clickratepistol:shooting(mx, my, button)
end

function stuckmode:update(dt)

	-- update main game mechanics
	game:update(dt)

	-- SET UP GAME --
	-- Reset the game
	if gamereset == true then

		-- Player
		plyr.y = 465
		plyr.x = 800
		plyr.speed = 0
		plyr.health = 100
		plyr.hurt = false
		plyr.colliding = false
		player.hurttimer = 0
		player.flashred = false
		player.autoheal = true

		-- Pistol
		clickratepistol.crp.y = plyr.y
		clickratepistol.crp.x = plyr.x
		clickratepistol.cooldown = 0
		clickratepistol.cooldownplus = 0
		clickratepistol.bullets = {}

		-- gameover or welcome screens
		welcomescreen = true
		gameover = false

		-- scores
		self.score = 0
		self.time = 0
		self.wave = 1
		
		-- For the spawn system
		self.kills = 0
		self.wavedrawtime = 0
		self.wavestart = true
		self.wavezombiecount = 50

		-- Globals
		paused = false
		
		-- Zombie
    	zombie.zombs = {}
    	zombie.spawnrate = 0
		zombie.spawnrateplus = 0.4
		zombie.speed = 60
		zombie.health = 1
		zombie.count = 0

		-- hardon collider
		Collider = HC(100, on_collision, collision_stop)
		plyr.bb = Collider:addRectangle(plyr.x, plyr.y, plyr.w, plyr.h)
	end
	-- SET UP GAME --

	-- update gun
	clickratepistol:update(dt)

	-- set vars for gameover
	if gameover == true then
		clickratepistol.cooldown = 0
		clickratepistol.cooldownplus = 0
		clickratepistol.bullets = {}
		plyr.y = plyr.y
		plyr.x = plyr.x
		love.mouse.setCursor(cursor)
	end

	-- WAVE SYSTEM --
	-- start the score time
	if gameover == false then
		self.time = self.time + dt
	end

	-- Start the wave draw timer
	if gameover == false then
		self.wavedrawtime = self.wavedrawtime + dt
	end

	-- spawn zombies
	if self.wavestart == true then
		zombie:spawn()
	end

	-- stop spawning if zombie.count gets to high 
	if zombie.count == self.wavezombiecount then
		self.wavestart = false
	elseif zombie.count < self.wavezombiecount then
		self.wavestart = true
	end

	-- when you kill 100 go to next wave, increase spawn rate, increase spawn amount
	if self.kills > 100 then
		self.kills = 0
		zombie.spawnrateplus = zombie.spawnrateplus - 0.01
		self.wavedrawtime = 0
		self.wave = self.wave + 1
		self.wavezombiecount = self.wavezombiecount + 6
	end

	-- lock the spawn rate
	if zombie.spawnrateplus < 0.1 then
		zombie.spawnrateplus = 0.1
	end

	-- lock the wave count
	if self.wavezombiecount > 150 then
		self.wavezombiecount = 150
	end
	-- WAVE SYSTEM --

	-- update zombies
	zombie:update(dt)
end

function stuckmode:draw()
	
	------ FILTERS ------
	self.layer1:setFilter( 'nearest', 'nearest' )
	self.layer2:setFilter( 'nearest', 'nearest' )
	start.font1:setFilter( 'nearest', 'nearest' )
	start.font2:setFilter( 'nearest', 'nearest' )
	start.font3:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------
	
	------ CAMERA ------
	game.Cam:attach()

	-- layer1 of the map
	love.graphics.draw(self.layer1, 0, 0)

	-- bullet
	clickratepistol:bulletdraw()

	-- player (red flash when player is hurt)
	if player.flashred == true then
		love.graphics.setColor(255, 57, 0)
		player:draw()
		love.graphics.setColor(255, 255, 255)
	elseif player.flashred == false then
		love.graphics.setColor(255, 255, 255)
		player:draw()
		love.graphics.setColor(255, 255, 255)
	end

	-- pistol
	clickratepistol:draw()

	-- zombies
	zombie:draw()

	-- layer2 of the map
	love.graphics.draw(self.layer2, 0, 0)

	game.Cam:detach()
	------ CAMERA ------
	
	------ TEXT ------
	-- wave title
	if self.wavedrawtime < 3 then
		love.graphics.setFont( start.font3 )
   		love.graphics.setColor(160, 47, 0)
		love.graphics.print("WAVE "..tostring(self.wave), (love.graphics.getWidth()/2 - start.font3:getWidth("WAVE "..tostring(self.wave))/2), 200)
		love.graphics.setColor(255, 255, 255)
	end

	-- the hud and the hud text
	if gameover == false then
		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), 30)
		love.graphics.setFont( start.font1 )
		love.graphics.setColor(160, 47, 0)
		love.graphics.print("HP:"..tostring(math.floor(plyr.health)), 100, 10)
		love.graphics.print("TIME:"..tostring(math.floor(self.time)), 350, 10)
		love.graphics.print("SCORE:"..tostring(self.score), 710, 10)
		love.graphics.print("WAVE:"..tostring(self.wave), 1020, 10)
		love.graphics.setColor(255, 255, 255)

	-- Game over title and the scores at the end of the game
	elseif gameover == true then
    	love.graphics.setFont( start.font3 )
    	love.graphics.setColor(160, 47, 0)
    	love.graphics.print('GAME OVER', (love.graphics.getWidth()/2 - start.font3:getWidth( "GAME OVER" )/2), 200)
		love.graphics.print("TIME:"..tostring(math.floor(self.time)), (love.graphics.getWidth()/2 - start.font3:getWidth("TIME:"..tostring(math.floor(self.time)))/2), 300)
		love.graphics.print("SCORE:"..tostring(self.score), (love.graphics.getWidth()/2 - start.font3:getWidth("SCORE:"..tostring(self.score))/2), 350)
		love.graphics.print("WAVE:"..tostring(self.wave), (love.graphics.getWidth()/2 - start.font3:getWidth("WAVE:"..tostring(self.wave))/2), 400)
		love.graphics.setColor(255, 255, 255)
	end

	-- draw game welcome messages
	game:draw()
	------ TEXT ------

	-- REMOVE LATER! ------ DEBUG ------ REMOVE LATER!
	if setfps == true then
		love.graphics.setFont( start.font1 )
		love.graphics.print("ZOMBS "..tostring(zombie.count), 1000, 200)
		love.graphics.print("COUNT "..tostring(self.wavezombiecount), 1000, 250)
		love.graphics.print("KILLS "..tostring(self.kills), 1000, 300)
		love.graphics.print("SPEED "..tostring(zombie.speed), 1000, 350)
		love.graphics.print("HEALH "..tostring(zombie.health), 1000, 400)
		love.graphics.print("SPAWN "..tostring(zombie.spawnrateplus), 1000, 450)
	end
	-- REMOVE LATER! ------ DEBUG ------ REMOVE LATER!
end

return stuckmode