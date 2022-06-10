-- При покупке любого предмета игроку будет выдан предмет с указанным ниже uid
-- Подробнее: https://forum.gm-donate.ru/t/vydacha-privilegii-za-pokupku-lyubogo-tovara/961/2

-- uid предмета с sh_additems, который будет выдан в качестве бонуса
local item_uid = "vip4all"
local notify = "Поздравляю с первой покупкой! В качестве награды за поддержку сервера мы дарим вам бесплатную VIP привелегию, пользуйтесь на здоровье."

hook.Add("IGS.PlayerPurchasedItem", "1st_purchase_bonus", function(ply)
	local cname = "igs_bonus_received:" .. ply:SteamID64()

	local receive_time = cookie.GetNumber(cname)
	if receive_time then return end

	cookie.Set(cname, os.time())

	IGS.AddToInventory(ply, item_uid)
	-- IGS.PlayerActivateItem(ply, item_uid) -- чтобы активировать сразу без помещения в инвентарь

	IGS.Notify(ply, notify)
end)
