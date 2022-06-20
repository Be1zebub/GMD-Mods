-- from incredible-gmod.ru with love <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/battlepass/rewards/gmdonate.lua
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