-- from incredible-gmod.ru with <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/pointshop.lua

local ITEM = FindMetaTable("IGSItem")

function ITEM:SetPointshop1Points(amount) -- https://github.com/adamdburton/pointshop
	self:SetOnActivate(function(ply)
	    ply:PS_GivePoints(amount)
	end)
end

function ITEM:SetPointshop2Points(amount, premium) -- https://github.com/Kamshak/Pointshop2
	self:SetOnActivate(function(ply)
	    ply[premium and "PS2_AddPremiumPoints" or "PS2_AddStandardPoints"](ply, amount)
	end)
end

function ITEM:SetSHPointshopPoints(amount, premium) -- https://www.gmodstore.com/market/view/sh-pointshop
	self:SetOnActivate(function(ply)
	    ply[premium and "SH_AddPremiumPoints" or "SH_AddStandardPoints"](ply, amount)
	end)
end