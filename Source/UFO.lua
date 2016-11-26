require "Source.CircleCollider"

UFO.speed = 100 -- px/sec

UFO.img = nil

function UFO:init()
  self.img = Images.ufoGreen
  -- get position that the UFO will fly to
  local r = self.img:getWidth()/2
  local x,y = Random.pointOffScreen(w,h)
  local destX,destY = Random.pointOnScreen(-w,-h)

  -- init body
  CircleCollider.init(self,x,y,0,0,0,math.pi/2,destX,destY,self.speed)
end

function UFO:update(dt)
  if self.reachedDest then
    -- go in a cicle now

  end
  CircleCollider.update(self,dt)
end

function UFO:draw()
  CircleCollider.draw(self)
  love.graphics.draw(self.img, self:getX(), self.getY(), self.getRot())
end
