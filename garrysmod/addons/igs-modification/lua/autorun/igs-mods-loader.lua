-- from incredible-gmod.ru with <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/autorun/igs-mods-loader.lua
-- загрузчик модов

local Disabled = { -- для отключения модов
	--["outfitter"] = true -- пример отключения https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/outfitter.lua
}

local realms = {
	sv_ = SERVER and include or function() end,
	cl_ = SERVER and AddCSLuaFile or include
}

local function LoadFile(path, filename)
	if Disabled[filename:match("(.+)%..+")] then return end

	local worker = realms[filename:sub(1, 3)]

	if worker then
		worker(path)
	else
		AddCSLuaFile(path)
		include(path)
	end
end

hook.Add("IGS.Initialized", "https://github.com/Be1zebub/GMD-Mods", function()
	timer.Simple(0, function() -- для модов которые так-же модифицируют другие аддоны (например xenin_battlepass.lua использует BATTLEPASS:CreateReward(), по этому нужно подождать пока xenin-battlepass загрузиться)
		local files, dirs = file.Find("igs/mods/*", "LUA")

		for _, filename in ipairs(files or {}) do
			LoadFile("igs/mods/".. filename, filename)
		end

		for _, dirname in ipairs(dirs or {}) do
			local dir = "igs/mods/".. dirname .."/"
			for _, filename in ipairs(file.Find(dir .."*.lua", "LUA")) do
				LoadFile(dir .. filename, filename)
			end
		end
	end)
end)