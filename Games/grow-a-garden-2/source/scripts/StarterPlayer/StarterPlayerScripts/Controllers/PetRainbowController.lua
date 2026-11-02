--credit to leon games studio
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PerfFlags = require(ReplicatedStorage.SharedModules.Flags.PerfFlags)
local t = {}
local v1 = false
local t2 = {}

local function RegisterPart(p1, p2) --[[ RegisterPart | Line: 61 | Upvalues: t (copy) ]]
	if not p2:IsA("BasePart") then
		return
	end

	local v1 = t[p1]

	if not v1 then
		return
	end

	for v2, v3 in v1.Parts do
		if v3.Part == p2 then
			return
		end
	end

	local v4, _, v5 = p2.Color:ToHSV()
	local t2 = {
		Part = p2,
		OriginalHue = v4,
		Value = v5,
		OriginalColor = p2.Color,
		OriginalReflectance = p2.Reflectance
	}

	if p2:IsA("UnionOperation") then
		t2.OriginalUsePartColor = p2.UsePartColor
		p2.UsePartColor = true
	end

	p2.Reflectance = 0.1
	table.insert(v1.Parts, t2)
end

local function RestoreModel(p1) --[[ RestoreModel | Line: 91 ]]
	for v1, v2 in p1.Parts do
		if v2.Part.Parent then
			v2.Part.Color = v2.OriginalColor
			v2.Part.Reflectance = v2.OriginalReflectance

			if v2.OriginalUsePartColor ~= nil and v2.Part:IsA("UnionOperation") then
				v2.Part.UsePartColor = v2.OriginalUsePartColor
			end
		end
	end
end

local function StartLoop() --[[ StartLoop | Line: 102 | Upvalues: v1 (ref), RunService (copy), PerfFlags (copy), t (copy) ]]
	if not v1 then
		v1 = true
		RunService.Heartbeat:Connect(function() --[[ Line: 106 | Upvalues: PerfFlags (ref), t (ref) ]]
			if PerfFlags.AnimatedGradientsDisabled:Get() then
				return
			end

			debug.profilebegin("Controllers/PetRainbowController/Heartbeat")

			local v1 = tick() * 0.5 % 1

			for v2, v3 in t do
				if v2.Parent then
					local v4 = (v1 + v3.Offset) % 1

					for v5, v6 in v3.Parts do
						if v6.Part.Parent then
							v6.Part.Color = Color3.fromHSV(v4, 1, (math.clamp(v6.Value + (v6.OriginalHue - 0.5) * 0.5, 0.1, 1)))
						end
					end

					continue
				end

				v3.AddedConn:Disconnect()
				t[v2] = nil
			end

			debug.profileend()
		end)
	end
end

local function ApplyEffect(p1) --[[ ApplyEffect | Line: 135 | Upvalues: t (copy), RegisterPart (copy), v1 (ref), RunService (copy), PerfFlags (copy) ]]
	if t[p1] then
		return
	end

	t[p1] = {
		Offset = math.random(),
		Parts = {},
		AddedConn = p1.DescendantAdded:Connect(function(p12) --[[ Line: 141 | Upvalues: RegisterPart (ref), p1 (copy) ]]
			RegisterPart(p1, p12)
		end)
	}
	RegisterPart(p1, p1)

	for v12, v2 in p1:GetDescendants() do
		RegisterPart(p1, v2)
	end

	if not v1 then
		v1 = true
		RunService.Heartbeat:Connect(function() --[[ Line: 106 | Upvalues: PerfFlags (ref), t (ref) ]]
			if PerfFlags.AnimatedGradientsDisabled:Get() then
				return
			end

			debug.profilebegin("Controllers/PetRainbowController/Heartbeat")

			local v1 = tick() * 0.5 % 1

			for v2, v3 in t do
				if v2.Parent then
					local v4 = (v1 + v3.Offset) % 1

					for v5, v6 in v3.Parts do
						if v6.Part.Parent then
							v6.Part.Color = Color3.fromHSV(v4, 1, (math.clamp(v6.Value + (v6.OriginalHue - 0.5) * 0.5, 0.1, 1)))
						end
					end

					continue
				end

				v3.AddedConn:Disconnect()
				t[v2] = nil
			end

			debug.profileend()
		end)
	end
end

local function RemoveEffect(p1) --[[ RemoveEffect | Line: 155 | Upvalues: t (copy), RestoreModel (copy) ]]
	local v1 = t[p1]

	if v1 then
		v1.AddedConn:Disconnect()
		t[p1] = nil
		RestoreModel(v1)
	end
end

function t2.Init(p1) --[[ Init | Line: 163 ]] end
function t2.Start(p1) --[[ Start | Line: 165 | Upvalues: CollectionService (copy), ApplyEffect (copy), RemoveEffect (copy), PerfFlags (copy), t (copy), RestoreModel (copy) ]]
	CollectionService:GetInstanceAddedSignal("PetRainbow"):Connect(ApplyEffect)
	CollectionService:GetInstanceRemovedSignal("PetRainbow"):Connect(RemoveEffect)

	for v1, v2 in CollectionService:GetTagged("PetRainbow") do
		task.spawn(ApplyEffect, v2)
	end

	PerfFlags.AnimatedGradientsDisabled.Changed:Connect(function(p1) --[[ Line: 174 | Upvalues: t (ref), RestoreModel (ref) ]]
		if not p1 then
			return
		end

		for v1, v2 in t do
			RestoreModel(v2)
		end
	end)
end

return t2