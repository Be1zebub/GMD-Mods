-- from incredible-gmod.ru with <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/donate_models.lua
-- источник: https://forum.gm-donate.net/t/prodazha-donat-modelej/1003/6

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
	local item
	hook.Add("PlayerSetModel", "https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/donate_models.lua", function(ply)
		for uid in pairs(IGS.PlayerPurchases(ply)) do
			item = IGS.GetItem(uid)
			if item.PlayerModel == nil then continue end

			if item.ModelTeamWhitelist == nil or item.ModelTeamWhitelist[ply:Team()] then
				ply:SetModel(item.PlayerModel)
				return true -- блокируем GM: хук
			end
		end
	end)
end

IGS("Gorgeous Freeman", "custom_model")
:SetDescription("https://forum.gm-donate.net/t/sozdanie-privyazki-modeli-na-vse-profesii-darkrp/1003/5")
:SetCategory("Разное")
:SetPrice(300)
:SetPerma()
:SetPlayerModel("models/AntoineDelak/playermodels/Gorgeous_Freeman_Underwear_PM.mdl", TEAM_CITIZEN, TEAM_GANG) -- модель и список профессий которым доступна эта модель
-- :SetPlayerModel("models/AntoineDelak/playermodels/Gorgeous_Freeman_Underwear_PM.mdl") -- если указать только модель, то она будет доступна всем профессиям
