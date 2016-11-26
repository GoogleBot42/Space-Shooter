require "Source.Laser"

LaserController = class "LaserController"

LaserController.Lasers = {}

function LaserController:init()
end

function LaserController:add(...)
	table.insert(self.Lasers, Laser(...))
end

-- can be an index or a reference to the Laser
function LaserController:remove(Laser)
	if type(Laser) == "number" then
		table.remove(self.Lasers, Laser)
	end
	if type(Laser) == "table" then
		lume.remove(self.Lasers, Laser)
	end
end

function LaserController:update(dt)
	local i,v
	for i,v in ipairs(self.Lasers) do
		v:update(dt)
	end
end

function LaserController:draw()
	local i,v
	for i,v in ipairs(self.Lasers) do
		v:draw()
	end
end