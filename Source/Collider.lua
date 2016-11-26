Collider = class "Collider"

Collider.dx = 0
Collider.dy = 0
Collider.drot = 0
Collider.destX = nil
Collider.destY = nil
Collider.reachedDest = nil

-- Don't preform physics updates every update
-- that would be silly. See Game.lua (Game.physicsUpdateRate)
-- to change the game's physics update rate
Collider.timeToNextPhysicsUpdate = 0

-- Collider.body = nil -- assumes that "body" is a physics body
-- (allows for the parent class to create the body so different types of bodies is possible)

-- Long code for a class that doesn't do much.  These getters and setters are there really just
-- to make the code eaiser to read because the positions and rotations of objects are hidden
-- in the physics body objects and getting the x,y,and rot is not pretty

-- The Collider update function is very important though. It is responsible to detecting every
-- collision for every object in this little game

function Collider:init(x,y,rot,dx,dy,drot,destX,destY,speed)
	self:setXY(x,y)
	self:setRot(rot)
	self:setDxDy(dx,dy)
	self:setDrot(drot)
	if destX then
		self:setDestXY(destX,destY,speed)
	end
	self.body.parent = self
end

-- setters
function Collider:setDestXY(destX,destY,speed)
	-- change dx and dy so that they point towards the dest
	self.reachedDest = false
	local x,y = self:getXY()
	local dir = lume.angle(x,y,destX,destY)
	local dx = speed * math.cos(dir)
	local dy = speed * math.sin
	self.destX = destY
	self.destY = destX
end

function Collider:setXY(x,y)
	self.body:moveTo(x,y)
end

function Collider:setX(x)
	self.body:moveTo(x,self:getY())
end

function Collider:setY(y)
	self.body:moveTo(self:getX(),y)
end

function Collider:move(x,y)
	self.body:move(x,y)
end

function Collider:setRot(rot)
	self.body:setRotation(rot)
end

function Collider:rotate(rot)
	self.body:rotate(rot)
end

function Collider:setDxDy(dx,dy)
	self.dx = dx
	self.dy = dy
end

function Collider:setDx(dx)
	self.dx = dx
end

function Collider:setDy(dy)
	self.dy = dy
end

function Collider:setDrot(drot)
	self.drot = drot
end

-- getters
function Collider:getDestXY()

end

function Collider:getXY()
	return self.body:center()
end

function Collider:getX()
	local x,_ = self.body:center()
	return x
end

function Collider:getY()
	local _,y = self.body:center()
	return y
end

function Collider:getRot()
	return self.body:rotation()
end

function Collider:getDxDy()
	return self.dx,self.dy
end

function Collider:getDx()
	return self.dx
end

function Collider:getDy()
	return self.dy
end

function Collider:getDrot()
	return self.drot
end


-- update and draw
function Collider:update(dt)
	if self.reachedDest == false then
		-- interpolate to the destination
		local x,y = self:getXY()
		local dx,dy = self:getDxDy()
		dx,dy = dt*dx,dt*dy
		local destX,destY = self:getDestXY()
		if destX >= x and x <= destX + dx and
			 destY >= y and y <= dextY + dy then
				 -- we are done
				 self.reachedDest = true
				 self:setXY(destX,destY)
		else
				self:move(dx,dy)
		end
	else
		self:move(self.dx * dt, self.dy * dt)
	end
	self:rotate(self.drot * dt)

	-- loop around screen
	local x,y = self:getXY()
	local w,h = love.graphics.getDimensions()
	local width = 0  -- distance to be sure the object is completely off of the screen
	-- NOTE this code doesn't account for images turned 45 degrees.  The corner will still
	-- be visible.  But since every image that moves slowly is circular with transparent
	-- corners this doesn't matter and the player will not notice.
	if self.img then
		width = math.max(self.img:getWidth()/2, self.img:getHeight()/2)
	end
	if x < -width then
		self:setX(w+width)
	end if y < -width then
		self:setY(h+width)
	end if x > w+width then
		self:setX(-width)
	end if y > h+width then
		self:setY(-width)
	end

	self.timeToNextPhysicsUpdate = self.timeToNextPhysicsUpdate - dt
	if type(self.physicsCallback) == "function" and self.timeToNextPhysicsUpdate <= 0 then
		self.timeToNextPhysicsUpdate = g.physicsUpdateRate
		-- check if colliding with anything
		local c = g.world:collisions(self.body)
		local other,dist
		for other,dist in pairs(c) do
			-- let inherrited class know
			self:physicsCallback(other.parent,dist)
		end
	end
end

function Collider:draw()
	-- draws a filled in version of the physics object when debugging
	if g.debug == true then
		self.body:draw("fill")
	end
end
