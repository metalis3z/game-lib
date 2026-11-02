-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Library.Audio)
local t = {}

local function getScaleMultiplier(p1, p2, p3) --[[ getScaleMultiplier | Line: 23 ]]
	local v1 = 1
	local v2 = if p3 then p3.weight else nil
	local v3 = if p3 then p3.baseWeight else nil

	if p2 == "WalkSound" and (typeof(v2) == "number" and (typeof(v3) == "number" and v3 > 0)) then
		return math.max(v2 / v3, 0.001)
	end

	if p3 and typeof(p3.baseModelScale) == "number" then
		v1 = p3.baseModelScale
	end

	if v1 <= 0 then
		v1 = 1
	end

	return math.max(p1:GetScale() / v1, 0.001)
end

local function applyScaledProperty(p1, p2, p3, p4) --[[ applyScaledProperty | Line: 45 ]]
	if typeof(p1) == "number" then
		return p1 * math.clamp(p2, p3, p4)
	end

	return nil
end

local function parseMutationsAttribute(p1) --[[ parseMutationsAttribute | Line: 59 ]]
	local t = {}

	if typeof(p1) ~= "string" or p1 == "" then
		return t
	end

	for v1 in string.gmatch(p1, "[^,]+") do
		local v2 = v1:gsub("^%s*(.-)%s*$", "%1")

		if v2 ~= "" then
			table.insert(t, v2)
		end
	end

	return t
end

local function ensureFrozenSoundEffect(p1, p2) --[[ ensureFrozenSoundEffect | Line: 75 ]]
	local FrozenMutationReverb = p1:FindFirstChild("FrozenMutationReverb")

	if p2 then
		if FrozenMutationReverb and FrozenMutationReverb:IsA("ReverbSoundEffect") then
			return
		end

		local FrozenMutationReverb2

		if not FrozenMutationReverb then
			FrozenMutationReverb2 = Instance.new("ReverbSoundEffect")
			FrozenMutationReverb2.Name = "FrozenMutationReverb"
			FrozenMutationReverb2.Parent = p1

			return
		end

		FrozenMutationReverb:Destroy()
		FrozenMutationReverb2 = Instance.new("ReverbSoundEffect")
		FrozenMutationReverb2.Name = "FrozenMutationReverb"
		FrozenMutationReverb2.Parent = p1
	else
		if not FrozenMutationReverb then
			return
		end

		FrozenMutationReverb:Destroy()
	end
end

local function hasMutation(p1, p2, p3) --[[ hasMutation | Line: 97 ]]
	if p2 == p3 then
		return true
	end

	if typeof(p1) ~= "table" then
		return false
	end

	return table.find(p1, p3) ~= nil
end

local function getStoredBasePlaybackSpeed(p1) --[[ getStoredBasePlaybackSpeed | Line: 109 ]]
	local v1 = p1:GetAttribute("AssetSoundUtilBasePlaybackSpeed")

	if typeof(v1) == "number" and v1 > 0 then
		return v1
	end

	local PlaybackSpeed = p1.PlaybackSpeed

	if PlaybackSpeed <= 0 then
		PlaybackSpeed = 1
	end

	p1:SetAttribute("AssetSoundUtilBasePlaybackSpeed", PlaybackSpeed)

	return PlaybackSpeed
end

local function getMutationPlaybackSpeedMultiplier(p1, p2) --[[ getMutationPlaybackSpeedMultiplier | Line: 124 ]]
	if if p2 == "Shocked" then true elseif typeof(p1) == "table" then table.find(p1, "Shocked") ~= nil else false then
		return 2
	end

	return 1
end

local function multiplyPlaybackSpeed(p1, p2) --[[ multiplyPlaybackSpeed | Line: 132 ]]
	if type(p1) == "number" then
		return p1 * p2
	end

	if type(p1) ~= "table" then
		return p2
	end

	local v1 = table.clone(p1)

	for i, v in ipairs(p1) do
		v1[i] = v * p2
	end

	return v1
