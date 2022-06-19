-- from incredible-gmod.ru with <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/garrysmod/addons/igs-modification/lua/mods/price_manipulator.lua
-- источник: https://forum.gm-donate.net/t/kak-sdelat-skidku-na-moder-esli-u-igroka-vip/1441/8

local STORE_ITEM = FindMetaTable("IGSItem")

function STORE_ITEM:Price()
	local newPrice = hook.Run("IGS.ManipulateItemPrice", ply, self)
	if newPrice then
		return newPrice
	end

	return self.price
end

-- пример использования:
-- делает скидку на покупку модера если куплен вип и тд

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
