-- Метод ITEM:SetPlayerModel(path, ...)
-- После покупки предмета у игрока при каждом респавне будет изменяться модель игрока

-- Источник: https://forum.gm-donate.ru/t/prodazha-donat-modelej/1003/6

local ITEM = FindMetaTable("IGSItem")

function ITEM:SetPlayerModel(path, ...)
	self.PlayerModel = path

	if ... then
		local whitelist = {}
		for _, team in ipairs({...}) do
			whitelist[team] = true
		end
		self.ModelTeamWhitelist = whitelist
	end

	return self
end

if SERVER then
	hook.Add("PlayerLoadout", "", function(ply)
		timer.Simple(3, function()
			if IsValid(ply) == false then return end

			for _, item in pairs(IGS.PlayerPurchases(ply)) do
				if item.PlayerModel == nil then continue end

				if item.ModelTeamWhitelist == nil or item.ModelTeamWhitelist[ply:Team()] then
					ply:SetModel(item.PlayerModel)
					break
				end
			end
		end)
	end)
end


--[[ пример создания предмета с кэшбэком

IGS("Gorgeous Freeman", "custom_model", 300)
	:SetDescription("Вы будете спавниться с моделькой Гордона Фримена")
	:SetPerma() -- навсегда
	:SetPlayerModel("models/AntoineDelak/playermodels/Gorgeous_Freeman_Underwear_PM.mdl", TEAM_CITIZEN, TEAM_GANG) -- модель и список профессий которым доступна эта модель
	-- :SetPlayerModel("models/AntoineDelak/playermodels/Gorgeous_Freeman_Underwear_PM.mdl") -- если указать только модель, то она будет доступна всем профессиям

]]


