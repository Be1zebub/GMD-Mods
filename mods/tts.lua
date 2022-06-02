-- from incredible-gmod.ru with <3
-- https://github.com/Be1zebub/GMD-Mods/blob/master/mods/tts.lua

local voice = "alyss" -- список голосов: https://cloud.yandex.ru/docs/speechkit/tts/voices
local maxDist = 1024 -- макс дистацния на которой будет слышно говорилку

IGS("Говорилка", "tts")
:SetPrice(100)
:SetNetworked(true)
:SetDescription("Озвучивает текст который вы пишите в чате. Удобно для людей у которых нет микрофона.")

if SERVER then
	local function net_WritePlayer(ply)
		if IsValid(ply) then
			net.WriteUInt(ply:EntIndex(), 7)
		else
			net.WriteUInt(0, 7)
		end
	end

	util.AddNetworkString("https://github.com/Be1zebub/GMD-Mods/blob/master/mods/tts.lua")

	local function tts(ply, text)
		if ply:Alive() and ply:HasPurchase("tts") then
			net.Start("https://github.com/Be1zebub/GMD-Mods/blob/master/mods/tts.lua")
				net_WritePlayer(ply)
				net.WriteString(text)
			net.Broadcast()
		end
	end

	hook.Add("PostGamemodeLoaded", "https://github.com/Be1zebub/GMD-Mods/blob/master/mods/tts.lua", function()
		if DarkRP then
			hook.Add("PostPlayerSay", "https://github.com/Be1zebub/GMD-Mods/blob/master/mods/tts.lua", tts)
		else
			hook.Add("PlayerSay", "https://github.com/Be1zebub/GMD-Mods/blob/master/mods/tts.lua", tts)
		end
	end)
else
	local api = "https://tts.voicetech.yandex.net/tts?speaker=".. voice .."&text="

	local function http_encode(str) -- https://github.com/Be1zebub/Small-GLua-Things/blob/master/httputils.lua#L8
		return (str:gsub("[^%w _~%.%-]", function(char)
			return format("%%%02X", char:byte())
		end):gsub(" ", "+"))
	end

	local function net_ReadPlayer()
		local index = net.ReadUInt(7)
		if index then
			return Entity(index)
		end
	end

	local stations = {}

	net.Receive("https://github.com/Be1zebub/GMD-Mods/blob/master/mods/tts.lua", function()
		local ply  = net_ReadPlayer()
		if LocalPlayer():GetPos():Distance(ply:GetPos()) > maxDist then return end

		sound.PlayURL(api .. http_encode(net.ReadString()), "3d", function(soundchannel)
			if IsValid(soundchannel) and IsValid(ply) then
				soundchannel:SetPos(ply:GetPos())
				soundchannel:Set3DFadeDistance(200, maxDist)
				soundchannel:SetVolume(1)
				soundchannel:Play()

				table.insert(stations, {
					chan = soundchannel,
					owner = ply
				})
			end
		end)
	end)

	local station
	hook.Add("Think", "https://github.com/Be1zebub/GMD-Mods/blob/master/mods/tts.lua", function()
		for i = #stations, 1, -1 do
			station = stations[i]

			if IsValid(station.chan) then
				station.chan:SetPos(station.owner:GetPos())
			else
				table.remove(stations, i)
			end
		end
	end)
end
