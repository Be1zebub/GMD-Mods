-- from incredible-gmod.ru with <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/cashback.lua
-- источник: https://forum.gm-donate.net/t/keshbek/963
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

local function getUID(ply, month)
	if month == nil then
		month = tonumber(os.date("%m"))
	end

	return "igs_cashback_".. month .."_".. ply:SteamID64()
end

function IGS.GetCashback(ply, month)
	return bib.getNum(getUID(ply, month))
end

function IGS.SetCashback(ply, month, summ)
	return bib.setNum(getUID(ply, month), summ)
end

function IGS.AddCashback(ply, summ, month)
	return bib.increment(getUID(ply, month), summ)
end

function IGS.DeleteCashback(ply, month)
	return bib.delete(getUID(ply, month))
end

if SERVER then
	hook.Add("IGS.PlayerPurchasedItem", "https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/cashback.lua", function(ply, item)
		local perc = item:GetMeta("cashback") or 0
		local instant = item:GetMeta("cashback_instant")

		if global and global > perc then
			perc = global
			instant = global_instant
		end

		if prec == 0 then return end

		if instant then
			local cutoff = math.floor(item.price * perc)

			ply:AddIGSFunds(cutoff, "Cashback ".. cutoff .." - ".. math.floor(perc * 100) .."%")
			IGS.Notify(ply, "Спасибо за покупку! Вы получили +".. PL_MONEY(cutoff) .." кэшбэка!")
		else
			local total = IGS.AddCashback(ply, math.floor(item.price * perc))

			IGS.Notify(ply, "Спасибо за покупку! В следующем месяце вы получите +".. PL_MONEY(total) .." кэшбэка!")
		end
	end)

	hook.Add("IGS.PlayerPurchasesLoaded", "https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/cashback.lua", function(ply)
		local month = tonumber(os.date("%m")) - 1
		local cashback = IGS.GetCashback(ply, month)
		if not cashback then return end

		IGS.DeleteCashback(ply, month)
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
-- :SetCashback(0.25, true) -- 25%, мгновенный кэшбэк

-- пример включения глобального кэшбэка
IGS.SetGlobalCashback(true, 0.15, false) -- включить, 15%, не мгновенный
-- IGS.SetGlobalCashback(true, 0.2, true) -- включить, 20%, мгновенный
-- IGS.SetGlobalCashback(false) -- отключить
