-- from incredible-gmod.ru with <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/mods/wire-mod.lua
-- источники: https://forum.gm-donate.ru/t/kak-sdelat-prodazhu-dostupa-k-wire/1225/2 https://forum.gm-donate.ru/t/kak-dobavit-v-prodazhu-e2p/856/4

-- продажа доступа к инструментам wiremod (гейты, сенсоры и тд)
IGS("Доступ к Wire-mod", "igs_wiremod")
:SetPrice(160)
:SetTerm(30)

hook.Add("CanTool", "https://github.com/Be1zebub/GMD-Mods/blob/master/mods/wire-mod.lua", function(ply, _, toolname) -- запрещает использование инструмента
	if toolname:StartWith("wire_") and not ply:HasPurchase("igs_wiremod") then
		return false
	end
end)

if CLIENT then
	cvars.AddChangeCallback("gmod_toolmode", function(name, old, new) -- выводит уведомлению при экипировке инструмента, если у игрока не куплен доступ
		if LocalPlayer():HasPurchase("igs_wiremod") or old == new or new:StartWith("wire_") == false then return end

		notification.AddLegacy("Wire-mod доступен только по подписке! Нажмите F6 что-бы ознакомиться с предложением.", NOTIFY_ERROR, 3)
	end, "https://github.com/Be1zebub/GMD-Mods/blob/master/mods/wire-mod.lua")
end

-- продажа доступа к Expression 2
IGS("Доступ к E2", "wire_e2")
:SetPrice(500)
:SetTerm(30)
:SetValidator(function() return false end) -- после каждого перезахода выполняет функцию из SetInstaller, пока предмет активный
:SetInstaller(function(ply)
	RunConsoleCommand("e2power_give_access", ply:EntIndex())
end)
