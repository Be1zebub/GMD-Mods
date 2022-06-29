-- from incredible-gmod.ru with <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/rainbowphysgun.lua
-- источник: https://forum.gm-donate.net/t/raznoczvetnyj-fizgan-v-donat-menyu/34/5

IGS("Разноцветный физган", "rainbowphysgun")
:SetPrice(150)
:SetTerm(30)
:SetNetworked(true)

local item_uid = "rainbowphysgun"

if CLIENT then
	local div = 255 / 1
	local col, vec_col

	hook.Add("Think", "https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/rainbowphysgun.lua", function()
		col = HSVToColor(CurTime() % 360, 1, 1)
		vec_col = Vector(col.r * div, col.g * div, col.b * div)

		for _, ply in ipairs(player.GetHumans()) do
			if ply:HasPurchase(item_uid) then
				ply:SetWeaponColor(vec_col)
			end
		end
	end)
end
