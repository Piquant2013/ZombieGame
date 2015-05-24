-- PLAYER

function player:collision(dt, shape_a, shape_b, mtv_x, mtv_y)

	-- Set player hitbox to a shape
	local other

    if shape_a == plyr.bb then
        other = shape_b
    elseif shape_b == plyr.bb then
        other = shape_a
    else
        return
    end

    -- Rock
    for i, o in ipairs(rocks) do
    	if other == o.bb then
    		plyr.health = plyr.health - 0.4
    		plyr.hurt = true
    	end
    end
end

function player:collisionstopped(dt, shape_a, shape_b, mtv_x, mtv_y)
  
  -- turn to false when the collisions stop
  plyr.hurt = false
  plyr.speed = 80

end

function player:health(dt)

  self.hurttimer = self.hurttimer + dt

  if plyr.hurt == true then
    self.hurttimer = 0
    self.flashred = true
  end

  if self.hurttimer > 0.3 then
    self.flashred = false
  end

  if self.hurttimer > 4 and plyr.hurt == false then
    plyr.health = plyr.health + 1
  end

  if plyr.health > 100 then
    plyr.health = 100
    self.hurttimer = 0
  end

end









-- ZOMBIE

function zombie:collision(dt, shape_a, shape_b, mtv_x, mtv_y)

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

function zombie:collisionstopped(dt, shape_a, shape_b, mtv_x, mtv_y)
  
  for i, o in ipairs(zombs) do
    o.speed = zombspeed 
  end

end