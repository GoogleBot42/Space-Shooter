Background = class "Background"

Background.name = "darkPurple"
Background.quad = nil

Background.img = nil

function Background:init(name)
	self:change(name)
end

function Background:change(name)
	self.name = name or self.name
	self.img = Images.Backgrounds[self.name]
	self:resize()
end

function Background:resize()
	local w,h = love.graphics.getDimensions()
	self.img:setWrap("mirroredrepeat","repeat")
	self.quad = love.graphics.newQuad(0,0,w,h,self.img:getWidth(),self.img:getHeight())
end

function Background:draw()
	love.graphics.draw(self.img, self.quad, 0, 0)
end