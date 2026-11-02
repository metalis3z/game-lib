--credit to leon games studio
local t = {}
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GrowEffects = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("GrowEffects"))
local EffectLoadManager = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("EffectLoadManager"))
local PerfFlags = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("Flags"):WaitForChild("PerfFlags"))
local VFX = script.VFX
local t2 = {}
local t3 = {}
local v1 = 0
local v2 = nil
local v3 = 0

local function isInsideFruits(p1, p2) --[[ isInsideFruits | Line: 45 ]]
	local v1 = p1.Parent

	while v1 and v1 ~= p2 do
		if v1.Name == "Fruits" then
			return true
		end

		v1 = v1.Parent
	end

	return false
end

local function createVFXPart(p1) --[[ createVFXPart | Line: 58 | Upvalues: PerfFlags (copy), t3 (copy), GrowEffects (copy), VFX (copy) ]]
	if PerfFlags.MutationVFXDisabled:Get() then
		return
	end

	if t3[p1] then
		return
	end

	if p1:IsA("Model") and p1.PrimaryPart then
		GrowEffects.AddDescendantsAtBaseline(p1, function() --[[ Line: 62 | Upvalues: p1 (copy), VFX (ref), t3 (ref) ]]
			local v1, v2 = p1:GetBoundingBox()
			local BloodlitVFX = Instance.new("Part")

			BloodlitVFX.Name = "BloodlitVFX"
			BloodlitVFX.Size = v2
			BloodlitVFX.CFrame = v1
			BloodlitVFX.Transparency = 1
			BloodlitVFX.CanCollide = false
			BloodlitVFX.CanQuery = false
			BloodlitVFX.CanTouch = false
			BloodlitVFX.Anchored = true
			BloodlitVFX.Massless = true
			BloodlitVFX:AddTag("MutationVFX")
			BloodlitVFX.Parent = p1

			for v3, v4 in VFX:GetChildren() do
				v4:Clone().Parent = BloodlitVFX
			end

			t3[p1] = BloodlitVFX
		end)
	end
end

local function tryCreateVFX(p1) --[[ tryCreateVFX | Line: 83 | Upvalues: createVFXPart (copy) ]]
	if not (p1:IsA("Model") and p1.PrimaryPart) then
		return
	end

	createVFXPart(p1)
end

local function registerPart(p1, p2) --[[ registerPart | Line: 93 | Upvalues: t2 (copy) ]]
	if not p2:IsA("BasePart") then
		return
	end

	local v1 = t2[p1]

	if not v1 then
		return
	end

	local v2 = p2.Parent
	local v3

	while v2 and v2 ~= p1 do
		if v2.Name == "Fruits" then
			v3 = true

			if v3 then
				return
			end

			if not v1.parts[p2] then
				v1.parts[p2] = {
					OriginalColor = p2.Color,
					OriginalReflectance = p2.Reflectance
				}
				p2.Reflectance = 0.1
			end

			return
		end

		v2 = v2.Parent
	end

	v3 = false

	if v3 then
		return
	end

	if not v1.parts[p2] then
		v1.parts[p2] = {
			OriginalColor = p2.Color,
			OriginalReflectance = p2.Reflectance
		}
		p2.Reflectance = 0.1
	end
end

local function tickBloodlit() --[[ tickBloodlit | Line: 114 | Upvalues: t2 (copy), t (copy) ]]
	local v1 = os.clock() * 0.5 * math.pi * 2

	for v2, v3 in t2 do
		if v2.Parent then
			for v4, v5 in v3.parts do
				if v4.Parent then
					v4.Color = Color3.fromHSV(0, 1, (math.sin(v4.Position.X / 50 + v1) + 1) / 2 * 0.75 + 0.05)

					continue
				end

				v3.parts[v4] = nil
			end

			continue
		end

		t.RemoveMutationEffect(v2)
	end
end

local function startBloodlitLoop() --[[ startBloodlitLoop | Line: 139 | Upvalues: v2 (ref), v3 (ref), RunService (copy), PerfFlags (copy), EffectLoadManager (copy), tickBloodlit (copy) ]]
	if not v2 then
		v3 = 0
		v2 = RunService.Heartbeat:Connect(function(p13) --[[ Line: 143 | Upvalues: PerfFlags (ref), v3 (ref), EffectLoadManager (ref), tickBloodlit (ref) ]]
			if PerfFlags.MutationVFXDisabled:Get() then
				return
			end

			v3 = v3 + p13

			if not (v3 < EffectLoadManager.GetTickInterval()) then
				v3 = 0
				debug.profilebegin("Controllers/MutationController/Bloodlit/Tick")
				tickBloodlit()
				debug.profileend()
			end
		end)
	end
