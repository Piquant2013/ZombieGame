-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates questionmark as a new gamestate
questionmark = Gamestate.new()

function questionmark:initialize()
	------ VARIABLES ------
	-- questionmark spawn rate
	self.spawnrate = 0
	self.spawnrateplus = 0
	
	-- questionmark vars
	self.count = 0
	
	-- questionmarks table
	self.questionmarks = {}
	------ VARIABLES ------
end

function questionmark:spawn()	
	
	if self.spawnrate <= 0 then
		
		-- Sets the random spawn points for the questionmark
		self.questionmarkzrx = love.math.random(230, 980)
		self.questionmarkzry = love.math.random(180, 530)

		if self.questionmarkzrx > 490 and self.questionmarkzrx < 709 and self.questionmarkzry > 244 and self.questionmarkzry < 459 then
			self.questionmarkzrx = love.math.random(709, 980)
			self.questionmarkzry = love.math.random(459, 530)
		end

		-- itemquestionmark table
		itemquestionmark = {} 
		
		-- The contents of the itemquestionmark table
		itemquestionmark.x = self.questionmarkzrx
		itemquestionmark.y = self.questionmarkzry
		itemquestionmark.bb = Collider:addRectangle(itemquestionmark.x, itemquestionmark.y, 20, 20)
		itemquestionmark.sprite = love.graphics.newImage("images/weapons/questionmark.png")
		itemquestionmark.sprite2 = love.graphics.newImage("images/weapons/fadequestionmark.png")
		
		-- Insert questionmark
		table.insert(self.questionmarks, itemquestionmark)
		
		-- set the spawn rate and add one questionmark to questionmark count
		self.spawnrate = self.spawnrateplus
		self.count = self.count + 1
	end
end

function questionmark:update(dt)
	
	-- refresh the spawn rate
	self.spawnrate = math.max(0, self.spawnrate - dt)
end

function questionmark:draw()
	
	for i, o in ipairs(self.questionmarks) do
		
		------ FILTERS ------
		o.sprite:setFilter( 'nearest', 'nearest' )
		o.sprite2:setFilter( 'nearest', 'nearest' )
		------ FILTERS ------
		
		------ IMAGES ------
		if arcade.questionmarkhad == false then
			love.graphics.draw(o.sprite, o.x, o.y)
			love.graphics.setColor(255, 255, 255, arcade.gunsflash)
			love.graphics.draw(o.sprite2, o.x, o.y)
			love.graphics.setColor(255, 255, 255)
		end
		------ IMAGES ------
	end
end

return questionmark