-- from incredible-gmod.ru with <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/mods/bonus_on_1st_purchase.lua
-- источник: https://forum.gm-donate.ru/t/vydacha-privilegii-za-pokupku-lyubogo-tovara/961/2

local item_uid = "vip4all"
local activate = false -- активировать сразу после выдачи? либо просто выдать в инвентарь?
local notify = "Поздравляю с первой покупкой! В качестве награды за поддержку сервера мы дарим вам бесплатную VIP привелегию, пользуйтесь на здоровье."

-------

file.CreateDir("igs")
local cache, sid, fname = {}

hook.Add("IGS.PlayerPurchasedItem", "gm-donate.ru/bonus-on-1st-purchase", function(ply)
	sid = ply:SteamID64()
	if cache[sid] then return end

	cache[sid] = true

	fname = "igs/bonus-on-1st-purchase/"
	if file.Exists(fname, "DATA") then return end

	file.Write(fname, os.time())

	if activate then
		IGS.PlayerActivateItem(ply, item_uid)
	else
		IGS.AddToInventory(ply, item_uid)
	end

	IGS.Notify(ply, notify)
end)
