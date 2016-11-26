require "Library.30log"
require "Library.inspect"
require "Library.lume"
HC = require "Library.HC"

require "Source.Game"

-- global var g is the Game object and stores everything

function love.load(args)
	math.randomseed(os.time())
	g = Game(args)
end

function love.update(dt)
	g:update(dt)
end

function love.draw()
	g:draw()
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end

function love.resize()
	g:resize()
end