-- from incredible-gmod.ru with <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/mods/rainbowphysgun.lua
-- источник: https://forum.gm-donate.ru/t/raznoczvetnyj-fizgan-v-donat-menyu/34/5

IGS("Разноцветный физган", "rainbowphysgun")
:SetPrice(150)
:SetTerm(30)

local item_uid = "rainbowphysgun"

if SERVER then
	hook.Add("IGS.PlayerPurchasesLoaded", "https://github.com/Be1zebub/GMD-Mods/blob/master/mods/rainbowphysgun.lua", function(pl)
		if pl:HasPurchase(item_uid) then
			pl:SetNWBool(item_uid, true)
		end
	end)

	hook.Add("IGS.PlayerActivatedItem", "https://github.com/Be1zebub/GMD-Mods/blob/master/mods/rainbowphysgun.lua", function(pl, item)
		if item:UID() == item_uid then
			pl:SetNWBool(item_uid, true)
		end
	end)
else
	local div = 255 / 1
	local col, vec_col

	hook.Add("Think", "https://github.com/Be1zebub/GMD-Mods/blob/master/mods/rainbowphysgun.lua", function()
		col = HSVToColor(CurTime() % 360, 1, 1)
		vec_col = Vector(col.r * div, col.g * div, col.b * div)

		for _, ply in ipairs(player.GetHumans()) do
			if ply:GetNWBool(item_uid, false) then
				ply:SetWeaponColor(vec_col)
			end
		end
	end)
end
