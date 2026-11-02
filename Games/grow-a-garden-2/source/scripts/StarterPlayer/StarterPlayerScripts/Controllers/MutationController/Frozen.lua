--credit to prince games studio
local t = {}
local GrowEffects = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("GrowEffects"))
local v1 = Color3.fromRGB(180, 220, 255)
local VFX = script.VFX
local t2 = {}

local function isInsideFruits(p1, p2) --[[ isInsideFruits | Line: 10 ]]
	local v1 = p1.Parent

	while v1 and v1 ~= p2 do
		if v1.Name == "Fruits" then
			return true
		end

		v1 = v1.Parent
	end

	return false
end

local function createVFXPart(p1) --[[ createVFXPart | Line: 19 | Upvalues: t2 (copy), GrowEffects (copy), VFX (copy) ]]
	if t2[p1] then
		return
	end

	if p1:IsA("Model") and p1.PrimaryPart then
		GrowEffects.AddDescendantsAtBaseline(p1, function() --[[ Line: 23 | Upvalues: p1 (copy), VFX (ref), t2 (ref) ]]
			local v1, v2 = p1:GetBoundingBox()
			local FrozenVFX = Instance.new("Part")

			FrozenVFX.Name = "FrozenVFX"
			FrozenVFX.Size = v2
			FrozenVFX.CFrame = v1
			FrozenVFX.Transparency = 1
			FrozenVFX.CanCollide = false
			FrozenVFX.CanQuery = false
			FrozenVFX.CanTouch = false
			FrozenVFX.Anchored = true
			FrozenVFX.Massless = true
			FrozenVFX:AddTag("MutationVFX")
			FrozenVFX.Parent = p1

			local FrozenFX = game.ReplicatedStorage.Assets.Stud_Part:Clone()

			FrozenFX.Name = "FrozenFX"
			FrozenFX.Size = v2
			FrozenFX.CFrame = v1
			FrozenFX.Transparency = 0.5
			FrozenFX.Color = Color3.fromRGB(160, 210, 255)
			FrozenFX.CanCollide = false
			FrozenFX.CanQuery = false
			FrozenFX.CanTouch = false
			FrozenFX.Anchored = true
			FrozenFX.Massless = true
			FrozenFX.Parent = p1

			for v3, v42 in VFX:GetChildren() do
				v42:Clone().Parent = FrozenFX
			end

			t2[p1] = FrozenFX
		end)
	end
end

local function tryCreateVFX(p1) --[[ tryCreateVFX | Line: 60 | Upvalues: t2 (copy), GrowEffects (copy), VFX (copy) ]]
	if not (p1:IsA("Model") and p1.PrimaryPart) then
		return
	end

	if t2[p1] then
		return
	end

	if not p1:IsA("Model") then
		return
	end

	if not p1.PrimaryPart then
		return
	end

	GrowEffects.AddDescendantsAtBaseline(p1, function() --[[ Line: 23 | Upvalues: p1 (copy), VFX (ref), t2 (ref) ]]
		local v1, v2 = p1:GetBoundingBox()
		local FrozenVFX = Instance.new("Part")

		FrozenVFX.Name = "FrozenVFX"
		FrozenVFX.Size = v2
		FrozenVFX.CFrame = v1
		FrozenVFX.Transparency = 1
		FrozenVFX.CanCollide = false
		FrozenVFX.CanQuery = false
		FrozenVFX.CanTouch = false
		FrozenVFX.Anchored = true
		FrozenVFX.Massless = true
		FrozenVFX:AddTag("MutationVFX")
		FrozenVFX.Parent = p1

		local FrozenFX = game.ReplicatedStorage.Assets.Stud_Part:Clone()

		FrozenFX.Name = "FrozenFX"
		FrozenFX.Size = v2
		FrozenFX.CFrame = v1
		FrozenFX.Transparency = 0.5
		FrozenFX.Color = Color3.fromRGB(160, 210, 255)
		FrozenFX.CanCollide = false
		FrozenFX.CanQuery = false
		FrozenFX.CanTouch = false
		FrozenFX.Anchored = true
		FrozenFX.Massless = true
		FrozenFX.Parent = p1

		for v3, v42 in VFX:GetChildren() do
			v42:Clone().Parent = FrozenFX
		end

		t2[p1] = FrozenFX
	end)
end

local function applyFrozenToPart(p1) --[[ applyFrozenToPart | Line: 66 | Upvalues: v1 (copy) ]]
	p1.Color = v1
	p1.Reflectance = 0.4
end

