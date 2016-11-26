require "Source.Ship"

Player = Ship:extend("Player")

Player.forwardMultiplier = 5
Player.rotMultiplier = 0.1

Player.lives = 3
Player.score = 0

Player.hurtInvincibleTime = 2 -- seconds invincible after getting hurt
Player.hurtInvincibilityTimeLeft = 0

function Player:init()
	local w,h = love.graphics.getDimensions()
	Ship.init(self,w/2,h/2,0)
end

function Player:addScore(points)
	self.score = self.score + points
end

function Player:update(dt)
	if love.keyboard.isDown("up") then
		self:PushForward(Player.forwardMultiplier)
	end if love.keyboard.isDown("down") then
		self:PushForward(-1 * Player.forwardMultiplier)
	end if love.keyboard.isDown("right") then
		self:PushRotate(Player.rotMultiplier)
	end if love.keyboard.isDown("left") then
		self:PushRotate(-1 * Player.rotMultiplier)
	end
	if love.keyboard.isDown("space") then
		self:fire(dt)
	end
	if self.lives <= 0 then
		print("[Player.lua] You lose!")
		print("[Player.lua] You scored " .. self.score .. " points!")
		love.event.quit()
	end
	
	self.hurtInvincibilityTimeLeft = self.hurtInvincibilityTimeLeft - dt
	
	Ship.update(self,dt)
end

function Player:physicsCallback(other,dist)
	if self.hurtInvincibilityTimeLeft <= 0 then
		local takeDamage = false
		if other.name == "Laser" then
			if other.createdBy ~= "Player" then
				takeDamage = true
			end
		end
		if other.name == "Asteroid" then
			takeDamage = true
		end
		if takeDamage then
			self.hurtInvincibilityTimeLeft = self.hurtInvincibleTime
			self.lives = self.lives - 1
			print("[Player.lua] Player killed by " .. other.name)
			print("[Player.lua] " .. self.lives .. " lives left")
		end
	end
end

function Player:draw()
	-- add blink if damage was taken
	-- blink 1.5 times a second
	if self.hurtInvincibilityTimeLeft <= 0 then
		Ship.draw(self)
	else
		local n = self.hurtInvincibilityTimeLeft * 1.5
		n = n - math.floor(n)
		n = 1 - n
		n = n * 205 + 50
		love.graphics.setColor(255, 255, 255, n )
		Ship.draw(self)
		love.graphics.setColor(255, 255, 255, 255 )
	end
end