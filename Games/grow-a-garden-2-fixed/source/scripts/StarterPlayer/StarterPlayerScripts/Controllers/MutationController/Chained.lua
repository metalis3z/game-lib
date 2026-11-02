--credit to prince games studio
local t = {}
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local GrowEffects = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("GrowEffects"))
local PerfFlags = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("Flags"):WaitForChild("PerfFlags"))
local t2 = {}
local t3 = {}
local v1 = false
local VFX = script.VFX

local function isInsideFruits(p1, p2) --[[ isInsideFruits | Line: 24 ]]
	local v1 = p1.Parent

	while v1 and v1 ~= p2 do
		if v1.Name == "Fruits" then
			return true
		end

		v1 = v1.Parent
	end

	return false
end

local function createVFXPart(p1) --[[ createVFXPart | Line: 33 | Upvalues: PerfFlags (copy), t3 (copy), GrowEffects (copy), VFX (copy) ]]
	if PerfFlags.MutationVFXDisabled:Get() then
		return
	end

	if t3[p1] then
		return
	end

	if p1:IsA("Model") and p1.PrimaryPart then
		GrowEffects.AddDescendantsAtBaseline(p1, function() --[[ Line: 38 | Upvalues: p1 (copy), VFX (ref), t3 (ref) ]]
			local v1, v2 = p1:GetBoundingBox()
			local ChainedVFX = Instance.new("Part")

			ChainedVFX.Name = "ChainedVFX"
			ChainedVFX.Size = v2
			ChainedVFX.CFrame = v1
			ChainedVFX.Transparency = 1
			ChainedVFX.CanCollide = false
			ChainedVFX.CanQuery = false
			ChainedVFX.CanTouch = false
			ChainedVFX.Anchored = true
			ChainedVFX.Massless = true
			ChainedVFX:AddTag("MutationVFX")
			ChainedVFX.Parent = p1

			for v3, v4 in VFX:GetChildren() do
				v4:Clone().Parent = ChainedVFX
			end

			local v5 = 0

			if v5 < ChainedVFX.Size.X then
				v5 = ChainedVFX.Size.X
			end

			if v5 < ChainedVFX.Size.Z then
				v5 = ChainedVFX.Size.Z
			end

			local v6 = script.ChainedModel:Clone()

			v6:ScaleTo(v5 * 1.05)

			for v7, v8 in v6.ChainCircle:GetChildren() do
				v8.Parent = ChainedVFX
			end

			v6:Destroy()
			t3[p1] = ChainedVFX
		end)
	end
end

local function tryCreateVFX(p1) --[[ tryCreateVFX | Line: 83 | Upvalues: createVFXPart (copy) ]]
	if not (p1:IsA("Model") and p1.PrimaryPart) then
		return
	end

	createVFXPart(p1)
end

local function registerPart(p1, p2) --[[ registerPart | Line: 89 | Upvalues: t2 (copy) ]]
	if not p2:IsA("BasePart") then
		return
	end

	if not t2[p1] then
		return
	end

	local v1 = p2.Parent
	local v2, _, _2, v3, v4

	while v1 and v1 ~= p1 do
		if v1.Name == "Fruits" then
			v2 = true

			if v2 then
				return
			end

			for v5, v6 in t2[p1] do
				if v6.Part == p2 then
					return
				end
			end

			_, _2, v3 = p2.Color:ToHSV()
			p2.Reflectance = 0.25
			v4 = t2[p1]
			table.insert(v4, {
				Part = p2,
				Value = v3
			})

			return
		end

		v1 = v1.Parent
	end

	v2 = false

	if v2 then
		return
	end

	for v5, v6 in t2[p1] do
		if v6.Part == p2 then
			return
		end
	end

	_, _2, v3 = p2.Color:ToHSV()
	p2.Reflectance = 0.25
	v4 = t2[p1]
	table.insert(v4, {
		Part = p2,
		Value = v3
	})
end

local function startChainedLoop() --[[ startChainedLoop | Line: 107 | Upvalues: v1 (ref), RunService (copy), PerfFlags (copy), t2 (copy), t3 (copy) ]]
	if not v1 then
		v1 = true
		RunService.Heartbeat:Connect(function() --[[ Line: 111 | Upvalues: PerfFlags (ref), t2 (ref), t3 (ref) ]]
			if PerfFlags.MutationVFXDisabled:Get() then
				return
			end

			debug.profilebegin("Controllers/MutationController/Chained/Heartbeat")

			for v1, v2 in t2 do
				if v1.Parent then
					for v3, v4 in v2 do
						if v4.Part.Parent then
							v4.Part.Color = Color3.fromHSV(0.849, 1, (math.sin(v4.Part.Position.X / 50 + tick() * 0.7 * math.pi * 2) + 1) / 2 * 0.4 + 0.6)
						end
					end

					continue
				end

				t2[v1] = nil

				if t3[v1] then
					t3[v1]:Destroy()
					t3[v1] = nil
				end
			end

			debug.profileend()
		end)
	end
end

function t.ApplyMutationEffect(p1) --[[ ApplyMutationEffect | Line: 138 | Upvalues: t2 (copy), CollectionService (copy), createVFXPart (copy), registerPart (copy), t3 (copy), v1 (ref), RunService (copy), PerfFlags (copy) ]]
	if t2[p1] then
		return
	end

	CollectionService:AddTag(p1, "Chained")
	t2[p1] = {}

	if p1:IsA("Model") and p1.PrimaryPart then
		createVFXPart(p1)
	end

	registerPart(p1, p1)

	for v12, v2 in p1:GetDescendants() do
		registerPart(p1, v2)
	end

	p1.DescendantAdded:Connect(function(p12) --[[ Line: 153 | Upvalues: registerPart (ref), p1 (copy), t3 (ref), createVFXPart (ref) ]]
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

	if not v1 then
		v1 = true
		RunService.Heartbeat:Connect(function() --[[ Line: 111 | Upvalues: PerfFlags (ref), t2 (ref), t3 (ref) ]]
			if PerfFlags.MutationVFXDisabled:Get() then
				return
			end

			debug.profilebegin("Controllers/MutationController/Chained/Heartbeat")

			for v1, v2 in t2 do
				if v1.Parent then
					for v3, v4 in v2 do
						if v4.Part.Parent then
							v4.Part.Color = Color3.fromHSV(0.849, 1, (math.sin(v4.Part.Position.X / 50 + tick() * 0.7 * math.pi * 2) + 1) / 2 * 0.4 + 0.6)
						end
					end

					continue
				end

				t2[v1] = nil

				if t3[v1] then
					t3[v1]:Destroy()
					t3[v1] = nil
				end
			end

			debug.profileend()
		end)
	end
end
CollectionService:GetInstanceAddedSignal("Chained"):Connect(t.ApplyMutationEffect)

for v2, v3 in CollectionService:GetTagged("Chained") do
	task.spawn(t.ApplyMutationEffect, v3)
end

PerfFlags.MutationVFXDisabled.Changed:Connect(function(p1) --[[ Line: 170 | Upvalues: t3 (copy), t2 (copy), createVFXPart (copy) ]]
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