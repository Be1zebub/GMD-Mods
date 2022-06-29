-- from incredible-gmod.ru with <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/ch_cryptocurrencies/shared/currencies/igs.lua
-- источник: https://forum.gm-donate.net/t/cryptos-igs/1461/5
-- добавляет валюту https://gm-donate.net/ в аддон https://www.gmodstore.com/market/view/cryptos

CH_CryptoCurrencies.Currencies["igsfunds"] = {
	Name = "IGS Rub",
	AddMoney = function(ply, amount)
		ply:AddIGSFunds(amount)
	end,
	TakeMoney = function(ply, amount)
		ply:AddIGSFunds(-amount)
	end,
	GetMoney = function(ply)
		return ply:IGSFunds() or 0
	end,
	CanAfford = function(ply, amount)
		return IGS.CanAfford(ply, amount)
	end,
	FormatMoney = function(amount)
		return PL_IGS(amount)
	end,
	CurrencyAbbreviation = function()
		return IGS.C.CURRENCY_SIGN
	end,
}