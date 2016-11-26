HUD = class "HUD"

-- for fetching scores and lives left from
HUD.font = nil

function HUD:init()
	-- setup the special hand stiched score font
	-- needs to be loaded by manually because love2d uses a different
	-- callback so auto loading scripts don't support this font yet
	-- TODO maybe fix this somehow
	self.font = love.graphics.newImageFont("Assets/Images/UI/CounterFont.png","0123456789x")
end

function HUD:draw()
	-- TODO change ship icon so the ship color matches
	
	-- draw lives left icon
	love.graphics.draw(Images.UI.playerLife1_orange, 20, 20)
	
	-- print lives left
	love.graphics.setFont(self.font)
	love.graphics.print("x", 55, 26) -- 26 instead of 25 because the font I put together by hand is a bit off. wtf :P
	love.graphics.print(tostring(g.player.lives), 76, 25)
	
	-- print score
	local w,h = love.graphics.getDimensions()
	love.graphics.printf(tostring(g.player.score), w - 300, 25, 270, "right")
end