end

local function syncMutationPlaybackSpeed(p1, p2, p3) --[[ syncMutationPlaybackSpeed | Line: 148 ]]
	local v1 = p1:GetAttribute("AssetSoundUtilBasePlaybackSpeed")
	local v2

	if typeof(v1) == "number" and v1 > 0 then
		v2 = v1
	else
		local PlaybackSpeed = p1.PlaybackSpeed

		if PlaybackSpeed <= 0 then
			PlaybackSpeed = 1
		end

		p1:SetAttribute("AssetSoundUtilBasePlaybackSpeed", PlaybackSpeed)
		v2 = PlaybackSpeed
	end

	local v5 = v2 * (if if p3 == "Shocked" then true elseif typeof(p2) == "table" then if table.find(p2, "Shocked") == nil then false else true else false then 2 else 1)

	if not (math.abs(p1.PlaybackSpeed - v5) > 0.001) then
		return
	end

	p1.PlaybackSpeed = v5
end

function t.CreateConfiguredSound(p1, p2, p3, p4, p5) --[[ CreateConfiguredSound | Line: 156 | Upvalues: Audio (copy), getScaleMultiplier (copy) ]]
	if not p3 then
		return nil
	end

	local Sound = Instance.new("Sound")

	Sound.Name = p4
	Audio.PrepareSoundFromSoundFile(Sound, p3)
	Sound.RollOffMaxDistance = 40

	local v1 = getScaleMultiplier(p2, p4, p5)
	local Volume = Sound.Volume

	if Volume > 0 then
		local v4 = if typeof(Volume) == "number" then Volume * math.clamp(v1, 1, if p4 == "WalkSound" then 3.5 else 3) else nil

		if v4 then
			Sound.Volume = v4
		end
	end

	local RollOffMaxDistance = Sound.RollOffMaxDistance

	if typeof(RollOffMaxDistance) == "number" and RollOffMaxDistance > 0 then
		local v7 = if typeof(RollOffMaxDistance) == "number" then RollOffMaxDistance * math.clamp(v1, 0.7, 1.2) else nil

		if v7 then
			Sound.RollOffMaxDistance = v7
		end
	end

	Sound.Parent = p1

	return Sound
end
function t.ParseMutationsAttribute(p1) --[[ ParseMutationsAttribute | Line: 201 | Upvalues: parseMutationsAttribute (copy) ]]
	return parseMutationsAttribute(p1)
end
function t.GetMutationStateFromAttributes(p1, p2, p3) --[[ GetMutationStateFromAttributes | Line: 205 | Upvalues: parseMutationsAttribute (copy) ]]
	local v1 = parseMutationsAttribute(p1:GetAttribute(p2 or "Mutations"))
	local v2 = p1:GetAttribute(p3 or "BaseMutation")

	return v1, if typeof(v2) == "string" and v2 ~= "" then v2 else nil
end
function t.HasFrozenMutation(p1, p2) --[[ HasFrozenMutation | Line: 221 ]]
	if p2 == "Frozen" then
		return true
	end

	if typeof(p1) ~= "table" then
		return false
	end

	return table.find(p1, "Frozen") ~= nil
end
function t.HasShockedMutation(p1, p2) --[[ HasShockedMutation | Line: 225 ]]
	if p2 == "Shocked" then
		return true
	end

	if typeof(p1) ~= "table" then
		return false
	end

	return table.find(p1, "Shocked") ~= nil
end
function t.GetMutationPlaybackSpeedMultiplier(p1, p2) --[[ GetMutationPlaybackSpeedMultiplier | Line: 229 ]]
	if if p2 == "Shocked" then true elseif typeof(p1) == "table" then table.find(p1, "Shocked") ~= nil else false then
		return 2
	end

	return 1
