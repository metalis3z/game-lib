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

local function createVFXPart(p1) --[[ createVFXPart | Line: 15 | Upvalues: PerfFlags (copy), t3 (copy), GrowEffects (copy), VFX (copy) ]]
	if PerfFlags.MutationVFXDisabled:Get() then
		return
	end

	if t3[p1] then
		return
	end

	if p1:IsA("Model") and p1.PrimaryPart then
		GrowEffects.AddDescendantsAtBaseline(p1, function() --[[ Line: 19 | Upvalues: p1 (copy), VFX (ref), t3 (ref) ]]
			local v1, v2 = p1:GetBoundingBox()
			local SecretVFX = Instance.new("Part")

			SecretVFX.Name = "SecretVFX"
			SecretVFX.Size = v2
			SecretVFX.CFrame = v1
			SecretVFX.Transparency = 1
			SecretVFX.CanCollide = false
			SecretVFX.CanQuery = false
			SecretVFX.CanTouch = false
			SecretVFX.Anchored = true
			SecretVFX.Massless = true
			SecretVFX:AddTag("MutationVFX")
			SecretVFX.Parent = p1

			for v3, v4 in VFX:GetChildren() do
				v4:Clone().Parent = SecretVFX
			end

			t3[p1] = SecretVFX
		end)
	end
end

local function tryCreateVFX(p1) --[[ tryCreateVFX | Line: 40 | Upvalues: createVFXPart (copy) ]]
	if not (p1:IsA("Model") and p1.PrimaryPart) then
		return
	end

	createVFXPart(p1)
end

local function registerPart(p1, p2) --[[ registerPart | Line: 46 | Upvalues: t2 (copy) ]]
	if not p2:IsA("BasePart") then
		return
	end

	if not t2[p1] then
		return
	end

	local v1 = p2.Parent

	while v1 and v1 ~= p1 do
		if v1.Name == "Fruits" then
			return
		end

		v1 = v1.Parent
	end

	for v2, v3 in t2[p1] do
		if v3.Part == p2 then
			return
		end
	end

	local _, _2, v4 = p2.Color:ToHSV()

	p2.Reflectance = 0.1
	table.insert(t2[p1], {
		Part = p2,
		Value = v4
	})
end

local function startSecretLoop() --[[ startSecretLoop | Line: 65 | Upvalues: v1 (ref), RunService (copy), PerfFlags (copy), t2 (copy), t3 (copy) ]]
	if not v1 then
		v1 = true
		RunService.Heartbeat:Connect(function() --[[ Line: 68 | Upvalues: PerfFlags (ref), t2 (ref), t3 (ref) ]]
			if PerfFlags.MutationVFXDisabled:Get() then
				return
			end

			debug.profilebegin("Controllers/MutationController/Secret/Heartbeat")

			local v1 = tick() * 0.5

			for v2, v3 in t2 do
				if v2.Parent then
					for v4, v5 in v3 do
						if v5.Part.Parent then
							local v8 = math.clamp((math.sin((v5.Part.Position.Y / 0.2 + v1) * math.pi * 2) + 1) / 2 * 0.85 + 0.05, 0.05, 0.9)

							v5.Part.Color = Color3.new(v8, v8, v8)
						end
					end

					continue
				end

				t2[v2] = nil

				if t3[v2] then
					t3[v2]:Destroy()
					t3[v2] = nil
				end
			end

			debug.profileend()
		end)
	end
end

function t.ApplyMutationEffect(p1) --[[ ApplyMutationEffect | Line: 93 | Upvalues: t2 (copy), CollectionService (copy), createVFXPart (copy), registerPart (copy), t3 (copy), v1 (ref), RunService (copy), PerfFlags (copy) ]]
	if t2[p1] then
		return
	end

	CollectionService:AddTag(p1, "Secret")
	t2[p1] = {}

	if p1:IsA("Model") and p1.PrimaryPart then
		createVFXPart(p1)
	end

	registerPart(p1, p1)

	for v12, v2 in p1:GetDescendants() do
		registerPart(p1, v2)
	end

	p1.DescendantAdded:Connect(function(p12) --[[ Line: 102 | Upvalues: registerPart (ref), p1 (copy), t3 (ref), createVFXPart (ref) ]]
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
		RunService.Heartbeat:Connect(function() --[[ Line: 68 | Upvalues: PerfFlags (ref), t2 (ref), t3 (ref) ]]
			if PerfFlags.MutationVFXDisabled:Get() then
				return
			end

			debug.profilebegin("Controllers/MutationController/Secret/Heartbeat")

			local v1 = tick() * 0.5

			for v2, v3 in t2 do
				if v2.Parent then
					for v4, v5 in v3 do
						if v5.Part.Parent then
							local v8 = math.clamp((math.sin((v5.Part.Position.Y / 0.2 + v1) * math.pi * 2) + 1) / 2 * 0.85 + 0.05, 0.05, 0.9)

							v5.Part.Color = Color3.new(v8, v8, v8)
						end
					end

					continue
				end

				t2[v2] = nil

				if t3[v2] then
					t3[v2]:Destroy()
					t3[v2] = nil
				end
			end

			debug.profileend()
		end)
	end
end
CollectionService:GetInstanceAddedSignal("Secret"):Connect(t.ApplyMutationEffect)

for v2, v3 in CollectionService:GetTagged("Secret") do
	task.spawn(t.ApplyMutationEffect, v3)
end

PerfFlags.MutationVFXDisabled.Changed:Connect(function(p1) --[[ Line: 117 | Upvalues: t3 (copy), t2 (copy), createVFXPart (copy) ]]
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