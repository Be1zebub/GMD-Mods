-- from incredible-gmod.ru with <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/sv_bonus_on_1st_purchase.lua
-- источник: https://forum.gm-donate.net/t/vydacha-privilegii-za-pokupku-lyubogo-tovara/961/2

local item_uid = "vip4all" -- уникальный интендификатор предмета
--[[ Пример:
IGS("Разноцветный физган", "rainbowphysgun")
:SetPrice(150)
:SetTerm(30)
:SetNetworked(true)

здесь uid будет rainbowphysgun
]]--
local activate = false -- активировать сразу после выдачи? либо просто выдать в инвентарь?
local notify = "Поздравляю с первой покупкой! В качестве награды за поддержку сервера мы дарим вам бесплатную VIP привелегию, пользуйтесь на здоровье."

-------

file.CreateDir("igs")
local cache, sid, fname = {}

hook.Add("IGS.PlayerPurchasedItem", "https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/sv_bonus_on_1st_purchase.lua", function(ply)
	sid = ply:SteamID64()

	if cache[sid] then return end
	cache[sid] = true

	fname = "igs/bonus-on-1st-purchase/".. sid ..".txt"
	if file.Exists(fname, "DATA") then return end

	file.Write(fname, os.time())

	if activate then
		IGS.PlayerActivateItem(ply, item_uid)
	else
		IGS.AddToInventory(ply, item_uid)
	end

	IGS.Notify(ply, notify)
end)
