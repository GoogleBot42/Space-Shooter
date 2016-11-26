require "Source.Asteroid"

AsteroidController = class "AsteroidController"

AsteroidController.minAsteroids = 10 -- adds more asteroids if the number becomes less than this
AsteroidController.Asteroids = {}

function AsteroidController:init(minAsteroids)
	self.minAsteroids = minAsteroids or self.minAsteroids
	self:checkNumAsteroids()
end

function AsteroidController:checkNumAsteroids()
	while #self.Asteroids < self.minAsteroids do
		self:add()
	end
end

function AsteroidController:add(...)
	table.insert(self.Asteroids, Asteroid(...))
end

-- can be an index or a reference to the asteroid
function AsteroidController:remove(asteroid)
	if type(asteroid) == "number" then
		table.remove(self.Asteroids, asteroid)
	end
	if type(asteroid) == "table" then
		lume.remove(self.Asteroids, asteroid)
	end
end

function AsteroidController:update(dt)
	self:checkNumAsteroids()
	local i,v
	for i,v in ipairs(self.Asteroids) do
		v:update(dt)
	end
end

function AsteroidController:draw()
	local i,v
	for i,v in ipairs(self.Asteroids) do
		v:draw()
	end
end