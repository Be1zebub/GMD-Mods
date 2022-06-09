-- from incredible-gmod.ru with <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/pcasino.lua
-- источник: https://forum.gm-donate.net/t/pcasino-igs-xenin-battlepass/1313
-- аддон: https://www.gmodstore.com/market/view/pcasino-the-perfect-casino-addon-roulette-blackjack-slots-prize-wheel
-- автор: https://github.com/BazZziliuS

-- IGS валюта
PerfectCasino.Config.RewardsFunctions["igs_fund"] = function(ply, _, inputValue)
	ply:AddIGSFunds(inputValue, "Выигрыш в pcasino")
end

-- IGS предмет
PerfectCasino.Config.RewardsFunctions["igs_item"] = function(ply, _, inputValue)
	IGS.AddToInventory(ply, inputValue)
end

-- Xenin BattlePass уровень баттл-пасса
PerfectCasino.Config.RewardsFunctions["battlepasslvl"] = function(ply)
	RunConsoleCommand('battlepass_give_tier', ply:SteamID64(), '1')
end

-- Перевод
PerfectCasino.Translation.Rewards["igs_fund"] = "IGS Баланс"
PerfectCasino.Translation.Rewards["igs_item"] = "IGS Предмет"
PerfectCasino.Translation.Rewards["battlepasslvl"] = "BattlePass Уровень"