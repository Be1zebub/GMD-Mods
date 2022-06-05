-- from incredible-gmod.ru with <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/mods/xenin_battlepass.lua
-- источник: https://forum.gm-donate.ru/t/vydacha-urovnej-v-boevoj-propusk-cherez-donat/1260
-- аддон: https://www.gmodstore.com/market/view/xenin-battle-pass

IGS("+1 к уровню battlepass", "battlepass+1")
:SetDescription("Добавляет +1 к уровню battlepass. При покупке 2 штук, будет +2 уровня, 3 шт = +3 уровня")
:SetStackable(true)
:SetPrice(25)
:SetOnActivate(function(ply)
    RunConsoleCommand("battlepass_give_tier", ply:SteamID64(), "Car Dealer", "lada_sedan")
end)
