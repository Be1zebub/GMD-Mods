-- from incredible-gmod.ru with <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/unjail.lua
-- источник: https://forum.gm-donate.ru/t/item-dlya-platnogo-unjail-vyjti-iz-dzhajla/899/2

IGS("Побег из jail", "unjail")
:SetPrice(100)
:SetDescription("Админ наказал вас и поставил в угол?\nС помощью этой услуги вы можете сбежать из jail.\nТеперь правила сервера не являются помехой для вас :D")
:SetCanActivate(function(ply)
    if not ply.jail then
        return "Вы сейчас не в jail! Зачем вам активировать этот предмет прямо сейчас?"
    end
end)
:SetOnActivate(function(ply)
    RunConsoleCommand("ulx", "jail", ply:SteamID(), "1", "true") -- если у вас ulx, для других админок нужно немного поменять команду
end)