end
function t.SetBasePlaybackSpeed(p1, p2) --[[ SetBasePlaybackSpeed | Line: 233 ]]
	if not p1 then
		return
	end

	if typeof(p2) == "number" and not (p2 <= 0) then
		p1:SetAttribute("AssetSoundUtilBasePlaybackSpeed", p2)
	else
		p1:SetAttribute("AssetSoundUtilBasePlaybackSpeed", nil)
	end
end
function t.CloneSoundFileWithMutationPlaybackSpeed(p1, p2, p3) --[[ CloneSoundFileWithMutationPlaybackSpeed | Line: 246 | Upvalues: multiplyPlaybackSpeed (copy) ]]
	local v2 = if if p3 == "Shocked" then true elseif typeof(p2) == "table" then if table.find(p2, "Shocked") == nil then false else true else false then 2 else 1

	if v2 == 1 then
		return p1
	end

	local v3 = table.clone(p1)
	local v4 = if p1.Data then table.clone(p1.Data) else {}

	v4.Speed = multiplyPlaybackSpeed(v4.Speed, v2)
	v3.Data = v4

	return v3
end
function t.BuildPlaybackEffectChildren(p1, p2, p3) --[[ BuildPlaybackEffectChildren | Line: 263 | Upvalues: t (copy) ]]
	local v1 = if p1 then table.clone(p1) else {}

	if t.HasFrozenMutation(p2, p3) then
		local FrozenMutationReverb = Instance.new("ReverbSoundEffect")

		FrozenMutationReverb.Name = "FrozenMutationReverb"
		table.insert(v1, FrozenMutationReverb)
	end

	if #v1 == 0 then
		return p1
	end

	return v1
end
function t.ParentPlaybackEffectChildren(p1, p2) --[[ ParentPlaybackEffectChildren | Line: 283 ]]
	if not p1 then
		return nil
	end

	for i, v in ipairs(p1) do
		v.Parent = p2
	end

	return p1
end
function t.SyncPlaybackEffectsFromMutations(p1, p2, p3) --[[ SyncPlaybackEffectsFromMutations | Line: 295 | Upvalues: ensureFrozenSoundEffect (copy), t (copy) ]]
	if not p1 then
		return
	end

	ensureFrozenSoundEffect(p1, t.HasFrozenMutation(p2, p3))

	local v1 = p1:GetAttribute("AssetSoundUtilBasePlaybackSpeed")
	local v2

	if typeof(v1) == "number" and v1 > 0 then
		v2 = v1
	else
		local PlaybackSpeed = p1.PlaybackSpeed

		if PlaybackSpeed <= 0 then
			PlaybackSpeed = 1
		end

		p1:SetAttribute("AssetSoundUtilBasePlaybackSpeed", PlaybackSpeed)
		v2 = PlaybackSpeed
	end

	local v5 = v2 * (if if p3 == "Shocked" then true elseif typeof(p2) == "table" then if table.find(p2, "Shocked") == nil then false else true else false then 2 else 1)

	if not (math.abs(p1.PlaybackSpeed - v5) > 0.001) then
		return
	end

	p1.PlaybackSpeed = v5
end
function t.SyncPlaybackEffectsFromAttributes(p1, p2, p3, p4) --[[ SyncPlaybackEffectsFromAttributes | Line: 304 | Upvalues: t (copy) ]]
	local v1, v2 = t.GetMutationStateFromAttributes(p2, p3, p4)

	t.SyncPlaybackEffectsFromMutations(p1, v1, v2)
end
function t.PlayWalkSound(p1) --[[ PlayWalkSound | Line: 315 ]]
	if not p1 then
		return
	end

	if not p1.IsPlaying then
		p1.TimePosition = 0
		p1.Looped = true
		p1:Play()
	end
end
function t.StopWalkSound(p1) --[[ StopWalkSound | Line: 327 ]]
	if not p1 then
		return
	end

	if p1.IsPlaying then
		p1:Stop()
	end
end
function t.PlayJumpSound(p1) --[[ PlayJumpSound | Line: 337 ]]
	if p1 then
		p1.TimePosition = 0
		p1.Looped = false
		p1:Play()
	end
end

return t