-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local Library = ReplicatedStorage:WaitForChild("Library")
local AddDebris = require(Library.Functions.AddDebris)
local ParseAssetId = require(Library.Functions.ParseAssetId)
local Tween = require(Library.Functions.Tween)
local __DEBRIS = workspace:WaitForChild("__DEBRIS")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local InstanceCheck = require(ReplicatedStorage.Library.Functions.InstanceCheck)
local Interface = require(script.Types.Interface)
local v1, v2

if RunService:IsClient() then
	local Client = Library:WaitForChild("Client")

	v1 = require(Client.FFlags)
	v2 = require(Client.SettingsCmds)
else
	v1 = nil
	v2 = nil
end

local Music = script:WaitForChild("Music")
local v3 = RunService:IsClient()
local Sound = Instance.new("Sound")
local v4 = Random.new()
local t = {}

local function isInsideBox(p1, p2) --[[ isInsideBox | Line: 42 ]]
	return if p1.X >= -p2.X and (p1.X <= p2.X and (p1.Y >= -p2.Y and (p1.Y <= p2.Y and p1.Z >= -p2.Z))) then p1.Z <= p2.Z else false
end

local function addToGarbageCollection(p1, p2) --[[ addToGarbageCollection | Line: 51 | Upvalues: t (copy) ]]
	table.insert(t, { p1, p2 })
end

local function scanGarbageCollection() --[[ scanGarbageCollection | Line: 58 | Upvalues: t (copy), RunService (copy), AddDebris (copy) ]]
	for i = #t, 1, -1 do
		if i % 25 == 0 then
			RunService.Heartbeat:Wait()
		end

		local v1 = t[i]
		local v2 = v1[1]
		local v3 = v1[2]

		if not v2 or (not v2.Parent or (not v2.Playing or v2.SoundId == "")) then
			if v3 and (v2 and v2.Parent) then
				AddDebris(v2.Parent, 0)
			elseif v2 then
				AddDebris(v2, 0)
			end

			table.remove(t, i)
		end
	end
end

local t2 = {
	__types = Interface,
	ScheduleAndPlay = function(p1, p2, p3) --[[ ScheduleAndPlay | Line: 87 | Upvalues: Asserts (copy) ]]
		Asserts.Sound(p1)
		Asserts.optional.func(p2)
		Asserts.optional.Instance(p3)

		if p3 then
			p1.Parent = p3
		end

		task.spawn(function() --[[ Line: 96 | Upvalues: p1 (copy), p2 (copy) ]]
			local v1, v2, v3

			if p1.IsLoaded then
				v1 = nil
				v2 = nil
				v3 = function() --[[ stoppedOrEnded | Line: 104 | Upvalues: v1 (ref), v2 (ref), p2 (ref), p1 (ref) ]]
					if v1 then
						v1:Disconnect()
						v1 = nil
					end

					if v2 then
						v2:Disconnect()
						v2 = nil
					end

					if not (p2 and p2(p1)) then
						p1:Destroy()
					end
				end
				v1 = p1.Ended:Once(v3)
				v2 = p1.Stopped:Once(v3)
				p1:Play()

				return
			end

			p1.Loaded:Wait()
			v1 = nil
			v2 = nil
			v3 = function() --[[ stoppedOrEnded | Line: 104 | Upvalues: v1 (ref), v2 (ref), p2 (ref), p1 (ref) ]]
				if v1 then
					v1:Disconnect()
					v1 = nil
				end

				if v2 then
					v2:Disconnect()
					v2 = nil
				end

				if not (p2 and p2(p1)) then
					p1:Destroy()
				end
			end
			v1 = p1.Ended:Once(v3)
			v2 = p1.Stopped:Once(v3)
			p1:Play()
		end)

		return p1
	end
}

function t2.PlayFromSoundFile(p1, p2, p3) --[[ PlayFromSoundFile | Line: 128 | Upvalues: t2 (copy) ]]
	return t2.PlayFromFormattedParams(p1.SoundId, p2, p1.Data, p3)
