require "Source.Collider"

-- See Collider.lua
CircleCollider = Collider:extend("CircleCollider")

CircleCollider.body = nil

function CircleCollider:init(x,y,rot,r,dx,dy,drot,...)
	-- Setup physics object
	self.body = g.world:circle(x,y,r)

	-- Init Collider Obj
	Collider.init(self,x,y,rot,dx,dy,drot,...)
end
