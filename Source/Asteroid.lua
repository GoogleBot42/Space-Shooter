Asteroid = CircleCollider:extend("Asteroid")

Asteroid.color = 0
Asteroid.size = 0
Asteroid.img = nil

-- size: 4 -> "big", 3 -> "med", 2 -> "small", 1 -> "tiny"
-- color: 1 -> "Brown", 2 -> Grey"
function Asteroid:init(x,y,size,color)
	-- set random direction and rotation
	local drot = math.random() * math.pi / 2
	local dforward = math.random() * 75
	local dx = dforward * math.cos(drot * 4)
	local dy = dforward * math.sin(drot * 4)
	
	-- set color and size
	color = color or math.random(1, 2)
	size = size or math.random(1, 4)
	self.color = color
	self.size = size
	
	-- get and store image
	local colorName
	if color == 1 then
		colorName = "Brown"
	elseif color == 2 then
		colorName = "Grey"
	end
	local sizeNameLookup = {"tiny","small","med","big"}
	local sizeNameNumAlternativeImages = {2,2,2,4}
	local randAlternativeImageIndex = math.random(1,sizeNameNumAlternativeImages[size])
	local imgname = "meteor" .. colorName .. "_" .. sizeNameLookup[size] .. randAlternativeImageIndex
	self.img = Images.Meteors[imgname]
	
	
	-- set x and y to some random point just off of the screen (if not passed in the params)
	if x == nil or y == nil then
		x,y = Random.pointOffScreen(self.img:getDimensions())
	end
	
	-- initialize body
	CircleCollider.init(self,x,y,0,self.img:getWidth()/2,dx,dy,drot)
end

function Asteroid:update(dt)
	CircleCollider.update(self,dt)
end

function Asteroid:physicsCallback(other,dist)
	if self.dead then
		-- if the asteroid hits mutiple lasers for example in one physics frame
		-- then we need to be sure that the asteroid only splits into parts once
		return
	end
	if other.name == "Laser" then
		-- create three just like itself but one size smaller
		if self.size > 1 then
			local x,y = self:getXY()
			g.asteroids:add(x,y,self.size-1,self.color)
			g.asteroids:add(x,y,self.size-1,self.color)
			g.asteroids:add(x,y,self.size-1,self.color)
		end
		
		-- destroy self
		self.dead = true
		g.asteroids:remove(self)
		
		if other.createdBy == "Player" then
			g.player:addScore(1)
		end
		
		-- destroy laser
		g.lasers:remove(other)
	end
end

function Asteroid:draw()
	CircleCollider.draw(self)
	love.graphics.draw(self.img,self:getX(),self:getY(),self:getRot(), 1, 1, self.img:getWidth()/2, self.img:getHeight()/2)
end