-- from incredible-gmod.ru with love <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/battlepass/challenges/gmdonate.lua

local CHALLENGE = BATTLEPASS:CreateTemplateChallenge()
CHALLENGE:SetName("Покупайте донат")
CHALLENGE:SetDesc("")
CHALLENGE:SetProgressDesc("Купите ещё :goal донат-услуг")
CHALLENGE:SetFinishedDesc("Купленно :goal донат-услуг")
CHALLENGE:SetID("igs_purchases")
CHALLENGE:AddHook("IGS.PlayerPurchasedItem", function(self, ply, _ply)
	if IsValid(ply) and IsValid(_ply) and ply == _ply then
		self:AddProgress(1)
		self:NetworkProgress()
	end
end)

BATTLEPASS:RegisterChallenge(CHALLENGE)
