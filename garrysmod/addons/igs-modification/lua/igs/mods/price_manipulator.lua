-- from incredible-gmod.ru with <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/price_manipulator.lua
-- источник: https://forum.gm-donate.net/t/kak-sdelat-skidku-na-moder-esli-u-igroka-vip/1441/8

local IGSItem = FindMetaTable("IGSItem")

local price = {price = true}
function IGSItem:__index(key)
	if price[key] then
		return self:Price()
	else
		return rawget(self, key)
	end
end

function IGSItem:Price()
	local newPrice = hook.Run("IGS.ManipulateItemPrice", LocalPlayer(), self)
	if newPrice then
		return newPrice
	end

	return self.price
end

if SERVER then -- патчит серверсайд код который обрабатывает покупку предмета (без патча ни как, this is the only way)
	local patch = file.Read("igs/network/net_sv.lua", "LUA")
	patch = patch:sub(1, (patch:find("local function IGS_Activate", 1, true))):gsub("local curr_price = ITEM:PriceInCurrency()", [[
	local curr_price = ITEM:PriceInCurrency()
	local newPrice = hook.Run("IGS.ManipulateItemPrice", pl, ITEM)
	if newPrice then
		curr_price = newPrice
	end
	]])
	RunString(patch, "https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/price_manipulator.lua")	
end

-- примеры использования:


-- 1. делает скидку на покупку модера если куплен вип и тд

local sales = {
	moder = "vip", -- если куплен вип, даётся скидка на покупку модера (цена випки)
	admin = {"vip", "moder"} -- если куплен вип или модер, даётся скидка на покупку админки
}

for uid, items in ipairs(sales) do
	if istable(items) then
		table.sort(items, function(a, b)
			return IGS.GetItem(a):Price() > IGS.GetItem(b):Price()
		end)
	end
end

hook.Add("IGS.ManipulateItemPrice", "https://forum.gm-donate.net/t/kak-sdelat-skidku-na-moder-esli-u-igroka-vip/1441/8", function(ply, item)
	if sales[item.uid] then
		if istable(sales[item.uid]) then
			for _, uid in ipairs(sales[item.uid]) do
				if ply:HasPurchase(uid) then
					return item.price - IGS.GetItem(sales[item.uid]):Price()
				end
			end
		elseif ply:HasPurchase(sales[item.uid]) then
			return item.price - IGS.GetItem(sales[item.uid]):Price()
		end
	end
end)

-- 2. Скидка на первую покупку (для игроков ещё ни разу не покупавших донат действует скидка на все предметы) https://s3.forum.gm-donate.net/original/2X/d/dc02ed1ab774eac9bd11ea77560953919063de58.jpeg
local firstPurchaseSale = 0.8

hook.Add("IGS.ManipulateItemPrice", "https://forum.gm-donate.net/t/kak-sdelat-skidku-na-moder-esli-u-igroka-vip/1441/11", function(ply, item)
	if table.Count(IGS.PlayerPurchases(ply)) == 0 then
		return item.price * (1 - firstPurchaseSale)
	end
end)
