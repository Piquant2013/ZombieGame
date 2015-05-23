-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Creates game as a new gamestate
astroids = Gamestate.new()


function astroids:initialize()

	-- Rock master table
	rocks = {}

	SpawnTime = 0
	SpawnTimePlus = 0.38

end

function astroids:collision(dt, shape_a, shape_b, mtv_x, mtv_y)

	for i, o in ipairs(rocks) do
		for c, v in ipairs(gun.Bullets) do

			-- Set zombie hitbox to a shape
			local other

			if shape_a == o.bb then
				other = shape_b
			elseif shape_b == o.bb then
				other = shape_a
			end

			-- what the rock is colliding with and what to do
			if other == v.bb then
				o.health = o.health - 10
				
				o.x = o.x + math.cos(v.Dir) * hitmove * dt
				o.y = o.y + math.sin(v.Dir) * hitmove * dt

				Collider:remove(v.bb)
				table.remove(gun.Bullets, c)

				if o.health < 0 then
					o.health = 0
					game.score = game.score + 10
					kills = kills + 1
					zombies = zombies - 1					
					Collider:remove(o.bb)
					table.remove(rocks, i)
				end
			end
		end
	end
end

function astroids:wallcollision(dt, shape_a, shape_b, mtv_x, mtv_y)

	for i, o in ipairs(rocks) do
		
		local other

		if shape_a == o.bb then
			other = shape_b
		elseif shape_b == o.bb then
			other = shape_a
		end

		if other == wallT then
    		--o.bb:move(mtv_x, mtv_y)
   			--o.y = o.y + 4 + mtv_y
   			--o.speed = 0
   		elseif other == wallB then
    		--o.bb:move(mtv_x, mtv_y)
   			--o.y = o.y - 4 + mtv_y
   			--o.speed = 0
   		elseif other == wallL then
   			--o.bb:move(mtv_x, mtv_y)
   			--o.x = o.x + 4 + mtv_x
   			--o.speed = 0
   		elseif other == wallR then
   			--o.bb:move(mtv_x, mtv_y)
   			--o.x = o.x - 4 + mtv_x
   			--o.speed = 0
   		end
   	end
end

function astroids:collisionstopped(dt, shape_a, shape_b, mtv_x, mtv_y)
	
	for i, o in ipairs(rocks) do
		o.speed = zombspeed 
	end

end

function astroids:spawn()


	if SpawnTime <= 0 then

		random = love.math.random(1, 4)

		if random == 1 then
			Rx = love.math.random(100, 1100)
			Ry = love.math.random(1, 10)
		elseif random == 2 then
			Rx = love.math.random(1, 10)
			Ry = love.math.random(100, 600)
		elseif random == 3 then
			Rx = love.math.random(1190, 1200)
			Ry = love.math.random(100, 600)
		elseif random == 4 then
			Rx = love.math.random(100, 1100)
			Ry = love.math.random(690, 700)
		end

		-- Rock table and its varibles
		rock = {}    

		-- The contents of the rock table
		rock.sprite = love.graphics.newImage("images/zombies/zombie.png")
		rock.health = zombhealth
		rock.speed = zombspeed
		rock.x = Rx
		rock.y = Ry
		rock.bb = Collider:addRectangle(rock.x, rock.y, 12, 16)

		-- Insert Rock
		table.insert(rocks, rock)

		-- Reset shot timer
		SpawnTime = SpawnTimePlus
		zombies = zombies + 1

	end

end

function astroids:update(dt)

	for i = 1, #rocks do
		for j = i + 1, #rocks do
			if (rocks[i].x > (rocks[j].x - 12) and (rocks[i].x < (rocks[j].x + 12))) and (rocks[i].y > (rocks[j].y - 16) and (rocks[i].y < (rocks[j].y + 16))) then
				
				rotrot = math.atan2(rocks[i].x - rocks[j].x, rocks[j].y - rocks[i].y) + math.pi / 2

				rocks[j].x = rocks[j].x + math.cos(rotrot) * 30 * dt
				rocks[j].y = rocks[j].y + math.sin(rotrot) * 30 * dt

				--rocks[j].x = rocks[j].x + 2
				--rocks[j].y = rocks[j].y + 2
			end
		end
	end

	SpawnTime = math.max(0, SpawnTime - dt)

	for i,v in ipairs(rocks) do
    		
    	rockrotation = math.atan2(v.x - plyr.x, plyr.y - v.y) + math.pi / 2

    	local dx = math.cos(rockrotation) * (dt * v.speed)
    	local dy = math.sin(rockrotation) * (dt * v.speed)
		
		v.x = v.x + dx
   		v.y = v.y + dy

	end
end

function astroids:draw()

	for i,v in ipairs(rocks) do
		
		------ FILTERS ------
		v.sprite:setFilter( 'nearest', 'nearest' )
		------ FILTERS ------

		-- Set color
		love.graphics.setColor(255, 255, 255)
		

		
		rockrot = math.atan2(v.x - plyr.x, plyr.y - v.y) + math.pi / 2
		v.bb:moveTo(v.x, v.y)
   		v.bb:setRotation(rockrot)


		-- Rock graphic
		love.graphics.draw(v.sprite, v.x, v.y, rockrot, 1, 1, rock.sprite:getWidth()/2, rock.sprite:getHeight()/2)
		--v.bb:draw('line')
	end
end

return astroids