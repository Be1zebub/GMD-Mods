-- from incredible-gmod.ru with <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/modern_car_dealer.lua
-- источник: https://forum.gm-donate.net/t/donat-mashiny/1232
-- аддон: https://www.gmodstore.com/market/view/modern-car-dealer-showcases-mechanic-underglow-easily-configurable

IGS("Корыто", "lada")
:SetPrice(1)
:SetIcon("models/props_vehicles/car005a_physics.mdl", true)
:SetOnActivate(function(ply)
    RunConsoleCommand("mcd_givecar", ply:SteamID64(), "Car Dealer", "lada_sedan")
end)
