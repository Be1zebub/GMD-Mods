-- from incredible-gmod.ru with <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/mods/movespeed.lua
-- источник: https://forum.gm-donate.ru/t/donat-na-skorost/984/2

IGS("+50 к скорости бега", "movespeed")
:SetDescription("Добавляет +50 к скорости бега. При покупке 2 штук, будет +100, 3 шт = +150")
:SetCategory("Разное")
:SetPrice(150)
:SetStackable(true)
:SetMaxPlayerPurchases(3)
:SetPerma()
:AddHook("PlayerLoadout", function(ply)
	local count = ply:HasPurchase("movespeed")
	timer.Simple(3, function()
		if IsValid(ply) then
			ply:SetRunSpeed(ply:GetRunSpeed() + count * 50)
		end
	end)
end)
