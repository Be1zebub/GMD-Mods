-- from incredible-gmod.ru with love <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/inc_gestures/currency_compatibilities/gmdonate.lua
-- интеграция валюты https://gm-donate.ru/ в аддон https://www.gmodstore.com/market/view/gestures

function INC_GESTURES:TakeMoney(ply, num)
	ply:AddIGSFunds(-num, "Buying a gesture gmod.store/market/view/gestures")
end

function INC_GESTURES:CanAfford(ply, num)
	return IGS.CanAfford(ply, num)
end

function INC_GESTURES:FormatMoney(num)
	return PL_IGS(num)
end

function INC_GESTURES:AddMoney(ply, num)
	ply:AddIGSFunds(num, "Refund a gesture gmod.store/market/view/gestures")
end