end
function t2.PlayFromFormattedParams(p1, p2, p3, p4) --[[ PlayFromFormattedParams | Line: 132 | Upvalues: Interface (copy), t2 (copy) ]]
	assert(Interface.PlayFormattedParamsInterface(p3))

	return t2.Play(p1, p2, p3.Speed, p3.Volume, p3.MaxDistance, p3.SoundGroup, p3.Looped, p3.TimePos, p3.Player, p3.SkipPlay, p4)
end
function t2.PrepareSoundFromSoundFile(p1, p2) --[[ PrepareSoundFromSoundFile | Line: 155 | Upvalues: Asserts (copy), Interface (copy), InstanceCheck (copy), ParseAssetId (copy), v4 (copy) ]]
	Asserts.Sound(p1)
	assert(Interface.SoundFile(p2))

	local SoundId = p2.SoundId
	local Data = p2.Data
	local v1 = if Data then Data.Speed else Data
	local v2 = if Data then Data.Volume else Data
	local v3 = if Data then Data.MaxDistance else Data
	local v42 = if Data then Data.SoundGroup else Data
	local v5 = if Data then Data.Looped else Data
	local v6 = if Data then Data.TimePos else Data

	if not InstanceCheck(SoundId, "Sound") then
		if type(SoundId) == "table" then
			SoundId = SoundId[math.random(1, #SoundId)]
		end

		if type(SoundId) == "string" then
			SoundId = ParseAssetId(SoundId)
		end

		assert(if type(SoundId) == "number" then true else false, "soundIdOrInstance must be a number")
		assert(if SoundId > 0 then true else false, "soundIdOrInstance must be greater than 0")
	end

	if v1 == nil then
		v1 = 1
	end

	if type(v1) == "table" then
		v1 = v4:NextNumber(unpack(v1))
	end

	assert(if type(v1) == "number" then true else false, "speed must be a number")

	if v2 == nil then
		v2 = 1
	end

	if type(v2) == "table" then
		v2 = v4:NextNumber(unpack(v2))
	end

	assert(if type(v2) == "number" then true else false, "volume must be a number")

	if v3 == nil then
		v3 = 200
	end

	assert(if type(v3) == "number" then true else false, "maxDistance must be a number")

	if typeof(v42) == "Instance" then
		assert(v42:IsA("SoundGroup"), "soundGroup must be a SoundGroup instance")

		local _ = v42.Name
	end

	if v5 == nil then
		v5 = false
	end

	assert(if type(v5) == "boolean" then true else false, "looped must be a boolean")

	if v6 == nil then
		v6 = 0
	end

	assert(if type(v6) == "number" then true else false, "timePos must be a number")
	p1.SoundId = ("rbxassetid://%d"):format(SoundId)
	p1.PlaybackSpeed = v1
	p1.Volume = v2
	p1.Looped = v5
	p1.TimePosition = v6
	p1.RollOffMode = Enum.RollOffMode.LinearSquare
	p1.RollOffMinDistance = 0.001
	p1.RollOffMaxDistance = v3

	return p1
end
function t2.Play(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11) --[[ Play | Line: 224 | Upvalues: InstanceCheck (copy), ParseAssetId (copy), v4 (copy), Asserts (copy), v3 (copy), v1 (ref), Sound (copy), v2 (ref), SoundService (copy), __DEBRIS (copy), t2 (copy) ]]
	local v12 = InstanceCheck(p1, "Sound")

	if not v12 then
		if type(p1) == "table" then
			p1 = p1[math.random(1, #p1)]
		end

		if type(p1) == "string" then
			p1 = ParseAssetId(p1)
		end

		assert(if type(p1) == "number" then true else false, "soundIdOrInstance must be a number")
		assert(if p1 > 0 then true else false, "soundIdOrInstance must be greater than 0")
	end

	if typeof(p2) == "Vector3" then
		p2 = CFrame.new(p2)
	end

	local v5 = if typeof(p2) == "CFrame" then true elseif typeof(p2) == "Instance" then true else false

	assert(v5, "target must be either a CFrame or an Instance")

	if p3 == nil then
		p3 = 1
	end

	if type(p3) == "table" then
		p3 = v4:NextNumber(unpack(p3))
	end

	assert(if type(p3) == "number" then true else false, "speed must be a number")

	if p4 == nil then
		p4 = 1
	end

	if type(p4) == "table" then
		p4 = v4:NextNumber(unpack(p4))
	end

	assert(if type(p4) == "number" then true else false, "volume must be a number")

	if p5 == nil then
		p5 = 200
	end

	assert(if type(p5) == "number" then true else false, "maxDistance must be a number")

	if typeof(p6) == "Instance" then
		assert(p6:IsA("SoundGroup"), "soundGroup must be a SoundGroup instance")
		p6 = p6.Name
	end

	assert(if p6 == nil then true elseif type(p6) == "string" then true else false, "soundGroup must be nil or a string when not an Instance")

	if p7 == nil then
		p7 = false
	end

	assert(if type(p7) == "boolean" then true else false, "looped must be a boolean")

	if p8 == nil then
		p8 = 0
	end

	assert(if type(p8) == "number" then true else false, "timePos must be a number")
	Asserts.optional.table(p11)

	if v3 then
		if not v1.Get(v1.Keys.SFX) then
			return Sound
		end

		if v2 and not v2.IsEnabled("SFX") then
			return Sound
		end

		local v15 = nil
		local v16 = Vector3.new(0, 0, 0)
		local v17 = true

		if typeof(p2) == "CFrame" then
			v15 = p2
		elseif typeof(p2) == "Instance" then
			if p2:IsA("Model") then
				local PrimaryPart = p2.PrimaryPart

				if not PrimaryPart then
					warn("Tried to play Audio on a Model with no PrimaryPart:", p2, p1, debug.traceback())

					return Sound
				end

				v15 = PrimaryPart.CFrame
				v16 = PrimaryPart.Size
			elseif p2:IsA("BasePart") then
				v15 = p2.CFrame
				v16 = p2.Size
			elseif p2:IsA("PVInstance") then
				v15 = p2:GetPivot()
			elseif p2:IsA("Attachment") then
				v15 = p2.WorldCFrame
			end
		end

		local v19 = workspace.CurrentCamera.CFrame

		if not v15 then
			v17 = false
			v15 = v19
		end

		if not p7 and v17 then
			local v20 = p5 * 2
			local v21 = v16 * 0.5 + Vector3.new(v20, v20, v20)
			local v22 = v15:ToObjectSpace(v19)

			if not (if v22.X >= -v21.X and (v22.X <= v21.X and (v22.Y >= -v21.Y and (v22.Y <= v21.Y and v22.Z >= -v21.Z))) then v22.Z <= v21.Z else false) then
				return Sound
			end
		end

		local v24 = SoundService:FindFirstChild(p6 or "Default")

		assert(v24, (("Could not find SoundGroup with name: %*"):format(p6 or "Default")))
		assert(v24:IsA("SoundGroup"), "Found instance is not a SoundGroup")

		local v27 = false

		if typeof(p2) == "CFrame" then
			local Part = Instance.new("Part")

			Part.CFrame = p2
			Part.Anchored = true
			Part.CanCollide = false
			Part.CanQuery = false
			Part.CanTouch = false
			Part.Size = Vector3.new(0, 0, 0)
			Part.Transparency = 1
			Part.Parent = __DEBRIS
			v27 = true
			p2 = Part
		elseif p2:IsA("Model") then
			local PrimaryPart = p2.PrimaryPart

			if not PrimaryPart then
				warn("Tried to play Audio on a Model with no PrimaryPart:", p2, p1, debug.traceback())

				return Sound
			end

			p2 = PrimaryPart
		end

		local v28 = if typeof(p2) == "Instance" then true else false

		assert(v28, "target must be an Instance")

		local v29 = v12 and p1:Clone() or Instance.new("Sound")

		if not v12 then
			v29.SoundId = ("rbxassetid://%d"):format(p1)
			v29.PlaybackSpeed = p3
			v29.Volume = p4
			v29.Looped = p7
			v29.TimePosition = p8
			v29.RollOffMode = Enum.RollOffMode.LinearSquare
			v29.RollOffMinDistance = 0.001
			v29.RollOffMaxDistance = p5
			v29.SoundGroup = v24

			if p11 then
				for i, v in ipairs(p11) do
					Asserts.Instance(v)
					v.Parent = v29
				end
			end
		end

		if p2:IsA("Model") then
			local PrimaryPart = p2.PrimaryPart

			if PrimaryPart then
				p2 = PrimaryPart
			end
		end

		v29.Parent = p2

		if not p10 then
			t2.ScheduleAndPlay(v29, function() --[[ Line: 444 | Upvalues: v27 (ref), p2 (ref) ]]
				if v27 then
					p2:Destroy()

					return true
				end
			end)
		end

		return v29
	end

	local Network = require(game:GetService("ServerScriptService"):WaitForChild("Library").Network)

	if p9 then
		Network.Fire("PlaySound", p9, p1, p2, p3, p4, p5, p6, p7, p8, nil, p10, p11)
	else
		Network.FireAll("PlaySound", p1, p2, p3, p4, p5, p6, p7, p8, nil, p10, p11)
	end

	return nil
end
function t2.PlayError(p1) --[[ PlayError | Line: 456 | Upvalues: t2 (copy) ]]
	t2.Play("rbxassetid://131342831254185", script, 1, 1 * (p1 or 1))
end
function t2.PlayStatement(p1) --[[ PlayStatement | Line: 460 | Upvalues: t2 (copy) ]]
	t2.Play("rbxassetid://131342831254185", script, 1, 0.5 * (p1 or 1))
end
function t2.PlayQuestion(p1) --[[ PlayQuestion | Line: 464 | Upvalues: t2 (copy) ]]
	t2.Play("rbxassetid://131342831254185", script, 1, 0.8 * (p1 or 1))
end
function t2.PlayLocked(p1) --[[ PlayLocked | Line: 468 | Upvalues: t2 (copy) ]]
	t2.Play("rbxassetid://131342831254185", script, 1, 1 * (p1 or 1))
end
function t2.Huh(p1, p2) --[[ Huh | Line: 472 | Upvalues: t2 (copy) ]]
	t2.Play("rbxassetid://131342831254185", script, 1, 1 * (p2 or 1), nil, nil, nil, nil, p1)
end
function t2.Fade(p1, p2, p3, p4, p5) --[[ Fade | Line: 475 | Upvalues: Interface (copy), Tween (copy) ]]
	assert(Interface.FadeParams(p1, p2, p3, p4, p5))

	return Tween(p1, {
		Volume = p2
	}, { p3, p4, p5 })
end
function t2.PlayMusic(p1, p2, p3, p4, p5, p6) --[[ PlayMusic | Line: 493 | Upvalues: v3 (copy), v2 (ref), Sound (copy), ParseAssetId (copy), v4 (copy), SoundService (copy), Music (copy), t2 (copy), t (copy) ]]
	if v3 and (v2 and not v2.IsEnabled("Music")) then
		return Sound
	end

	if type(p1) == "table" then
		p1 = p1[math.random(1, #p1)]
	end

	if type(p1) == "string" then
		p1 = ParseAssetId(p1)
	end

	assert(if type(p1) == "number" then true else false, "soundId must be a number")
	assert(if p1 > 0 then true else false, "soundId must be greater than 0")

	if p2 == nil then
		p2 = 1
	end

	if type(p2) == "table" then
		p2 = v4:NextNumber(unpack(p2))
	end

	assert(if type(p2) == "number" then true else false, "volume must be a number")

	if p3 == nil then
		p3 = 1
	end

	assert(if type(p3) == "number" then true else false, "fadeTime must be a number")

	if typeof(p4) == "Instance" then
		assert(p4:IsA("SoundGroup"), "group must be a SoundGroup instance")
		p4 = p4.Name
	end

	assert(if p4 == nil then true elseif type(p4) == "string" then true else false, "group must be nil or a string when not an Instance")

	if p5 == nil then
		p5 = true
	end

	assert(if type(p5) == "boolean" then true else false, "loop must be a boolean")

	if p6 == nil then
		p6 = 0
	end

	assert(if type(p6) == "number" then true else false, "timePos must be a number")

	local v11 = SoundService:FindFirstChild(p4 or "Music")

	assert(v11, "Could not find SoundGroup with name: " .. (p4 or "Music"))
	assert(v11:IsA("SoundGroup"), "Found instance is not a SoundGroup")

	local Sound2 = Instance.new("Sound")

	Sound2.SoundId = ("rbxassetid://%d"):format(p1)
	Sound2.Volume = 0
	Sound2.Looped = p5
	Sound2.SoundGroup = v11
	Sound2.Parent = Music
	Sound2:Play()

	for i, v in ipairs(Music:GetChildren()) do
		if v:IsA("Sound") then
			t2.Fade(v, 0, p3)
		end
	end

	t2.Fade(Sound2, p2, p3)
	table.insert(t, { Sound2, nil })

	return Sound2
end
function t2.StopMusic(p1) --[[ StopMusic | Line: 560 | Upvalues: Music (copy), t2 (copy) ]]
	if p1 == nil then
		p1 = 1
	end

	assert(type(p1) == "number", "fadeTime must be a number")

	for i, v in ipairs(Music:GetChildren()) do
		if v:IsA("Sound") then
			t2.Fade(v, 0, p1)
		end
	end
end

if v3 then
	local DefaultReverb = SoundService:FindFirstChild("DefaultReverb")

	if DefaultReverb then
		local ReverbSoundEffect = DefaultReverb:FindFirstChild("ReverbSoundEffect")

		if ReverbSoundEffect then
			ReverbSoundEffect.DryLevel = -1.3389357926122634
			ReverbSoundEffect.WetLevel = -16.90196080028514
		end
	end

	local function computeVolume(p1) --[[ computeVolume | Line: 585 ]]
		return (math.clamp(p1, 0, 1) * 2) ^ 2
	end

	local Client = Library:WaitForChild("Client")
	local Network = require(Client.Network)
	local Signal = require(Library.Signal)

	Network.Fired("PlaySound"):Connect(function(...) --[[ Line: 594 | Upvalues: t2 (copy) ]]
		t2.Play(...)
	end)
	Signal.Fired("Setting Slider Update"):Connect(function(p1, p2) --[[ Line: 598 | Upvalues: SoundService (copy) ]]
		if p1 == "Music" then
			SoundService:WaitForChild("Music").Volume = (math.clamp(p2, 0, 1) * 2) ^ 2

			return
		end

		if p1 ~= "SFX" then
			return
		end

		local Default = SoundService:WaitForChild("Default")
		local DefaultReverb = SoundService:WaitForChild("DefaultReverb")
		local v1 = (math.clamp(p2, 0, 1) * 2) ^ 2

		Default.Volume = v1
		DefaultReverb.Volume = v1
	end)
end

_G.Huh = t2.Huh
task.spawn(function() --[[ Line: 655 | Upvalues: v3 (copy), scanGarbageCollection (copy) ]]
	if not v3 then
		return
	end

	while true do
		task.wait(1)
		scanGarbageCollection()
	end
end)

return t2