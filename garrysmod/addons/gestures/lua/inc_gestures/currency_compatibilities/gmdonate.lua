-- https://gm-donate.ru/

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