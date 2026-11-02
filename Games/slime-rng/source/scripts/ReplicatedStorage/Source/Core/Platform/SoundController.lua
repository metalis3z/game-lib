-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SoundController, time of decompilation: Sun May  3 10:10:54 2026 ]]
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local SettingsState = require(ReplicatedStorage.Source.Features.Settings.SettingsState)
local t1 = {}
local t2 = {}
local t3 = {
	SettingsKey = true
}

function t1.Load(_: {[any]: any}, t5: {[any]: any}) -- line: 49
	-- upvalues: t2 (copy), t3 (copy), SoundService (copy)
	if t2[t5.SoundId] then
		return
	end

	local Sound = Instance.new("Sound")

	Sound.PlaybackRegionsEnabled = t5.LoopRegion ~= nil or t5.PlaybackRegion ~= nil

	for v21, v22 in t5 do
		if not t3[v21] then
			Sound[v21] = v22
		end
	end

	Sound.Parent = SoundService
	t2[t5.SoundId] = Sound
end
function t1.ApplySoundInfo(_: {[any]: any}, p1, t7: {[any]: any}) -- line: 57
	-- upvalues: t3 (copy)
	p1.PlaybackRegionsEnabled = t7.LoopRegion ~= nil or t7.PlaybackRegion ~= nil

	for v26, v27 in t7 do
		if not t3[v26] then
			p1[v26] = v27
		end
	end
end
function t1.GetSound(_: {[any]: any}, p2, p3) -- line: 61
	-- upvalues: t2 (copy), t3 (copy), SoundService (copy)
	local v31 = t2[p2.SoundId]

	if not v31 then
		v31 = Instance.new("Sound")
		v31.PlaybackRegionsEnabled = p2.LoopRegion ~= nil or p2.PlaybackRegion ~= nil

		for v32, v33 in p2 do
			if not t3[v32] then
				v31[v32] = v33
			end
		end

		v31.Parent = p3 or SoundService
		t2[p2.SoundId] = v31
	end

	v31.PlaybackRegionsEnabled = p2.LoopRegion ~= nil or p2.PlaybackRegion ~= nil

	for v34, v35 in p2 do
		if not t3[v34] then
			v31[v34] = v35
		end
	end

	return v31
end
function t1.Play(p4, p5) -- line: 67
	-- upvalues: RunService (copy), t3 (copy), SettingsState (copy)
	if not RunService:IsRunning() then
		return
	end

	local Sound = p4:GetSound(p5)

	Sound.PlaybackRegionsEnabled = p5.LoopRegion ~= nil or p5.PlaybackRegion ~= nil

	for v39, v40 in p5 do
		if not t3[v39] then
			Sound[v39] = v40
		end
	end

	if p5.SettingsKey ~= nil and not SettingsState.get(p5.SettingsKey) then
		return
	end

	Sound:Play()
end

return t1
