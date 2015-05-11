-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads Hardon Collider script
local HC = require 'libs/hardoncollider'

-- Creates game as a new gamestate
astroids = Gamestate.new()


function astroids:initialize()

	-- Rock master table
	rocks = {}
end

function astroids:collision(dt, shape_a, shape_b, mtv_x, mtv_y)

	for i, o in ipairs(rocks) do
		for c, v in ipairs(gun.Bullets) do

			-- Set ship hitbox to a shape
			local other

			if shape_a == o.bb then
				other = shape_b
			elseif shape_b == o.bb then
				other = shape_a
			end

			-- what the rock is colliding with and what to do
			if other == v.bb then
				o.health = o.health - 10
				Collider:remove(v.bb)
				table.remove(gun.Bullets, c)

				if o.health < 0 then
					o.health = 0
					Collider:remove(o.bb)
					table.remove(rocks, i)
				end
			end
		end
	end
end

function astroids:collisionstopped(dt, shape_a, shape_b, mtv_x, mtv_y)

end

function astroids:spawn()

	-- Rock table and its varibles
	rock = {}    

	-- The contents of the rock table
	rock.sprite = love.graphics.newImage("images/rock.png")
	rock.health = 20
	rock.speed = 20
	rock.x = love.math.random(304, 1168)
	rock.y = love.math.random(240, 1104)
	rock.bb = Collider:addRectangle(rock.x, rock.y, 12, 16)

	-- Insert Rock
	table.insert(rocks, rock)

end

function astroids:update(dt)
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
		v.bb:draw('line')
	end
end

return astroids