-- from incredible-gmod.ru with <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/xenin_battlepass.lua
-- источник: https://forum.gm-donate.ru/t/vydacha-urovnej-v-boevoj-propusk-cherez-donat/1260
-- аддон: https://www.gmodstore.com/market/view/xenin-battle-pass

-- Выдаёт игроку доступ к battlepass
IGS("Battlepass", "battlepass")
:SetDescription("Разблокировка Battlepass")
:SetPrice(100)
:SetOnActivate(function(pl)
	RunConsoleCommand("battlepass_give_pass", pl:SteamID64())
end)

-- Выдаёт игроку +1 уровень к battlepass
IGS("+1 к уровню Battlepass", "battlepass+1")
:SetDescription("Добавляет +1 к уровню Battlepass.\nПри покупке 2 штук, будет +2 уровня, 3 шт = +3 уровня")
:SetStackable(true)
:SetPrice(25)
:SetOnActivate(function(ply)
	RunConsoleCommand("battlepass_give_tier", ply:SteamID64(), "1")
end)

-- Добавление battlepass наград которые выдают IGS предметы/валюту
-- источник: https://forum.gm-donate.net/t/xenin-battlepass-igs/1293

-- Активация донат предмета
local ITEM_REWARD = BATTLEPASS:CreateReward()
ITEM_REWARD.Mat = "battlepass/items.png"

function ITEM_REWARD:CanUnlock()
	return true
end

function ITEM_REWARD:GetName(reward)
	return IGS.GetItemByUID(reward):Name()
end
ITEM_REWARD.GetTooltip = ITEM_REWARD.GetName

function ITEM_REWARD:GetModel()
	return self.Mat
end

function ITEM_REWARD:Unlock(ply, reward)
	if CLIENT then return end
	IGS.AddToInventory(ply, reward) -- добавляет предмет в инвентарь igs
	-- IGS.PlayerActivateItem(ply, reward) -- сразу активирует предмет
end

ITEM_REWARD:Register("igs-item")

-- Выдача донат валюты
local MONEY_REWARD = BATTLEPASS:CreateReward()
MONEY_REWARD.Mat = "battlepass/wallet_large.png"

function MONEY_REWARD:CanUnlock(ply, reward)
	return true
end

function MONEY_REWARD:GetName(reward)
	return PL_MONEY(reward)
end
MONEY_REWARD.GetTooltip = MONEY_REWARD.GetName

function MONEY_REWARD:GetModel()
	return self.Mat
end

function MONEY_REWARD:Unlock(ply, reward)
	if (CLIENT) then return end
	ply:AddIGSFunds(reward, "Награда за BATTLEPASS")
end

MONEY_REWARD:Register("igs-money")
