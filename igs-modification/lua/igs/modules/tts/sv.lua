-- дистацния на которой будет слышно говорилку
local maxDist = 1024

local function Filter(f, xs)
	local res = {}
	for k,v in pairs(xs) do
		if f(v) then res[k] = v end
	end
	return res
end

util.AddNetworkString("igs_tts")

local function tts(ply, text)
	if ply:Alive() and ply:HasPurchase("tts") then
		net.Start("igs_tts")
			net.WriteEntity(ply)
			net.WriteString(text)
		net.Send( Filter(function(targ)
			return ply:GetPos():Distance(targ:GetPos()) <= maxDist
		end, player.GetAll()) )
	end
end

hook.Add("PostGamemodeLoaded", "igs_tts", function()
	hook.Add(DarkRP and "PostPlayerSay" or "PlayerSay", "igs_tts", tts)
end)
