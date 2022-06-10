--------------------------------------------

-- список голосов: https://cloud.yandex.ru/docs/speechkit/tts/voices
local voice = "alyss"

--------------------------------------------

local api = "https://tts.voicetech.yandex.net/tts?speaker=".. voice .."&text="

local function http_encode(str) -- https://github.com/Be1zebub/Small-GLua-Things/blob/master/httputils.lua#L8
	return (str:gsub("[^%w _~%.%-]", function(char)
		return format("%%%02X", char:byte())
	end):gsub(" ", "+"))
end

local stations = {}

net.Receive("igs_tts", function()
	local ply  = net.ReadEntity()

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
hook.Add("Think", "igs_tts", function()
	for i = #stations, 1, -1 do
		station = stations[i]

		if IsValid(station.chan) then
			station.chan:SetPos(station.owner:GetPos())
		else
			table.remove(stations, i)
		end
	end
end)
