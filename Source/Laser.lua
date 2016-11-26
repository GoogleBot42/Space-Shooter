require "Source.BoxCollider"
Laser = BoxCollider:extend("Laser")

Laser.img = nil
Laser.createdBy = "nobody"

Laser.maxTimeAlive = 5 -- 5 seconds
Laser.timeAlive = 0

function Laser:init(x,y,speed,rot,createdBy)
	-- TODO add different colors of lasers
	self.img = Images.Lasers.laserBlue01
	self.createdBy = createdBy
	self.timeAlive = self.maxTimeAlive
	local w,h = self.img:getDimensions()
	BoxCollider.init(self,x,y,w,h,rot+math.pi/2,speed*math.cos(rot),speed*math.sin(rot))
end

function Laser:update(dt)
	self.timeAlive = self.timeAlive - dt
	if self.timeAlive <= 0 then
		g.lasers:remove(self)
	end
	BoxCollider.update(self,dt)
end

function Laser:draw()
	BoxCollider.draw(self)
	local lifeleft = self.timeAlive / self.maxTimeAlive * 255
	love.graphics.setColor(255, 255, 255, lifeleft )
	love.graphics.draw(self.img,self:getX(),self:getY(), self:getRot(), 1, 1, self.img:getWidth()/2, self.img:getHeight()/2)
	love.graphics.setColor(255, 255, 255, 255 )
end