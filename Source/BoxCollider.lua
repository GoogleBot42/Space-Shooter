require "Source.Collider"

-- See Collider.lua
BoxCollider = Collider:extend("BoxCollider")

BoxCollider.body = nil

function BoxCollider:init(x,y,w,h,rot,dx,dy,...)
	-- Setup physics object
	self.body = g.world:rectangle(x,y,w,h)

	-- Init Collider obj
	Collider.init(self,x,y,rot,dx,dy,0,...)
end
