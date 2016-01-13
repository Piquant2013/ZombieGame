-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads Hardon Collider script
local HC = require 'libs/hardoncollider'

-- Loads gamestate script
game = require 'game/game'

-- Creates arcade as a new gamestate
arcade = Gamestate.new()


function arcade:init()

	------ VARIABLES ------
	-- load main game mechanics
	game:init()

	-- scores
	self.score = 0
	self.time = 0
	self.wave = 1
	self.totalscore = 0
	self.kills = 0
	self.killamount = 100

	-- For the spawn system
	self.wavedrawtime = 0
	self.wavebreaktimer = 0
	self.wavebreak = false
	self.wavestart = true
	self.wavezombiecount = 14
	
	-- flashes
	self.flashwave = true
	self.waveflash = 2
	self.gunsflash = 2
	self.flashguns = true
	self.speedflashtimer = 10
	self.healthflashtimer = 10
	self.oneupflashtimer = 10

	-- death vars
	self.death = false
	self.deathtimer = 11

	-- player
	self.health1 = 0
	self.health2 = 0
	self.playerspeed = 0
	self.healthcolor1 = 0
	self.healthcolor2 = 0
	self.healthcolor3 = 0
	
	-- Minigun vars
	self.minicount = 1	
	self.spawnmini = false
	self.minihave = false
	self.minispawnscore = 0
	
	-- SMG vars
	self.smgcount = 1
	self.spawnsmg = false
	self.smghave = false
	self.smgspawnscore = 600

	-- INV vars
	self.invcount = 1
	self.spawninv = false
	self.invhave = false
	self.invtimer = 10
	self.invspawnscore = 0
	
	-- Shoe vars
	self.shoecount = 1
	self.spawnshoe = false
	self.shoehave = false
	self.shoetimer = 1
	self.shoespawnscore = 1

	-- Heart vars
	self.heartcount = 1
	self.spawnheart = false
	self.hearthave = false
	self.hearttimer = 1
	self.heartspawnscore = 1

	-- Killall vars
	self.killallcount = 1
	self.spawnkillall = false
	self.killallhave = false
	self.killalltimer = 1.5
	self.killallflash = 0
	self.flashkillall = false
	self.killamount = 100
	self.killallspawnscore = 0

	-- Oneup vars
	self.oneupcount = 1
	self.spawnoneup = false
	self.oneuphave = false
	self.oneuptimer = 1
	self.oneupspawnscore = 0

	-- Questionmark vars
	self.questionmarkcount = 1
	self.spawnquestionmark = false
	self.questionmarkhave = false
	self.questionmarktimer = 1
	self.quespawnscore = 1
	self.quesmghave = false
	self.queminihave = false
	self.quesmgammo = 80
	self.queminiammo = 150

	-- Gameover vars
	self.gameovery = 800
	self.fadebg = 0
	self.bgtimer = 0
	------ VARIABLES ------











	self.highscore = 0
	highscores = {}

	if love.filesystem.exists("scores.lua") then
	
		for lines in love.filesystem.lines("scores.lua") do
			table.insert(highscores, lines)
			self.highscore = highscores[3]
		end
	
	elseif not love.filesystem.exists("scores.lua") then
		scores = love.filesystem.newFile("scores.lua")
	end

	--love.filesystem.write("scores.lua", "arcade.highscore\n=\n"..self.highscore)
	--self.highscore = highscores[3]










	------ IMAGES ------
	self.layer1 = love.graphics.newImage("images/maps/arcade-layer1.png")
	self.layer2 = love.graphics.newImage("images/maps/arcade-layer2.png")
	self.powerupdisplay1 = love.graphics.newImage("images/weapons/smg.png")
	self.powerupdisplay2 = love.graphics.newImage("images/weapons/minigun.png")
	------ IMAGES ------
end

function arcade:keypressed(key)
	
	-- load game keyborad inputs for welcome screen, gameover, etc
	game:keypressed(key)

	-- dissmiss the game over message
  	if key == "return" and gameover == true and self.bgtimer > 12 or key == "space" and gameover == true and self.bgtimer > 12 or key == "escape" and gameover == true and self.bgtimer > 12 then
  		love.audio.play(game.entersound)
    	Gamestate.switch(menu)
    	love.audio.play(start.music)
    	start.music:setLooping(true)
   		love.audio.stop(game.music1)
    	setarcade = true
    	gamereset = true
    	game.arcade = false
    	game.stuck = false
    	love.audio.stop(plyr.deathaudio)
    	love.audio.stop(plyr.hurtaudio)
    	love.audio.stop(game.music2)
  	end

  	-- skip the game over animation
  	if key == "return" and gameover == true and arcade.bgtimer < 12 or key == "space" and gameover == true and arcade.bgtimer < 12 or key == "escape" and gameover == true and arcade.bgtimer < 12 then
  		self.bgtimer = 13
  		self.fadebg = 255
		self.gameovery = 200
  	end

  	-- Contiune button after losing a life
  	if key == "return" and self.death == true or key == "space" and self.death == true then
  		self.death = false
		self.oneupflashtimer = 0
		plyr.y = 200
		plyr.x = 400
		plyr.speed = self.playerspeed
		plyr.health = player.maxhealth
		love.audio.play(game.entersound)
		love.mouse.setCursor(crosshair)
		love.audio.stop(game.music3)
		love.audio.resume(game.music1)
  	end
end

function arcade:mousepressed(mx, my, button)
	
	-- dissmiss the game over message
  	if button == 1 and gameover == true and self.bgtimer > 12 or button == 2 and gameover == true and self.bgtimer > 12 then
  		love.audio.play(game.entersound)
    	Gamestate.switch(menu)
    	love.audio.play(start.music)
    	start.music:setLooping(true)
   		love.audio.stop(game.music1)
    	setarcade = true
    	gamereset = true
    	game.arcade = false
    	game.stuck = false
    	love.audio.stop(plyr.deathaudio)
    	love.audio.stop(plyr.hurtaudio)
    	love.audio.stop(game.music2)
  	end

	-- aim assit for pistol
	pistol:aim(mx, my, button)

	-- load game mousepressed inputs for welcome screen, gameover, etc
	game:mousepressed(mx, my, button)
