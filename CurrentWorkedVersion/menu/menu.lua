-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates menu as a new gamestate
menu = Gamestate.new()

-- Loads game script
game = require 'game/game'

-- Loads options script
options = require 'menu/options'


function menu:init()

	------ VARIABLES ------
	-- Play Button Y & X
	self.PlayBtnY = 442
	self.PlayBtnX = 582
	
	-- Quit Button Y & X
	self.OptBtnY = 492
	self.OptBtnX = 550

	-- Option Button Y & X
	self.QuitBtnY = 542
	self.QuitBtnX = 592
	
	-- Button Selecter Y & X
	self.ArrowY = (self.PlayBtnY)
	self.ArrowX = 480

	-- Menus state
	self.PlayState = false
	self.OptState = false
	self.ExitState = false

	-- Resets the game play when true
	GameReset = true



	logomove = 150


	------ VARIABLES ------

	------ IMAGES ------
	self.MenuTitle = love.graphics.newImage("images/menutext.png")
	self.bg = love.graphics.newImage("images/bg.png")
	------ IMAGES ------

	------ AUDIO ------
	self.Enter = love.audio.newSource("audio/enter.ogg")
	self.Select1 = love.audio.newSource("audio/sel.ogg")
	self.Select2 = love.audio.newSource("audio/sel.ogg")
	self.Select3 = love.audio.newSource("audio/sel.ogg")
	------ AUDIO ------

	-- Sets Menu fonts and size
	self.MenuFont = love.graphics.newFont("fonts/PressStart.ttf", 30)

	-- Set mouse visibility to true
	love.mouse.setVisible(true)
end

function menu:update(dt)
	 
	logomove = logomove - dt - 4

	if logomove < 100 then
		logomove = 100
	end



	if menu.ArrowY == menu.PlayBtnY then
		menu.ArrowX = love.graphics.getWidth()/2 - 540/2
		menu.PlayState = true
		menu.OptState = false
		menu.ExitState = false
		love.audio.stop(menu.Select2)
		love.audio.stop(menu.Select3)
	end

	if menu.ArrowY == menu.QuitBtnY then
		menu.ArrowX = love.graphics.getWidth()/2 - 240/2
		menu.OptState = false
		menu.PlayState = false
		menu.ExitState = true
		love.audio.stop(menu.Select1)
		love.audio.stop(menu.Select3)
	end

	if menu.ArrowY < menu.QuitBtnY and menu.ArrowY > menu.PlayBtnY then
		menu.ArrowX = love.graphics.getWidth()/2 - 360/2
		menu.ArrowY = menu.OptBtnY
		menu.ExitState = false
		menu.PlayState = false
		menu.OptState = true
		love.audio.stop(menu.Select1)
		love.audio.stop(menu.Select2)
	end
	
	if menu.ArrowY > menu.QuitBtnY then
		menu.ArrowY = menu.QuitBtnY
	end

	if menu.ArrowY < menu.PlayBtnY then
		menu.ArrowY = menu.PlayBtnY
	end
end

function menu:keypressed(key)

	if key == "escape" then
		Gamestate.pop()
		logomovestart = 100
		logomove = 150
	end

	if key == "up" or key == "w" then
		love.audio.play(menu.Select1)
		love.audio.play(menu.Select2)
		love.audio.play(menu.Select3)
		menu.ArrowY = menu.ArrowY - 50
	end

	if key == "down" or key == "s" then
		love.audio.play(menu.Select1)
		love.audio.play(menu.Select2)
		love.audio.play(menu.Select3)
		menu.ArrowY = menu.ArrowY + 50
	end

	if key == "return" and menu.PlayState == true then
		
		love.audio.play(menu.Enter)
		Gamestate.switch(game)
		love.audio.play(GameMusic)
		GameMusic:setLooping(true)
		love.audio.stop(MenuMusic)
	end

	if key == "return" and menu.ExitState == true then
		love.event.quit()
	end

	if key == "return" and menu.OptState == true then
		
		love.audio.play(menu.Enter)
		Gamestate.push(options)
	end
end

function menu:draw()
	
	menu.MenuTitle:setFilter( 'nearest', 'nearest' )
	menu.MenuFont:setFilter( 'nearest', 'nearest' )

	love.graphics.draw(self.bg, 0, love.graphics.getHeight() - self.bg:getHeight() + 16)

	love.graphics.setColor(160, 47, 0)
	love.graphics.rectangle("fill", menu.ArrowX, menu.ArrowY - 8, 28, 28 )
	
	love.graphics.setFont( menu.MenuFont )
	love.graphics.print('START NEW GAME', (love.graphics.getWidth()/2 - menu.MenuFont:getWidth( "START NEW GAME" )/2), menu.PlayBtnY)
	love.graphics.print('QUIT', (love.graphics.getWidth()/2 - menu.MenuFont:getWidth( "QUIT" )/2), menu.QuitBtnY)
	love.graphics.print('SETTINGS', (love.graphics.getWidth()/2 - menu.MenuFont:getWidth( "SETTINGS" )/2), menu.OptBtnY)
	
	love.graphics.setColor(255, 255, 255, 255)
	
	love.graphics.draw(menu.MenuTitle, (love.graphics.getWidth()/2 - menu.MenuTitle:getWidth()/2), logomove)
end

return menu