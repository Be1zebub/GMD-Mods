-- from incredible-gmod.ru with <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/xenin_battlepass.lua
-- источник: https://forum.gm-donate.net/t/vydacha-urovnej-v-boevoj-propusk-cherez-donat/1260
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