function t.ApplyMutationEffect(p1) --[[ ApplyMutationEffect | Line: 71 | Upvalues: t2 (copy), GrowEffects (copy), VFX (copy), v1 (copy) ]]
	if p1:IsA("Model") and (p1.PrimaryPart and (not t2[p1] and (p1:IsA("Model") and p1.PrimaryPart))) then
		GrowEffects.AddDescendantsAtBaseline(p1, function() --[[ Line: 23 | Upvalues: p1 (copy), VFX (ref), t2 (ref) ]]
			local v1, v2 = p1:GetBoundingBox()
			local FrozenVFX = Instance.new("Part")

			FrozenVFX.Name = "FrozenVFX"
			FrozenVFX.Size = v2
			FrozenVFX.CFrame = v1
			FrozenVFX.Transparency = 1
			FrozenVFX.CanCollide = false
			FrozenVFX.CanQuery = false
			FrozenVFX.CanTouch = false
			FrozenVFX.Anchored = true
			FrozenVFX.Massless = true
			FrozenVFX:AddTag("MutationVFX")
			FrozenVFX.Parent = p1

			local FrozenFX = game.ReplicatedStorage.Assets.Stud_Part:Clone()

			FrozenFX.Name = "FrozenFX"
			FrozenFX.Size = v2
			FrozenFX.CFrame = v1
			FrozenFX.Transparency = 0.5
			FrozenFX.Color = Color3.fromRGB(160, 210, 255)
			FrozenFX.CanCollide = false
			FrozenFX.CanQuery = false
			FrozenFX.CanTouch = false
			FrozenFX.Anchored = true
			FrozenFX.Massless = true
			FrozenFX.Parent = p1

			for v3, v42 in VFX:GetChildren() do
				v42:Clone().Parent = FrozenFX
			end

			t2[p1] = FrozenFX
		end)
	end

	if p1:IsA("BasePart") then
		p1.Color = v1
		p1.Reflectance = 0.4
	end

	for v2, v3 in p1:GetDescendants() do
		local v12

		if v3:IsA("BasePart") then
			local v4 = v3.Parent

			while true do
				if not v4 or v4 == p1 then
					v12 = false

					break
				end

				if v4.Name == "Fruits" then
					v12 = true

					break
				end

				v4 = v4.Parent
			end

			if not v12 then
				v3.Color = v1
				v3.Reflectance = 0.4
			end
		end
	end

	p1.DescendantAdded:Connect(function(p12) --[[ Line: 84 | Upvalues: p1 (copy), v1 (ref), t2 (ref), GrowEffects (ref), VFX (ref) ]]
		if p12:IsA("BasePart") then
			local v12 = p1
			local v2 = p12.Parent
			local v3

			while true do
				if not v2 or v2 == v12 then
					v3 = false

					break
				end

				if v2.Name == "Fruits" then
					v3 = true

					break
				end

				v2 = v2.Parent
			end

			if not v3 then
				p12.Color = v1
				p12.Reflectance = 0.4
			end
		end

		if t2[p1] then
			return
		end

		local v4 = p1

		if not (v4:IsA("Model") and v4.PrimaryPart) then
			return
		end

		if t2[v4] then
			return
		end

		if not v4:IsA("Model") then
			return
		end

		if not v4.PrimaryPart then
			return
		end

		GrowEffects.AddDescendantsAtBaseline(v4, function() --[[ Line: 23 | Upvalues: v4 (copy), VFX (ref), t2 (ref) ]]
			local v1, v2 = v4:GetBoundingBox()
			local FrozenVFX = Instance.new("Part")

			FrozenVFX.Name = "FrozenVFX"
			FrozenVFX.Size = v2
			FrozenVFX.CFrame = v1
			FrozenVFX.Transparency = 1
			FrozenVFX.CanCollide = false
			FrozenVFX.CanQuery = false
			FrozenVFX.CanTouch = false
			FrozenVFX.Anchored = true
			FrozenVFX.Massless = true
			FrozenVFX:AddTag("MutationVFX")
			FrozenVFX.Parent = v4

			local FrozenFX = game.ReplicatedStorage.Assets.Stud_Part:Clone()

			FrozenFX.Name = "FrozenFX"
			FrozenFX.Size = v2
			FrozenFX.CFrame = v1
			FrozenFX.Transparency = 0.5
			FrozenFX.Color = Color3.fromRGB(160, 210, 255)
			FrozenFX.CanCollide = false
			FrozenFX.CanQuery = false
			FrozenFX.CanTouch = false
			FrozenFX.Anchored = true
			FrozenFX.Massless = true
			FrozenFX.Parent = v4

			for v3, v42 in VFX:GetChildren() do
				v42:Clone().Parent = FrozenFX
			end

			t2[v4] = FrozenFX
		end)
	end)
end

return t