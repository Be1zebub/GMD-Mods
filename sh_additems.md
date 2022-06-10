# Примеры особых итемов

Примеры, которые можно добавлять прямо в `sh_additems.lua`


## Разноцветный физган

Цвет вашего физгана будет красочным. Видите только вы

Подробнее: https://forum.gm-donate.ru/t/raznoczvetnyj-fizgan-v-donat-menyu/34/5

```lua
local item_uid = "rainbowphysgun"

IGS("Разноцветный физган", item_uid, 150)
	:SetTerm(30)
	:SetNetworked(true)

if CLIENT then
	local div = 255 / 1
	local col, vec_col

	hook.Add("Think", "igs_rainbow_physgun", function()
		col = HSVToColor(CurTime() % 360, 1, 1)
		vec_col = Vector(col.r * div, col.g * div, col.b * div)

		for _, ply in ipairs(player.GetHumans()) do
			if ply:HasPurchase(item_uid) then
				ply:SetWeaponColor(vec_col)
			end
		end
	end)
end
```

## Скорость бега

Каждая покупка предмета увеличит максимальную скорость игрока

Подробнее: https://forum.gm-donate.ru/t/donat-na-skorost/984/2

```lua
IGS("+50 к скорости бега", "movespeed", 150)
	:SetDescription("Добавляет +50 к скорости бега. При покупке 2 штук, будет +100, 3 шт = +150")
	:SetStackable(true)
	:SetMaxPlayerPurchases(3) -- максимум 3 раза
	:SetPerma() -- навсегда
	:AddHook("PlayerLoadout", function(ply)
		local count = ply:HasPurchase("movespeed")
		timer.Simple(3, function()
			if IsValid(ply) then
				ply:SetRunSpeed(ply:GetRunSpeed() + count * 50)
			end
		end)
	end)
```

## Авто unjail (ULX)

Подробнее: https://forum.gm-donate.ru/t/item-dlya-platnogo-unjail-vyjti-iz-dzhajla/899/2

```lua
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
```

## WireMod

### Весь вайр

Подробнее: https://forum.gm-donate.ru/t/kak-sdelat-prodazhu-dostupa-k-wire/1225/2


```lua
IGS("Доступ к Wire-mod", "igs_wiremod")
	:SetPrice(160)
	:SetTerm(30)
	:SetNetworked(true)

hook.Add("CanTool", "igs_wire_access", function(ply, _, toolname) -- запрещает использование инструмента
	if toolname:StartWith("wire_") and not ply:HasPurchase("igs_wiremod") then
		return false
	end
end)

if CLIENT then
	cvars.AddChangeCallback("gmod_toolmode", function(name, old, new) -- выводит уведомление при экипировке инструмента, если у игрока не куплен доступ
		if LocalPlayer():HasPurchase("igs_wiremod") or old == new or new:StartWith("wire_") == false then return end

		notification.AddLegacy("Wire-mod доступен только по подписке! Нажмите F6 что-бы ознакомиться с предложением.", NOTIFY_ERROR, 3)
	end, "igs_wire_access")
end
```

### E2P

Подробнее: https://forum.gm-donate.ru/t/kak-dobavit-v-prodazhu-e2p/856/4

```lua
-- продажа доступа к Expression 2
IGS("Доступ к E2", "wire_e2")
	:SetPrice(500)
	:SetTerm(30)
	:SetValidator(function() return false end) -- после каждого перезахода выполняет функцию из SetInstaller, пока предмет активный
	:SetInstaller(function(ply)
		RunConsoleCommand("e2power_give_access", ply:EntIndex())
	end)
```


## [Modern Car Dealer](https://www.gmodstore.com/market/view/modern-car-dealer-showcases-mechanic-underglow-easily-configurable)

Добавляет в инвентарь кардилера машину

Подробнее: https://forum.gm-donate.ru/t/donat-mashiny/1232

```lua
IGS("Корыто", "lada", 123)
	:SetDescription("Вы получите Ладу в инвентарь кардилера")
	:SetIcon("models/props_vehicles/car005a_physics.mdl", true)
	:SetOnActivate(function(ply)
		RunConsoleCommand("mcd_givecar", ply:SteamID64(), "Car Dealer", "lada_sedan")
	end)
```

## [Outfitter](https://steamcommunity.com/sharedfiles/filedetails/?id=882463775)

Разрешает доступ к смене модельки

Подробнее: https://forum.gm-donate.ru/t/kak-zapretit-ispolzovat-outfitter-igrokam/1265

```lua
IGS("Доступ к Outfitter", "outfitter", 500)
	:SetTerm(30) -- 30 дней
	:SetNetworked(true)

hook.Add("CanOutfit", "igs_access", function(ply)
	if not ply:HasPurchase("outfitter") then
		return false
	end
end)
```

## Бонус к зарплате (DarkRP)

Каждая покупка увеличивает ЗП на 10%

Подробнее: https://forum.gm-donate.ru/t/kak-sdelat-uvelichenie-zarplaty/1218/7

```lua
IGS("+10% к ЗП", "added_salary", 100)
	:SetPerma() -- навсегда
	:SetStackable()
	:SetCategory("Плюшки")
	:SetDescription("Каждая покупка сделает вашу ЗП на 10% больше")
	:SetMaxPlayerPurchases(3) -- максимум покупок. 3 = максимум +30% к зарплате

if SERVER then
	hook.Add("playerGetSalary", "igs_salary", function(ply, salary)
		if not ply:getDarkRPVar("AFK") and ply:HasPurchase("added_salary") then
			return false, false, salary * (1 + ply:HasPurchase("added_salary") * 0.1)
		end
	end)
end
```