end

function arcade:update(dt)

	game.music1:setVolume(musicvolume)
	game.music2:setVolume(musicvolume)
	game.music3:setVolume(musicvolume)

	-- update main game mechanics
	game:update(dt)

	-- SET UP GAME --
	-- Reset the game
	if setarcade == true then

		-- Player
		plyr.y = 200
		plyr.x = 400
		plyr.speed = 0.5
		plyr.health = 100
		plyr.hurt = false
		plyr.colliding = false
		player.hurttimer = 0
		player.flashred = false
		player.autoheal = true
		player.maxhealth = 100
		player.minihealthbar = false
		player.lives = 1

		-- Pistol
		pis.y = plyr.y
		pis.x = plyr.x
		pistol.cooldown = 0
		pistol.cooldownplus = 0.25
		pistol.bullets = {}

		-- scores
		self.score = 0
		self.time = 0
		self.wave = 1
		self.totalscore = 0
		self.kills = 0
		self.killamount = 100

		-- For the spawn system
		self.wavedrawtime = 0
		self.wavebreaktimer = 0
		self.wavebreak = false
		self.wavestart = true
		self.wavezombiecount = 14
	
		-- flashes
		self.flashwave = true
		self.waveflash = 2
		self.gunsflash = 2
		self.flashguns = true
		self.speedflashtimer = 10
		self.healthflashtimer = 10
		self.oneupflashtimer = 10

		-- death vars
		self.death = false
		self.deathtimer = 11

		-- player
		self.health1 = 0
		self.health2 = 0
		self.playerspeed = 0
		self.healthcolor1 = 0
		self.healthcolor2 = 0
		self.healthcolor3 = 0
	
		-- Minigun vars
		self.minicount = 1	
		self.spawnmini = false
		self.minihave = false
		self.minispawnscore = 0
		self.minihad = false
	
		-- SMG vars
		self.smgcount = 1
		self.spawnsmg = false
		self.smghave = false
		self.smgspawnscore = 600
		self.smghad = false

		-- INV vars
		self.invcount = 1
		self.spawninv = false
		self.invhave = false
		self.invtimer = 10
		self.invspawnscore = 0
		self.invhad = false
	
		-- Shoe vars
		self.shoecount = 1
		self.spawnshoe = false
		self.shoehave = false
		self.shoetimer = 1
		self.shoespawnscore = 1
		self.shoehad = false

		-- Heart vars
		self.heartcount = 1
		self.spawnheart = false
		self.hearthave = false
		self.hearttimer = 1
		self.heartspawnscore = 1
		self.hearthad = false

		-- Killall vars
		self.killallcount = 1
		self.spawnkillall = false
		self.killallhave = false
		self.killalltimer = 1.5
		self.killallflash = 0
		self.flashkillall = false
		self.killamount = 100
		self.killallspawnscore = 0
		self.killallhad = false

		-- Oneup vars
		self.oneupcount = 1
		self.spawnoneup = false
		self.oneuphave = false
		self.oneuptimer = 1
		self.oneupspawnscore = 0
		self.oneuphad = false

		-- Questionmark vars
		self.questionmarkcount = 1
		self.spawnquestionmark = false
		self.questionmarkhave = false
		self.questionmarktimer = 1
		self.quespawnscore = 1
		self.quesmghave = false
		self.queminihave = false
		self.quesmgammo = 80
		self.queminiammo = 150
		self.questionmarkhad = false

		-- Gameover vars
		self.gameovery = 800
		self.fadebg = 0
		self.bgtimer = 0

		-- Globals
		paused = false
		welcomescreen = true
		gameover = false

		-- Zombie
    	zombie.zombs = {}
    	zombie.spawnrate = 0
		zombie.spawnrateplus = 0.4
		zombie.speed = 60
		zombie.health = 1
		zombie.count = 0

		-- Smg
		smg.smgs = {}
    	smg.spawnrate = 0
		smg.spawnrateplus = 1
		smg.count = 0

		-- Minigun
		minigun.miniguns = {}
		minigun.spawnrate = 0
		minigun.spawnrateplus = 1
		minigun.count = 0

		-- Inv
		inv.invs = {}
		inv.spawnrate = 0
		inv.spawnrateplus = 1
		inv.count = 0

		-- Killall
		killall.killalls = {}
		killall.spawnrate = 0
		killall.spawnrateplus = 1
		killall.count = 0

		-- shoe
		shoe.shoes = {}
		shoe.spawnrate = 0
		shoe.spawnrateplus = 1
		shoe.count = 0

		-- heart
		heart.hearts = {}
		heart.spawnrate = 0
		heart.spawnrateplus = 1
		heart.count = 0

		-- oneup
		oneup.oneups = {}
		oneup.spawnrate = 0
		oneup.spawnrateplus = 1
		oneup.count = 0

		-- questionmark
		questionmark.questionmarks = {}
		questionmark.spawnrate = 0
		questionmark.spawnrateplus = 1
		questionmark.count = 0
		
		-- hardon collider
		Collider = HC(100, on_collision, collision_stop)
		plyr.bb = Collider:addRectangle(plyr.x, plyr.y, plyr.w, plyr.h)
		self.wallT = Collider:addRectangle(188, 120, 850, 16)
    	self.wallB = Collider:addRectangle(188, 580, 850, 16)
    	self.wallL = Collider:addRectangle(170, 120, 16, 476)
    	self.wallR = Collider:addRectangle(1040, 120, 16, 476)
    	self.tree1 = Collider:addCircle(334, 282, 10)
    	self.tree2 = Collider:addCircle(817, 259, 10)
    	self.tree3 = Collider:addCircle(900, 457, 10)
    	self.tree4 = Collider:addCircle(610, 356, 80)

    	-- stop audio
    	love.audio.stop(plyr.hurtaudio)
    	love.audio.stop(plyr.deathaudio)
	end
	-- SET UP GAME --

	-- update the gun
	pistol:update(dt)

	-- set vars for gameover
	if gameover == true then
		pistol.cooldown = 0
		pistol.cooldownplus = 0
		pistol.bullets = {}
		plyr.y = plyr.y
		plyr.x = plyr.x
		love.mouse.setCursor(cursor)
		love.audio.stop(plyr.hurtaudio)
		love.audio.play(plyr.deathaudio)
		love.audio.stop(game.music1)
		love.audio.play(game.music2)
		self.wavestart = false
	end

	-- Flash special weapons
	if self.flashguns == true then
		self.gunsflash = self.gunsflash + dt + 1.5
	elseif self.flashguns == false then
		self.gunsflash = self.gunsflash + dt - 1.5
	end
	
	if self.gunsflash > 100 then
		self.flashguns = false
	elseif self.gunsflash < 2 then
		self.flashguns = true
	end

	-- Flash for kill all special
	if self.killallhave == true then
		if self.flashkillall == true then
			self.killallflash = self.killallflash + dt + 10
		elseif self.flashkillall == false then
			self.killallflash = self.killallflash + dt - 10
		end
	
		if self.killallflash > 255 then
			self.flashkillall  = false
		elseif self.killallflash < 0 then
			self.flashkillall = true
		end

	elseif self.killallhave == false then
		self.flashkillall = true
		self.killallflash = 0
	end

	---- SPECIAL WEAPONS ----
	-- SMG --
	-- Turn smg off
	for i, o in ipairs(smg.smgs) do
		if self.smghave == true and o.ammo == 0 then
			self.smghave = false
			smg.count = 0
			self.smghad = false
			table.remove(smg.smgs, i)
			love.audio.play(menu.backsound)
		end
	end

	-- turn smg on
	if self.smghave == true then
		pistol.cooldownplus = 0.065
		self.minihave = false
		self.pistolhave = false
		self.queminihave = false
		self.quesmghave = false
	end

	-- turn pistol firerate back
	if self.pistolhave == true then
		
		if self.wave < 10 then
			pistol.cooldownplus = 0.25
		end

		if self.wave > 9 then
			pistol.cooldownplus = 0.60
		end
	end

	-- reset smg for next time
	if self.smghave == false then		
		self.pistolhave = true

		for i, o in ipairs(smg.smgs) do
			o.ammo = 80
		end
	end

	-- Spawning
	if self.spawnsmg == true and self.smgspawnscore == 600 then
		smg:spawn()
		self.smgspawnscore = 0
	end

	-- reset spawning
	if self.smgspawnscore > 600 then
		self.smgspawnscore = 0
	end

	-- make sure only one is on screen at a time
	if smg.count == self.smgcount then
		self.spawnsmg = false
	elseif smg.count < self.smgcount then
		self.spawnsmg = true
	end
	-- SMG --

	-- MINIGUN --
	-- turn minigun off
	for i, o in ipairs(minigun.miniguns) do
		if self.minihave == true and o.ammo == 0 then
			self.minihave = false
			minigun.count = 0
			self.minihad = false
			table.remove(minigun.miniguns, i)
			love.audio.play(menu.backsound)
		end
	end

	-- turn minigun on
	if self.minihave == true then
		pistol.cooldownplus = 0.030
		self.smghave = false
		self.pistolhave = false
		self.queminihave = false
		self.quesmghave = false
	end

	-- reset minigun for next time
	if self.minihave == false then
		self.pistolhave = true

		for i, o in ipairs(minigun.miniguns) do
			o.ammo = 150
		end
	end
		
	-- Spawning
	if self.spawnmini == true and self.minispawnscore == 800 then
		minigun:spawn()
		self.minispawnscore = 0
	end

	-- dont allow spawning till wave 3
	if self.wave < 3 then
		self.minispawnscore = 0
	end

	-- reset spawning
	if self.minispawnscore > 800 then
		self.minispawnscore = 0
	end

	-- make sure only one is on screen at a time
	if minigun.count == self.minicount then
		self.spawnmini = false
	elseif minigun.count < self.minicount then
		self.spawnmini = true
	end
	-- MINIGUN --

	-- INV --
	-- turn off inv
	if self.invhave == true and self.invtimer < 0 then
		self.invhave = false
		inv.count = 0
		self.invhad = false
		love.audio.play(menu.backsound)
		table.remove(inv.invs, i)
	end

	-- turn on inv
	if self.invhave == true then
		self.invtimer = self.invtimer - dt
		love.audio.play(game.invidle)
	end

	-- reset inv for next time
	if self.invhave == false then		
		self.invtimer = 10
		love.audio.stop(game.invidle)
	end

	-- Spawning
	if self.spawninv == true and self.invspawnscore == 1000 then
		inv:spawn()
		self.invspawnscore = 0
	end

	-- dont allow spawning till wave 5
	if self.wave < 5 then
		self.invspawnscore = 0
	end

	-- reset spawning
	if self.invspawnscore > 1000 then
		self.invspawnscore = 0
	end

	-- make sure only one is on screen at a time
	if inv.count == self.invcount then
		self.spawninv = false
	elseif inv.count < self.invcount then
		self.spawninv = true
	end
	-- INV --

	-- KILL ALL --
	-- turn off killall
	if self.killallhave == true and self.killalltimer < 0 then
		self.killallhave = false
		killall.count = 0
		self.killallhad = false
		love.audio.play(menu.backsound)
		table.remove(killall.killalls, i)
	end

	-- turn kill all on
	if self.killallhave == true then
		self.killalltimer = self.killalltimer - dt
	end

	-- reset killall for next time
	if self.killallhave == false then		
		self.killalltimer = 1.5
	end

	-- Spawning
	if self.spawnkillall == true and self.killallspawnscore == 3000 then
		killall:spawn()
		self.killallspawnscore = 0
	end

	-- dont allow spawning till wave 5
	if self.wave < 10 then
		self.killallspawnscore = 0
	end

	-- reset spawning
	if self.killallspawnscore > 2000 then
		self.killallspawnscore = 0
	end

	-- make sure only one is on screen at a time
	if killall.count == self.killallcount then
		self.spawnkillall = false
	elseif killall.count < self.killallcount then
		self.spawnkillall = true
	end
	
	-- activate killall
	if self.killallhave == true then
		for i, o in ipairs(zombie.zombs) do
			o.health = o.health - 10
			love.audio.play(o.damageaudio)
			o.damageaudio:setVolume(0.3)
			Collider:remove(o.bb)

			-- kill zombies
			if o.health < 0 then
				o.health = 0
				self.score = self.score + 10
				self.kills = self.kills + 1
				zombie.count = zombie.count - 1 
				self.smgspawnscore = self.smgspawnscore + 10
				self.minispawnscore = self.minispawnscore + 10
				self.invspawnscore = self.invspawnscore + 10
				self.killallspawnscore = self.killallspawnscore + 10
				self.oneupspawnscore = 	self.oneupspawnscore + 10
				self.totalscore = self.totalscore + 10
				Collider:remove(o.bb)
				table.remove(zombie.zombs, i)
			end
		end
	end
	-- KILL ALL --

	-- SHOE --
	-- turn off shoe
	if self.shoehave == true and self.shoetimer < 0 then
		self.shoehave = false
		shoe.count = 0
		self.shoehad = false
		table.remove(shoe.shoes, i)
	end

	-- turn on shoe
	if self.shoehave == true then
		self.shoetimer = self.shoetimer - dt
		self.speedflashtimer = 0
	end

	-- reset shoe for next time
	if self.shoehave == false then		
		self.shoetimer = 1
	end

	-- Spawning
	if self.spawnshoe == true and self.shoespawnscore == 3 and self.wave < 10 or self.spawnshoe == true and self.shoespawnscore == 4 and self.wave > 9 and plyr.speed < 50 then
		shoe:spawn()
		self.shoespawnscore = 0
	end

	-- dont allow spawning till wave 5
	if self.shoespawnscore > 4 then
		self.shoespawnscore = 0
	end

	-- make sure only one is on screen at a time
	if shoe.count == self.shoecount then
		self.spawnshoe = false
	elseif shoe.count < self.shoecount then
		self.spawnshoe = true
	end
	-- SHOE --

	-- HEART --
	-- turn off heart
	if self.hearthave == true and self.hearttimer < 0 then
		self.hearthave = false
		heart.count = 0
		self.hearthad = false
		table.remove(heart.hearts, i)
	end

	-- turn on heart
	if self.hearthave == true then
		self.hearttimer = self.hearttimer - dt
		self.healthflashtimer = 0
	end

	-- reset heart for next time
	if self.hearthave == false then		
		self.hearttimer = 1
	end

	-- Spawning
	if self.spawnheart == true and self.heartspawnscore == 6 and player.maxhealth < 160 then
		heart:spawn()
		self.heartspawnscore = 0
	end

	-- dont allow spawning till wave 6
	if self.heartspawnscore > 6 then
		self.heartspawnscore = 0
	end

	-- make sure only one is on screen at a time
	if heart.count == self.heartcount then
		self.spawnheart = false
	elseif heart.count < self.heartcount then
		self.spawnheart = true
	end
	-- HEART --

	-- ONEUP --
	-- turn off oneup
	if self.oneuphave == true and self.oneuptimer < 0 then
		self.oneuphave = false
		oneup.count = 0
		self.oneuphad = false
		table.remove(oneup.oneups, i)
	end

	-- turn on oneup
	if self.oneuphave == true then
		self.oneuptimer = self.oneuptimer - dt
		self.oneupflashtimer = 0
	end

	-- reset oneup for next time
	if self.oneuphave == false then		
		self.oneuptimer = 1
	end

	-- Spawning
	if self.spawnoneup == true and self.oneupspawnscore == 10000 and player.lives < 3 then
		oneup:spawn()
		self.oneupspawnscore = 0
	end

	-- reset spawning
	if self.oneupspawnscore > 10000 then
		self.oneupspawnscore = 0
	end

	-- make sure only one is on screen at a time
	if oneup.count == self.oneupcount then
		self.spawnoneup = false
	elseif oneup.count < self.oneupcount then
		self.spawnoneup = true
	end
	-- ONEUP --

	-- QUESTIONMARK --
	-- turn off questionmark
	if self.questionmarkhave == true and self.questionmarktimer < 0 then
		self.questionmarkhave = false
		questionmark.count = 0
		self.questionmarkhad = false
		table.remove(questionmark.questionmarks, i)
	end

	-- turn on questionmark
	if self.questionmarkhave == true then
		self.questionmarktimer = self.questionmarktimer - dt
	end

	-- reset questionmark for next time
	if self.questionmarkhave == false then		
		self.questionmarktimer = 1
	end

	-- Spawning
	if self.spawnquestionmark == true and self.quespawnscore == 4 then
		questionmark:spawn()
		self.quespawnscore = 0
	end

	-- dont allow spawning till wave 4
	if self.quespawnscore > 4 then
		self.quespawnscore = 0
	end

	-- make sure only one is on screen at a time
	if questionmark.count == self.questionmarkcount then
		self.spawnquestionmark = false
	elseif questionmark.count < self.questionmarkcount then
		self.spawnquestionmark = true
	end

	-- SMG
	-- Turn smg off
	if self.quesmghave == true and self.quesmgammo == 0 then
		self.quesmghave = false
		love.audio.play(menu.backsound)
	end

	-- turn smg on
	if self.quesmghave == true then
		pistol.cooldownplus = 0.065
		self.minihave = false
		self.smghave = false
		self.pistolhave = false
	end

	-- reset smg
	if self.quesmghave == false then
		self.quesmgammo = 80
		self.pistolhave = true
	end

	-- MINI
	-- Turn mini off
	if self.queminihave == true and self.queminiammo == 0 then
		self.queminihave = false
		love.audio.play(menu.backsound)
	end

	-- turn smg on
	if self.queminihave == true then
		pistol.cooldownplus = 0.030
		self.minihave = false
		self.smghave = false
		self.pistolhave = false
	end

	-- reset smg
	if self.queminihave == false then
		self.queminiammo = 150
		self.pistolhave = true
	end
	-- QUESTIONMARK --
	---- SPECIAL WEAPONS ----

	-- WAVE SYSTEM --
	-- start the score time
	if gameover == false then
		self.time = self.time + dt
		self.wavebreaktimer = self.wavebreaktimer + dt
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
	if self.wavebreak == false then
		if zombie.count == self.wavezombiecount then
			self.wavestart = false
		elseif zombie.count < self.wavezombiecount then
			self.wavestart = true
		end
	end

	-- small break between waves
	if self.wavebreak == true then
		if self.wavebreaktimer < 8 then
			self.wavestart = false
		elseif self.wavebreaktimer > 8 then
			self.wavestart = true
			self.wavebreak = false
		end
	end

	-- when you kill 100 go to next wave, increase spawn rate, increase spawn amount
	if self.kills > self.killamount then
		self.killamount = self.killamount + 10
		self.kills = 0
		zombie.spawnrateplus = zombie.spawnrateplus - 0.05
		zombie.speed = zombie.speed + 1.5
		self.wavedrawtime = 0
		self.waveflash = 2
		self.wave = self.wave + 1
		self.wavezombiecount = self.wavezombiecount + 8
		self.wavebreaktimer = 0
		self.wavebreak = true
		self.flashwave = true
		love.audio.play(game.wavestart)
		self.shoespawnscore = self.shoespawnscore + 1
		self.heartspawnscore = self.heartspawnscore + 1
		self.quespawnscore = self.quespawnscore + 1
		self.totalscore = self.totalscore + 100
	end

	-- lock the spawn rate
	if zombie.spawnrateplus < 0.05 then
		zombie.spawnrateplus = 0.05
	end

	-- lock the wave count
	if zombie.speed > 200 then
		zombie.speed = 200
	end

	-- lock the wave count
	if self.wavezombiecount > 300 then
		self.wavezombiecount = 300
	end

	-- flash the wave title in hud when a new wave is starting
	if self.wavedrawtime < 5 then
		if self.flashwave == true then
			self.waveflash = self.waveflash + dt + 3
		elseif self.flashwave == false then
			self.waveflash = self.waveflash + dt - 3
		end
	
		if self.waveflash > 150 then
			self.flashwave = false
		elseif self.waveflash < 2 then
			self.flashwave = true
		end
	end
	-- WAVE SYSTEM --

	-- set some timers
	self.speedflashtimer = self.speedflashtimer + dt
	self.healthflashtimer = self.healthflashtimer + dt
	self.oneupflashtimer = self.oneupflashtimer + dt
	self.deathtimer = self.deathtimer - dt

	-- set and update heath draw varibles
	self.health1 = plyr.health
	self.health2 = plyr.health - 100

	-- keep health one at no higher then 100
	if self.health1 > 100 then
		self.health1 = 100
	end

	-- keep health two at no lower then 0
	if self.health2 < 0 then
		self.health2 = 0
	end

	-- EXTRA LIFE SYSTEM --
	-- if you lose a life
	if plyr.health <= 0 and player.lives > 1 then
		plyr.health = player.maxhealth
		player.lives = player.lives - 1
		self.queminiammo = 0
		self.quesmgammo = 0
   		self.deathtimer = 11
   		self.death = true
   		self.playerspeed = plyr.speed
   		love.audio.stop(plyr.hurtaudio)
		love.audio.play(plyr.deathaudio1)
		love.audio.pause(game.music1)
		love.audio.play(game.music3)
		self.totalscore = self.totalscore - 1000
    
    	for i, o in ipairs(minigun.miniguns) do
    		o.ammo = 0
		end
    	
    	for i, o in ipairs(smg.smgs) do
    		o.ammo = 0
		end
	end

	if self.death == true then
		love.mouse.setCursor(cursor)

	   	for i, o in ipairs(zombie.zombs) do
	   		plyr.speed = 0
   			zombie.count = zombie.count - 1         
			Collider:remove(o.bb)
			table.remove(zombie.zombs, i)
		end
	end

	-- give gameover if player doesnt choose to continue before timer ends
	if self.deathtimer < 0 and self.death == true then
		self.death = false
		gameover = true
		love.audio.stop(game.music3)
	end
	-- EXTRA LIFE SYSTEM --

	-- if you pass the 15min mark you get bonus points
	if self.time > 900 and self.time < 901 and gameover == false then
		self.totalscore = self.totalscore + 20
	end

	-- update zombies
	zombie:update(dt)

	-- update minigun
	minigun:update(dt)
	
	-- update smg
	smg:update(dt)

	-- update inv
	inv:update(dt)

	-- update inv
	killall:update(dt)

	-- update shoe
	shoe:update(dt)

	-- update heart
	heart:update(dt)

	-- update oneup
	oneup:update(dt)

	-- update oneup
	questionmark:update(dt)

	--- MOVE GAMEOVER TEXT ---
	if gameover == true then
		
		-- make zombies slowmo at death
		for i, o in ipairs(zombie.zombs) do
			o.speed = 10
		end

		-- set timer and title mover
		self.gameovery = self.gameovery + dt - 1
		self.bgtimer = self.bgtimer + dt

		-- fade in the background after 10secs
		if self.bgtimer > 10 then
			self.fadebg = self.fadebg + dt + 3
		end

		-- stop death audio
		if self.bgtimer > 3 then
			love.audio.stop(plyr.deathaudio)
		end

		-- unspawn zombies
		if self.bgtimer > 12 then
			Collider:remove(zombie.bb)
			table.remove(zombie.zombs)
		end

		-- keep fade on the background off once its faded in
		if self.fadebg > 255 then
			self.fadebg = 255
		end

		-- move title to 200 and stop
		if self.gameovery < 200 then
			self.gameovery = 200
		end
	end
	--- MOVE GAMEOVER TEXT ---
