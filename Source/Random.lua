Random = {}

function Random.pointOnScreen(xboarder,yboarder)
	xboarder = xboarder or 0
	yboarder = yboarder or xboarder
	local w,h = love.graphics.getDimensions()
	return math.random(-xboarder,w+xboarder),math.random(-yboarder,h+yboarder)
end

function Random.pointOffScreen(xboarder,yboarder)
	-- generate random spawn spot out of view at the edge of the map
	local x,y = 0,0
	local w,h = love.graphics.getDimensions()
	local edge = math.random(1,4)
	if edge == 1 then
		x = -xboarder
		y = math.random(0,h)
	elseif edge == 2 then
		x = w + xboarder
		y = math.random(0,h)
	elseif edge == 3 then
		x = math.random(0,w)
		y = -yboarder
	elseif edge == 4 then
		x = math.random(0,w)
		y = h + yboarder
	end
	return x,y
end