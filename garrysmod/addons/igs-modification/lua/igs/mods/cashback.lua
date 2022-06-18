-- from incredible-gmod.ru with <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/cashback.lua
-- источник: https://forum.gm-donate.ru/t/keshbek/963
-- спасибо @amd_nick за вклад

-- мгновенный кэш-бэк выдаётся сразу после покупки
-- не мгновенный копиться и выдаётся в начале следующего месяца

local ITEM = FindMetaTable("IGSItem")

function ITEM:SetCashback(percent, instant) -- процент 0.2 = 20%, 0.5 = 50%, мгновенный или в следующем месяце?
	self:SetMeta("cashback", percent)
	self:SetMeta("cashback_instant", tobool(instant))
	return self
end

local global, global_instant

function IGS.SetGlobalCashback(enable, percent, instant)
	if enable then
		global, global_instant = percent, tobool(instant)
	else
		global, global_instant = nil, nil
	end
end

if SERVER then
	hook.Add("IGS.PlayerPurchasedItem", "https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/cashback.lua", function(ply, item)
		local perc = item:GetMeta("cashback")
		if (perc or 0) <= 0 and (global or 0) <= 0 then return end

		if item:GetMeta("cashback_instant") then
			local cutoff = math.floor(item.price * perc)
			ply:AddIGSFunds(cutoff, "Cashback ".. cutoff .." - ".. (perc * 100) .."%")

			IGS.Notify(ply, "Спасибо за покупку! Вы получили +".. PL_MONEY(cutoff) .." кэшбэка!")
		elseif global_instant then
			local cutoff = math.floor(item.price * global)
			ply:AddIGSFunds(cutoff, "Cashback ".. cutoff .." - ".. (global * 100) .."%")

			IGS.Notify(ply, "Спасибо за покупку! Вы получили +".. PL_MONEY(cutoff) .." кэшбэка!")
		elseif global then
			local summ = math.floor(ITEM.price * global)
			local total = bib.incr(ply, "igs_cashback_".. tonumber(os.date("%m")) .."_".. ply:SteamID64(), summ)

			IGS.Notify(ply, "Спасибо за покупку! В следующем месяце вы получите +".. PL_MONEY(total) .." кэшбэка!")
		else
			local summ = math.floor(ITEM.price * perc)
			local total = bib.incr(ply, "igs_cashback_".. tonumber(os.date("%m")) .."_".. ply:SteamID64(), summ)

			IGS.Notify(ply, "Спасибо за покупку! В следующем месяце вы получите +".. PL_MONEY(total) .." кэшбэка!")
		end
	end)

	hook.Add("IGS.PlayerPurchasesLoaded", "https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/cashback.lua", function(ply)
		local uid = "igs_cashback_".. (tonumber(os.date("%m")) - 1) .."_".. ply:SteamID64()
		local cashback = bib.getNum(ply, uid)
		if not cashback then return end

		bib.delete(uid)
		ply:AddIGSFunds(cashback, "Monthly Cashback")
		IGS.Notify(ply, "Вы получили ".. PL_MONEY(cashback) .." кэшбэка за вашу поддержку в прошлом месяце, наслаждайтесь!")
	end)
end

-- пример создания предмета с кэшбэком

IGS("VIP на месяц", "vip_na_mesyac")
:SetULXGroup("vip")
:SetPrice(150)
:SetTerm(30) -- 30 дней
:SetCategory("Группы")
:SetDescription("С этой покупкой вы станете офигенными, потому что в ней воооот такая куча крутых возможностей")
:SetCashback(0.3) -- 30%, накопленная сумма кэшбэка выдасться в следующем месяце
--:SetCashback(0.25, true) -- 25%, мгновенный кэшбэк

-- пример включения глобального кэшбэка
IGS.SetGlobalCashback(true, 0.15, false) -- включить, 15%, не мгновенный
