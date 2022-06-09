-- from incredible-gmod.ru with <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/outfitter.lua
-- источник: https://forum.gm-donate.ru/t/kak-zapretit-ispolzovat-outfitter-igrokam/1265

hook.Add("CanOutfit", "https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/outfitter.lua", function(ply)
	if not ply:HasPurchase("outfitter") then
		return false
	end
end)

IGS("Доступ к Outfitter", "outfitter")
:SetPrice(500)
:SetTerm(30)
:SetNetworked(true)
