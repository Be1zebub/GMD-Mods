-- Источник: https://forum.gm-donate.ru/t/keshbek/963

-- Добавляет метод ITEM:SetCashback(percent, instant)
-- Указание instant true сразу после покупки начислит игроку стоимость доната * percent
-- Без указания instant игрок получит кешбек в следующем месяце

-- Пример снизу файла

local ITEM = FindMetaTable("IGSItem")

-- процент 0.2 = 20%, 0.5 = 50%, мгновенный или в следующем месяце?
function ITEM:SetCashback(percent, instant)
	return self
		:SetMeta("cashback", percent)
		:SetMeta("cashback_instant", tobool(instant))
end

if SERVER then
	hook.Add("IGS.PlayerPurchasedItem", "cashback", function(ply, item)
		local perc = item:GetMeta("cashback")
		if (perc or 0) <= 0 then return end

		if item:GetMeta("cashback_instant") then
			local cutoff = math.floor(item.price * perc)
			ply:AddIGSFunds(cutoff, "Cashback ".. cutoff .." - ".. (perc * 100) .."%")

			IGS.Notify(ply, "Спасибо за покупку! Вы получили +".. PL_MONEY(cutoff) .." кэшбэка!")
		else
			local summ = math.floor(ITEM.price * perc)
			local total = bib.incr(pl, "igs_cashback_".. tonumber(os.date("%m")) .."_".. ply:SteamID64(), summ)

			IGS.Notify(ply, "Спасибо за покупку! В следующем месяце вы получите +".. PL_MONEY(total) .." кэшбэка!")
		end
	end)

	hook.Add("IGS.PlayerPurchasesLoaded", "cashback", function(ply)
		local uid = "igs_cashback_".. (tonumber(os.date("%m")) - 1) .."_".. ply:SteamID64()
		local cashback = bib.getNum(ply, uid)
		if not cashback then return end

		bib.delete(uid)
		ply:AddIGSFunds(cashback, "Monthly Cashback")
		IGS.Notify(ply, "Вы получили ".. PL_MONEY(cashback) .." кэшбэка за вашу поддержку в прошлом месяце, наслаждайтесь!")
	end)
end



--[[ пример создания предмета с кэшбэком

IGS("VIP на месяц", "vip_na_mesyac", 150)
	:SetULXGroup("vip")
	:SetTerm(30) -- 30 дней
	:SetCategory("Группы")
	:SetDescription("С этой покупкой вы станете всемогущим")
	:SetCashback(0.3) -- 30%, накопленная сумма кэшбэка выдаст в следующем месяце
	--:SetCashback(0.25, true) -- 25%, мгновенный кэшбэк

]]
