Loader = {}

function Loader.image(path)
	return love.graphics.newImage(path)
end

function Loader.sound(path)
	return love.sound.newSoundData(path)
end

function Loader.font(path)
	return love.graphics.newFont(path)
end

local function StripExtension(name)
	local s = name:match("^.+(%..+)$")
	if s == nil then return name end
	return name:gsub(s,"")
end

--
-- Recursively loads the files in the directly given using the loader function provided
-- some are implemented above

-- Every file/dir becomes an entry in the returned lua table.  Directories are also tables
-- with their own entries.  The extension of files are sripped for convienience.

-- So if an image called "test.png" is in the "hello" directory in the project root
-- the following code will load and access the image
-- local Images = Loader.load("",Loader.image)
-- Images.hello.test
-- 
-- Or if you are fancy you could use the one liner
-- Loader.load("",Loader.image).hello.test
--
-- In this project all of the images are loaded in one function call and written to the global
-- var called "Images" the same is true for "Sounds" and "Fonts"
function Loader.load(dir,loaderfunc)
	local t = {}
	local files = love.filesystem.getDirectoryItems(dir)
	local i, v
	for i,v in ipairs(files) do
		local fullpath = dir .. "/" .. v
		if love.filesystem.isFile(fullpath) then
			local result = loaderfunc(fullpath)
			if result then
				t[StripExtension(v)] = result
				print("[Loader.lua] Loaded asset \"" .. fullpath .. "\"")
			else
				-- love2d throws an error so I will need to catch it for this code to ever run
				-- so this is more of a place holder
				-- TODO catch that error
				print("[Loader.lua] Failed to load asset \"" .. fullpath .. "\"")
			end
		elseif love.filesystem.isDirectory(fullpath) then
			t[v] = Loader.load(fullpath, loaderfunc)
		end
	end
	return t
end