end

function arcade:draw()

	------ FILTERS ------
	self.layer1:setFilter( 'nearest', 'nearest' )
	self.layer2:setFilter( 'nearest', 'nearest' )
	start.font0:setFilter( 'nearest', 'nearest' )
	start.font1:setFilter( 'nearest', 'nearest' )
	start.font2:setFilter( 'nearest', 'nearest' )
	start.font3:setFilter( 'nearest', 'nearest' )
	start.font4:setFilter( 'nearest', 'nearest' )
	start.font5:setFilter( 'nearest', 'nearest' )
	self.powerupdisplay1:setFilter( 'nearest', 'nearest' )
	self.powerupdisplay2:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------
	
	------ CAMERA ------
	game.Cam:attach()

	-- layer1 of the map
	love.graphics.draw(self.layer1, 0, 0)

	-- bullet
	pistol:bulletdraw()

	-- Aim
	pistol:aimdraw()

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

	-- minigun
	minigun:draw()
	
	-- smg
	smg:draw()

	-- inv
	inv:draw()

	-- killall
	killall:draw()

	-- killall
	shoe:draw()

	-- heart
	heart:draw()

	-- heart
	oneup:draw()

	-- heart
	questionmark:draw()

	-- pistol
	pistol:draw()

	-- zombies
	zombie:draw()

	-- layer2 of the map
	love.graphics.draw(self.layer2, 0, 0)

	-- display mini health bar
	if plyr.hurt == true and gameover == false or player.minihealthbar == true and gameover == false then
		love.graphics.setColor(160, 47, 0, 200)
		love.graphics.rectangle("line", plyr.x - 13, plyr.y + 14, 27, 3)
		love.graphics.setColor(0, 0, 0, 200)
		love.graphics.rectangle("line", plyr.x - 12, plyr.y + 15, 25, 1)
		love.graphics.setColor(self.healthcolor1, self.healthcolor2, self.healthcolor3, 200)
		love.graphics.rectangle("fill", plyr.x - 12, plyr.y + 15, self.health1/4, 1)
		love.graphics.setColor(0, 170, 240, 200)
		love.graphics.rectangle("fill", plyr.x - 12, plyr.y + 15, self.health2/4, 1)
		love.graphics.setColor(255, 255, 255, 255)
	end

	-- reset health flash timer
	if plyr.health < player.maxhealth and player.hurttimer > 3 then
		self.healthflashtimer = 0
	end

	-- stop health flash timer
	if plyr.health == player.maxhealth then
		self.healthflashtimer = 10
	end

	-- stop health flash timer till your not hurt
	if plyr.hurt == true then
		self.healthflashtimer = 10
	end

	-- clear screen for contiune screen
	if self.death == true then
		love.graphics.draw(self.layer1, 0, 0)
		love.graphics.draw(self.layer2, 0, 0)
	end

	game.Cam:detach()
	------ CAMERA ------
	
	------ TEXT ------
	-- wave title
	if self.wavedrawtime < 3 and gameover == false then
		love.graphics.setFont( start.font3 )
   		love.graphics.setColor(160, 47, 0)
		love.graphics.print("WAVE "..tostring(self.wave), (love.graphics.getWidth()/2 - start.font3:getWidth("WAVE "..tostring(self.wave))/2), 200)
		love.graphics.setColor(255, 255, 255)
	end

	if gameover == false then

		-- HUD
		love.graphics.setColor(0, 0, 0, 150)
		love.graphics.rectangle("fill", 7, 7, 486, 22 )
		love.graphics.setColor(160, 47, 0, 255)
		love.graphics.rectangle("line", 6, 6, 488, 24 )
		love.graphics.setColor(0, 0, 0, 150)
		love.graphics.rectangle("fill", 501, 7, 278, 22 )
		love.graphics.setColor(160, 47, 0, 255)
		love.graphics.rectangle("line", 500, 6, 280, 24 )
		love.graphics.setColor(0, 0, 0, 150)
		love.graphics.rectangle("fill", 787, 7, 200, 22 )
		love.graphics.setColor(160, 47, 0, 255)
		love.graphics.rectangle("line", 786, 6, 202, 24 )
		love.graphics.setColor(0, 0, 0, 150)
		love.graphics.rectangle("fill", 995, 7, 278, 22 )
		love.graphics.setColor(160, 47, 0, 255)
		love.graphics.rectangle("line", 994, 6, 280, 24 )

		-- DISPLAY LIVES --
		if self.wavedrawtime < 5 and self.wave == 1 then
			love.graphics.setFont( start.font9 )
			love.graphics.setColor(0, 0, 0, 150)
			love.graphics.rectangle("fill", love.graphics.getWidth()/2 - 140 - 6, love.graphics.getHeight() - 22, 140, 16 )
			love.graphics.setColor(160, 47, 0, 255)
			love.graphics.rectangle("line", love.graphics.getWidth()/2 - 142 - 5, love.graphics.getHeight() - 23, 142, 18 )
			love.graphics.setColor(160, 47, 0)
			love.graphics.print("LIVES:"..tostring(player.lives), love.graphics.getWidth()/2 - 141, love.graphics.getHeight() - 17)
		end

		if self.oneupflashtimer < 8 then
			love.graphics.setFont( start.font9 )
			love.graphics.setColor(0, 0, 0, 150)
			love.graphics.rectangle("fill", love.graphics.getWidth()/2 - 140 - 6, love.graphics.getHeight() - 22, 140, 16 )
			love.graphics.setColor(160, 47, 0, 255)
			love.graphics.rectangle("line", love.graphics.getWidth()/2 - 142 - 5, love.graphics.getHeight() - 23, 142, 18 )
			love.graphics.setColor(160, 47, 0)
			love.graphics.print("LIVES:"..tostring(player.lives), love.graphics.getWidth()/2 - 141, love.graphics.getHeight() - 17)
			love.graphics.setColor(255, 255, 255, self.gunsflash)
			love.graphics.print("LIVES:"..tostring(player.lives), love.graphics.getWidth()/2 - 141, love.graphics.getHeight() - 17)
			love.graphics.setColor(255, 255, 255, 255)
		end
		-- DISPLAY LIVES --

		-- DISPLAY SPEED --
		if self.wavedrawtime < 5 and self.wave == 1 then
			love.graphics.setFont( start.font9 )
			love.graphics.setColor(0, 0, 0, 150)
			love.graphics.rectangle("fill", love.graphics.getWidth()/2 + 6, love.graphics.getHeight() - 22, 140, 16 )
			love.graphics.setColor(160, 47, 0, 255)
			love.graphics.rectangle("line", love.graphics.getWidth()/2 + 5, love.graphics.getHeight() - 23, 142, 18 )
			love.graphics.setColor(160, 47, 0)
			love.graphics.print("SPEED:"..tostring(plyr.speed), love.graphics.getWidth()/2 + 12, love.graphics.getHeight() - 17)
		end

		if self.speedflashtimer < 8 then
			love.graphics.setFont( start.font9 )
			love.graphics.setColor(0, 0, 0, 150)
			love.graphics.rectangle("fill", love.graphics.getWidth()/2 + 6, love.graphics.getHeight() - 22, 140, 16 )
			love.graphics.setColor(160, 47, 0, 255)
			love.graphics.rectangle("line", love.graphics.getWidth()/2 + 5, love.graphics.getHeight() - 23, 142, 18 )
			love.graphics.setColor(160, 47, 0)
			love.graphics.print("SPEED:"..tostring(plyr.speed), love.graphics.getWidth()/2 + 12, love.graphics.getHeight() - 17)
			love.graphics.setColor(255, 255, 255, self.gunsflash)
			love.graphics.print("SPEED:"..tostring(plyr.speed), love.graphics.getWidth()/2 + 12, love.graphics.getHeight() - 17)
			love.graphics.setColor(255, 255, 255, 255)
		end
		-- DISPLAY SPEED --

		-- HEALTH --
		-- Set health colors
		if self.health1 > 50 then
			self.healthcolor1 = 0
			self.healthcolor2 = 170
			self.healthcolor3 = 0
		end

		if self.health1 < 50 then
			self.healthcolor1 = 255
			self.healthcolor2 = 200
			self.healthcolor3 = 0
		end

		if self.health1 < 25 then
			self.healthcolor1 = 229
			self.healthcolor2 = 40
			self.healthcolor3 = 0
		end

		-- health text
		love.graphics.setFont( start.font0 )
		love.graphics.setColor(160, 47, 0)
		love.graphics.print("HEALTH:", 15, 15)
		
		-- health bars
		love.graphics.setColor(self.healthcolor1, self.healthcolor2, self.healthcolor3)
		love.graphics.rectangle("fill", 125, 12, self.health1 * 3.6, 13)
		love.graphics.setColor(0, 170, 240)
		love.graphics.rectangle("fill", 125, 12, self.health2 * 3.6, 13)

		-- flash health on autoheal
		if self.healthflashtimer < 8 then
			love.graphics.setColor(0, 170, 240, self.gunsflash + 20)
			love.graphics.rectangle("fill", 125, 12, self.health1 * 3.6, 13)
			love.graphics.setColor(0, 170, 0, self.gunsflash + 20)
			love.graphics.rectangle("fill", 125, 12, self.health2 * 3.6, 13)
			love.graphics.setColor(255, 255, 255, 255)
		end

		-- draw percentage
		love.graphics.setFont( start.font9 )
		love.graphics.setColor(255, 255, 255)
		love.graphics.print(tostring(math.floor(plyr.health)).."%", 280, 15)
		-- HEALTH --

		-- draw hud item. score, time, wave
		love.graphics.setColor(160, 47, 0)
		love.graphics.setFont( start.font0 )
		love.graphics.print("SCORE:", 510, 15)
		love.graphics.print(tostring(math.floor(self.totalscore)), 600, 15)
		love.graphics.print("TIME:"..tostring(math.floor(self.time)), 1002, 15)
		love.graphics.print("WAVE:"..tostring(self.wave), 795.5, 15)
		love.graphics.setColor(255, 255, 255)

		-- flash the wave text in hud white when the next wave is coming
		if self.wavedrawtime < 5 then
			love.graphics.setFont( start.font0 )
			love.graphics.setColor(255, 255, 255, self.waveflash)
			love.graphics.print("WAVE:"..tostring(self.wave), 795.5, 15)
			love.graphics.setColor(255, 255, 255)
		end

		-- Draw smg ammo box
		if self.smghave == true then
			for i, o in ipairs(smg.smgs) do
				love.graphics.setColor(0, 0, 0, 150)
				love.graphics.rectangle("fill", love.graphics.getWidth()/2 - 248/2, love.graphics.getHeight() - 149, 248, 52 )
				love.graphics.setColor(160, 47, 0, 255)
				love.graphics.rectangle("line", love.graphics.getWidth()/2 - 250/2, love.graphics.getHeight() - 150, 250, 54 )
				love.graphics.print("SMG", love.graphics.getWidth()/2 - 250/2 + 70, love.graphics.getHeight() - 137)
				love.graphics.print("AMMO:"..tostring(o.ammo), love.graphics.getWidth()/2 - 250/2 + 70, love.graphics.getHeight() - 117)
				love.graphics.setColor(255, 255, 255, 255)
				love.graphics.draw(self.powerupdisplay1, love.graphics.getWidth()/2 - self.powerupdisplay1:getWidth()/2 * 2 - 90, love.graphics.getHeight() - self.powerupdisplay1:getHeight()/2 * 2 - 123, 0, 2)
			end
		end

		-- Draw minigun ammo box
		if self.minihave == true then
			for i, o in ipairs(minigun.miniguns) do
				love.graphics.setColor(0, 0, 0, 150)
				love.graphics.rectangle("fill", love.graphics.getWidth()/2 - 248/2, love.graphics.getHeight() - 149, 248, 52 )
				love.graphics.setColor(160, 47, 0, 255)
				love.graphics.rectangle("line", love.graphics.getWidth()/2 - 250/2, love.graphics.getHeight() - 150, 250, 54 )
				love.graphics.print("MINIGUN", love.graphics.getWidth()/2 - 250/2 + 70, love.graphics.getHeight() - 137)
				love.graphics.print("AMMO:"..tostring(o.ammo), love.graphics.getWidth()/2 - 250/2 + 70, love.graphics.getHeight() - 117)
				love.graphics.setColor(255, 255, 255, 255)
				love.graphics.draw(self.powerupdisplay2, love.graphics.getWidth()/2 - self.powerupdisplay2:getWidth()/2 * 2 - 90, love.graphics.getHeight() - self.powerupdisplay2:getHeight()/2 * 2 - 123, 0, 2)
			end
		end

		-- Draw smg ammo box for questionmark powerup
		if self.quesmghave == true then	
			love.graphics.setColor(0, 0, 0, 150)
			love.graphics.rectangle("fill", love.graphics.getWidth()/2 - 248/2, love.graphics.getHeight() - 149, 248, 52 )
			love.graphics.setColor(160, 47, 0, 255)
			love.graphics.rectangle("line", love.graphics.getWidth()/2 - 250/2, love.graphics.getHeight() - 150, 250, 54 )
			love.graphics.print("SMG", love.graphics.getWidth()/2 - 250/2 + 70, love.graphics.getHeight() - 137)
			love.graphics.print("AMMO:"..tostring(self.quesmgammo), love.graphics.getWidth()/2 - 250/2 + 70, love.graphics.getHeight() - 117)
			love.graphics.setColor(255, 255, 255, 255)
			love.graphics.draw(self.powerupdisplay1, love.graphics.getWidth()/2 - self.powerupdisplay1:getWidth()/2 * 2 - 90, love.graphics.getHeight() - self.powerupdisplay1:getHeight()/2 * 2 - 123, 0, 2)
		end

		-- Draw minigun ammo box for questionmark powerup
		if self.queminihave == true then
			love.graphics.setColor(0, 0, 0, 150)
			love.graphics.rectangle("fill", love.graphics.getWidth()/2 - 248/2, love.graphics.getHeight() - 149, 248, 52 )
			love.graphics.setColor(160, 47, 0, 255)
			love.graphics.rectangle("line", love.graphics.getWidth()/2 - 250/2, love.graphics.getHeight() - 150, 250, 54 )
			love.graphics.print("MINIGUN", love.graphics.getWidth()/2 - 250/2 + 70, love.graphics.getHeight() - 137)
			love.graphics.print("AMMO:"..tostring(self.queminiammo), love.graphics.getWidth()/2 - 250/2 + 70, love.graphics.getHeight() - 117)
			love.graphics.setColor(255, 255, 255, 255)
			love.graphics.draw(self.powerupdisplay2, love.graphics.getWidth()/2 - self.powerupdisplay2:getWidth()/2 * 2 - 90, love.graphics.getHeight() - self.powerupdisplay2:getHeight()/2 * 2 - 123, 0, 2)
		end

		-- contiune screen draw
		if self.death == true then
			love.graphics.setColor(0, 0, 0, 150)
			love.graphics.rectangle("fill", love.graphics.getWidth()/2 - 778/2, love.graphics.getHeight()/2 - 322/2 - 50, 778, 322 )
			love.graphics.setColor(160, 47, 0, 255)
			love.graphics.rectangle("line", love.graphics.getWidth()/2 - 780/2, love.graphics.getHeight()/2 - 324/2 - 50, 780, 324 )
    		love.graphics.setFont( start.font5 )
    		love.graphics.setColor(160, 47, 0)
    		love.graphics.print('CONTINUE?', (love.graphics.getWidth()/2 - start.font5:getWidth( "CONTINUE?" )/2), love.graphics.getHeight()/2 - 170)
    		love.graphics.print(tostring(math.floor(self.deathtimer)), (love.graphics.getWidth()/2 - start.font5:getWidth(tostring(math.floor(self.deathtimer)))/2), love.graphics.getHeight()/2 - 90)
    		love.graphics.setFont( start.font3 )
    		love.graphics.print(tostring(player.lives)..' COIN, '..tostring(player.lives)..' PLAY', (love.graphics.getWidth()/2 - start.font3:getWidth(tostring(player.lives)..' COIN, '..tostring(player.lives)..' PLAY')/2), love.graphics.getHeight()/2 - 15)
    		love.graphics.print('PRESS START BUTTON', (love.graphics.getWidth()/2 - start.font3:getWidth('PRESS START BUTTON')/2), love.graphics.getHeight()/2 + 55)
    		love.graphics.setColor(255, 255, 255)
    	end

	-- Game over title and the scores at the end of the game
	elseif gameover == true then
    	
		-- darw game over backgorund
    	love.graphics.setColor(160, 47, 0, self.fadebg)
		love.graphics.draw(start.bg, 0, -1000, 0, 3)
		love.graphics.setColor(255, 255, 255)

		-- draw game over title
    	love.graphics.setFont( start.font5 )
    	love.graphics.setColor(160, 47, 0)
    	love.graphics.print('GAME OVER', (love.graphics.getWidth()/2 - start.font5:getWidth( "GAME OVER" )/2), self.gameovery)
    	love.graphics.setColor(255, 255, 255)
		
		-- display game score
    	if self.bgtimer > 12 then
			love.graphics.setFont( start.font2 )
    		love.graphics.setColor(160, 47, 0)
			love.graphics.print("TIME:"..tostring(math.floor(self.time)), (love.graphics.getWidth()/2 - start.font2:getWidth("TIME:"..tostring(math.floor(self.time)))/2), 300)
			love.graphics.print("KILLS:"..tostring(self.score/10), (love.graphics.getWidth()/2 - start.font2:getWidth("KILLS:"..tostring(self.score/10))/2), 340)
			love.graphics.print("WAVE:"..tostring(self.wave), (love.graphics.getWidth()/2 - start.font2:getWidth("WAVE:"..tostring(self.wave))/2), 380)
			love.graphics.setFont( start.font3 )
			love.graphics.print("SCORE:"..tostring(math.floor(self.totalscore)), (love.graphics.getWidth()/2 - start.font3:getWidth("SCORE:"..tostring(math.floor(self.totalscore)))/2), 440)
			love.graphics.setColor(255, 255, 255)

			if self.totalscore > tonumber(self.highscore) then
				self.highscore = self.totalscore
				love.filesystem.write("scores.lua", "arcade.highscore\n=\n"..self.highscore)
			end

			love.graphics.setColor(160, 47, 0)
			love.graphics.print("HIGHSCORE:"..tostring(math.floor(self.highscore)), (love.graphics.getWidth()/2 - start.font3:getWidth("HIGHSCORE:"..tostring(math.floor(self.highscore)))/2), 490)
			love.graphics.setColor(255, 255, 255)
		end
	end

	-- kill all flash
	love.graphics.setColor(160, 47, 0, self.killallflash)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
	love.graphics.setColor(255, 255, 255, 255)

	-- draw game welcome messages
	game:draw()
	------ TEXT ------
end

function love.quit()
	love.event.quit()
	love.filesystem.write("scores.lua", "arcade.highscore\n=\n"..self.highscore)
end

return arcade