end

local function stopBloodlitLoop() --[[ stopBloodlitLoop | Line: 158 | Upvalues: v2 (ref) ]]
	if not v2 then
		return
	end

	v2:Disconnect()
	v2 = nil
end

function t.ApplyMutationEffect(p1) --[[ ApplyMutationEffect | Line: 169 | Upvalues: t2 (copy), CollectionService (copy), createVFXPart (copy), registerPart (copy), t3 (copy), EffectLoadManager (copy), v1 (ref), v2 (ref), v3 (ref), RunService (copy), PerfFlags (copy), tickBloodlit (copy) ]]
	if t2[p1] then
		return
	end

	CollectionService:AddTag(p1, "Bloodlit")

	local t = {
		descendantConn = nil,
		parts = {}
	}

	t2[p1] = t

	if p1:IsA("Model") and p1.PrimaryPart then
		createVFXPart(p1)
	end

	registerPart(p1, p1)

	for v12, v22 in p1:GetDescendants() do
		registerPart(p1, v22)
	end

	t.descendantConn = p1.DescendantAdded:Connect(function(p12) --[[ Line: 183 | Upvalues: registerPart (ref), p1 (copy), t3 (ref), createVFXPart (ref) ]]
		registerPart(p1, p12)

		if t3[p1] then
			return
		end

		local v1 = p1

		if not (v1:IsA("Model") and v1.PrimaryPart) then
			return
		end

		createVFXPart(v1)
	end)
	EffectLoadManager.Register()
	v1 = v1 + 1

	if v1 ~= 1 then
		return
	end

	if v2 then
		return
	end

	v3 = 0
	v2 = RunService.Heartbeat:Connect(function(p13) --[[ Line: 143 | Upvalues: PerfFlags (ref), v3 (ref), EffectLoadManager (ref), tickBloodlit (ref) ]]
		if PerfFlags.MutationVFXDisabled:Get() then
			return
		end

		v3 = v3 + p13

		if not (v3 < EffectLoadManager.GetTickInterval()) then
			v3 = 0
			debug.profilebegin("Controllers/MutationController/Bloodlit/Tick")
			tickBloodlit()
			debug.profileend()
		end
	end)
end
function t.RemoveMutationEffect(p1) --[[ RemoveMutationEffect | Line: 197 | Upvalues: t2 (copy), t3 (copy), EffectLoadManager (copy), v1 (ref), v2 (ref) ]]
	local v12 = t2[p1]

	if not v12 then
		return
	end

	t2[p1] = nil

	if v12.descendantConn then
		v12.descendantConn:Disconnect()
	end

	for v22, v3 in v12.parts do
		if v22.Parent then
			v22.Color = v3.OriginalColor
			v22.Reflectance = v3.OriginalReflectance
		end
	end

	if t3[p1] then
		t3[p1]:Destroy()
		t3[p1] = nil
	end

	EffectLoadManager.Unregister()
	v1 = math.max(0, v1 - 1)

	if v1 ~= 0 or not v2 then
		return
	end

	v2:Disconnect()
	v2 = nil
end
CollectionService:GetInstanceAddedSignal("Bloodlit"):Connect(t.ApplyMutationEffect)
CollectionService:GetInstanceRemovedSignal("Bloodlit"):Connect(t.RemoveMutationEffect)

for v4, v5 in CollectionService:GetTagged("Bloodlit") do
	task.spawn(t.ApplyMutationEffect, v5)
end

PerfFlags.MutationVFXDisabled.Changed:Connect(function(p1) --[[ Line: 238 | Upvalues: t3 (copy), t2 (copy), createVFXPart (copy) ]]
	if p1 then
		for v1, v2 in t3 do
			v2:Destroy()
			t3[v1] = nil
		end
	else
		for v3 in t2 do
			if v3:IsA("Model") and v3.PrimaryPart then
				createVFXPart(v3)
			end
		end
	end
end)

return t