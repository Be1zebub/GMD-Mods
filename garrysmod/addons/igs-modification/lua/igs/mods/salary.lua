-- from incredible-gmod.ru with <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/salary.lua
-- источник: https://forum.gm-donate.net/t/kak-sdelat-uvelichenie-zarplaty/1218/7

-- создание предмета
IGS("Дополнительная зарплата", "added_salary")
:SetPrice(100)
:SetPerma()
:SetStackable()
:SetCategory("Плюшки")
:SetDescription("+10% к зарплате") -- каждая покупка даёт +10% к зарплате
:SetMaxPlayerPurchases(3) -- максимум покупок. 3 = максимум +30% к зарплате

local usergroups_bouns = false -- включить бонус от привелегий?
local groups = { -- множитель зарплаты для привелегий
	vip = 1.1, -- 110% зарплаты
	premium = 1.2 -- 120% зарплаты
}

if SERVER then
	if usergroups_bouns then -- с бонусом от привелегий
		local changed = false
		hook.Add("playerGetSalary", "igs_salary", function(ply, salary)
			if ply:getDarkRPVar("AFK") then return end
			changed = false

			if groups[ply:GetUserGroup()] then
				salary = salary * groups[ply:GetUserGroup()]
				changed = true
			end
			if ply:HasPurchase("added_salary") then
				salary = salary * (1 + ply:HasPurchase("added_salary") * 0.1)
				changed = true
			end

			if changed then
				return false, false, salary
			end
		end)
	else -- без бонуса от привлеегий
		hook.Add("playerGetSalary", "https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/salary.lua", function(ply, salary)
			if not ply:getDarkRPVar("AFK") and ply:HasPurchase("added_salary") then
				return false, false, salary * (1 + ply:HasPurchase("added_salary") * 0.1)
			end
		end)
	end
end