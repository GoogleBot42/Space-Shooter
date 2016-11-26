require "Source.Loader"
require "Source.Random"
require "Source.Player"
require "Source.AsteroidController"
require "Source.LaserController"
require "Source.Background"
require "Source.HUD"

Game = class "Game"

Game.world = nil -- physics world
Game.background = nil
Game.asteroids = nil
Game.lasers = nil
Game.player = nil
Game.hud = nil

Game.physicsUpdateRate = 0.1 -- 10 times a second

function Game:init(args)
	print(inspect(args))
	-- see if the player specified the min number of asteroids
	local minAsteroids = tonumber(args[2])
	if type(minAsteroids) ~= "number" then
		minAsteroids = 30
	end
	
	Images = Loader.load("Assets/Images",Loader.image)
	Sounds = Loader.load("Assets/Sounds",Loader.sound)
	Fonts = Loader.load("Assets/Fonts",Loader.font)
	
	g = self -- define global g, some constructors need access to it for the physics world object, for example
	
	-- enable/disable debug mode
	self.debug = false
	
	self.world = HC.new()
	self.background = Background()
	self.asteroids = AsteroidController(minAsteroids)
	self.lasers = LaserController()
	self.player = Player()
	self.hud = HUD()
end

function Game:update(dt)
	self.asteroids:update(dt)
	self.lasers:update(dt)
	self.player:update(dt)
end

function Game:draw()
	self.background:draw()
	self.asteroids:draw()
	self.lasers:draw()
	self.player:draw()
	self.hud:draw()
end

function Game:resize()
	self.background:resize()
end