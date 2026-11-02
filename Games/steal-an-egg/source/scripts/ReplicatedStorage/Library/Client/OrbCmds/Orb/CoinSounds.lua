-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Library = ReplicatedStorage:WaitForChild("Library")
local Audio = require(Library.Audio)
local Directory = require(ReplicatedStorage.Directory.Currency).Directory
local t = {}
local t2 = { 0.95, 1.05 }
local t3 = {}

function t.Queue(p1, p2) --[[ Queue | Line: 22 | Upvalues: t3 (ref) ]]
	local v1 = t3[p1] or {
		Count = 0,
		LootTierIndex = p2
	}

	v1.Count = v1.Count + 1
	t3[p1] = v1
end
RunService.Heartbeat:Connect(function() --[[ Line: 32 | Upvalues: t3 (ref), Directory (copy), Audio (copy), t2 (copy) ]]
	local v1 = t3

	if not next(v1) then
		return
	end

	t3 = {}

	for k, v in pairs(v1) do
		local Sounds = Directory[k].Sounds
		local v2 = v.Count >= 2 and Sounds.Multi or Sounds.Single
		local v3 = v2.Data or {}

		Audio.Play(v2.Ids, script, v3.Speed or t2, v3.Volume or 0.5)
	end
end)

return t