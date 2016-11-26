require "Source.CircleCollider"

Ship = CircleCollider:extend("Ship")

Ship.inertialDampersRatio = 0.02

Ship.fireRate = 0.1
Ship.timeToNextFire = 0
Ship.laserSpeed = 350

Ship.maxDrot = math.pi -- no more than a half turn a second
Ship.maxSquaredDxDy = 100000 -- cannot move more than sqrt(100000) == 316 pixels a second

Ship.img = nil

function Ship:init(x,y,rot)
	self.img = Images.playerShip1_orange
	CircleCollider.init(self,x,y,rot,self.img:getHeight()/2,0,0,0)
end

function Ship:PushForward(power)
	local rot = self:getRot()
	local dx = self:getDx() + power * math.cos(rot)
	local dy = self:getDy() + power * math.sin(rot)
	if dx * dx + dy * dy < self.maxSquaredDxDy then
		self:setDx(dx)
		self:setDy(dy)
	end
end

function Ship:PushRotate(power)
	local newDrot = self:getDrot() + power
	if math.abs(newDrot) < self.maxDrot then
		self:setDrot(newDrot)
	end
end

function Ship:fire(dt)
	if self.timeToNextFire <= 0 then
		self.timeToNextFire = self.fireRate
		
		-- calculate where the laser needs to start
		local x,y = self:getXY()
		local rot = self:getRot()
		x = x + math.cos(rot) * self.img:getHeight()/2
		y = y + math.sin(rot) * self.img:getHeight()/2
		g.lasers:add(x, y, self.laserSpeed, rot, self.name)
	end
end

function Ship:update(dt, accelerating)
	self.timeToNextFire = self.timeToNextFire - dt
	
	CircleCollider.update(self,dt)
end

function Ship:draw()
	CircleCollider.draw(self)
	love.graphics.draw(self.img,self:getX(),self:getY(),self:getRot()+math.pi/2, 1, 1, self.img:getWidth()/2, self.img:getHeight()/2)
end