-- аддон: https://www.gmodstore.com/market/view/xenin-battle-pass
-- Управление батлпасом через IGS предметы

do
	IGS("+1 к уровню battlepass", "battlepass+1", 25)
		:SetDescription("Добавляет +1 к уровню battlepass. При покупке 2 штук, будет +2 уровня, 3 шт = +3 уровня")
		:SetStackable(true)
		:SetOnActivate(function(ply)
			RunConsoleCommand("battlepass_give_tier", ply:SteamID64(), "Car Dealer", "lada_sedan")
		end)
end

do
	IGS("Активация Battlepass", "battle", 25)
		:SetDescription("Активация battle")
		:SetOnActivate(function(pl) 
			RunConsoleCommand("battlepass_give_pass", pl:SteamID64()) -- выполнение команды от имени сервера
		end)
end



-- Ниже добавление в Battlepass предметов, связанных с IGS
-- Источник: https://forum.gm-donate.net/t/xenin-battlepass-igs/1293

do -- Активация донат предмета
	local REWARD = BATTLEPASS:CreateReward()
	REWARD.Mat = "battlepass/items.png"

	function REWARD:CanUnlock(ply, reward)
		return true
	end
	function REWARD:GetTooltip(reward)
		return "Предмет из  /donate"
	end

	function REWARD:GetModel()
		return self.Mat
	end

	function REWARD:GetName(reward)
		local ITEM = IGS.GetItemByUID(reward)
		return string.Comma(ITEM:Name())
	end

	function REWARD:Unlock(ply, reward)
		if CLIENT then return end
		IGS.PlayerActivateItem(ply, reward)
	end

	REWARD:Register("igsitem")
end

do -- Выдача донат валюты
	local REWARD = BATTLEPASS:CreateReward()
	REWARD.Mat = "battlepass/wallet_large.png"

	function REWARD:CanUnlock(ply, reward)
		return true
	end

	function REWARD:GetTooltip(reward)
		return string.Comma(reward) .. " тугрик" .. (reward != 1 and "ов" or "")
	end

	function REWARD:GetModel()
		return self.Mat
	end

	function REWARD:GetName(reward)
		return self:GetTooltip(reward)
	end

	function REWARD:Unlock(ply, reward)
		if (CLIENT) then return end
		ply:AddIGSFunds(reward, "Награда за BATTLEPASS")
	end

	REWARD:Register("igstug")
end
