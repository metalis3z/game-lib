--credit to prince games studio
local t = {}
local GrowEffects = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("GrowEffects"))
local VFX = script.VFX
local t2 = {}
local v1 = Color3.fromHSV(0, 0, 0)

local function isInsideFruits(p1, p2) --[[ isInsideFruits | Line: 13 ]]
	local v1 = p1.Parent

	while v1 and v1 ~= p2 do
		if v1.Name == "Fruits" then
			return true
		end

		v1 = v1.Parent
	end

	return false
end

local function createVFXPart(p1) --[[ createVFXPart | Line: 22 | Upvalues: t2 (copy), GrowEffects (copy), VFX (copy) ]]
	if t2[p1] then
		return
	end

	if p1:IsA("Model") and p1.PrimaryPart then
		GrowEffects.AddDescendantsAtBaseline(p1, function() --[[ Line: 26 | Upvalues: p1 (copy), VFX (ref), t2 (ref) ]]
			local v1, v2 = p1:GetBoundingBox()
			local ElectricVFX = Instance.new("Part")

			ElectricVFX.Name = "ElectricVFX"
			ElectricVFX.Size = v2
			ElectricVFX.CFrame = v1
			ElectricVFX.Transparency = 1
			ElectricVFX.CanCollide = false
			ElectricVFX.CanQuery = false
			ElectricVFX.CanTouch = false
			ElectricVFX.Anchored = true
			ElectricVFX.Massless = true
			ElectricVFX:AddTag("MutationVFX")
			ElectricVFX.Parent = p1

			for v3, v42 in VFX:GetChildren() do
				v42:Clone().Parent = ElectricVFX
			end

			t2[p1] = ElectricVFX
		end)
	end
end

local function tryCreateVFX(p1) --[[ tryCreateVFX | Line: 50 | Upvalues: t2 (copy), GrowEffects (copy), VFX (copy) ]]
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

	GrowEffects.AddDescendantsAtBaseline(p1, function() --[[ Line: 26 | Upvalues: p1 (copy), VFX (ref), t2 (ref) ]]
		local v1, v2 = p1:GetBoundingBox()
		local ElectricVFX = Instance.new("Part")

		ElectricVFX.Name = "ElectricVFX"
		ElectricVFX.Size = v2
		ElectricVFX.CFrame = v1
		ElectricVFX.Transparency = 1
		ElectricVFX.CanCollide = false
		ElectricVFX.CanQuery = false
		ElectricVFX.CanTouch = false
		ElectricVFX.Anchored = true
		ElectricVFX.Massless = true
		ElectricVFX:AddTag("MutationVFX")
		ElectricVFX.Parent = p1

		for v3, v42 in VFX:GetChildren() do
			v42:Clone().Parent = ElectricVFX
		end

		t2[p1] = ElectricVFX
	end)
end

local function applyElectricToPart(p1) --[[ applyElectricToPart | Line: 56 | Upvalues: v1 (copy) ]]
	p1.Color = v1
	p1.Reflectance = 25
	p1.Material = "Plastic"
	p1.MaterialVariant = ""
end

function t.ApplyMutationEffect(p1) --[[ ApplyMutationEffect | Line: 63 | Upvalues: t2 (copy), GrowEffects (copy), VFX (copy), v1 (copy) ]]
	if p1:IsA("Model") and (p1.PrimaryPart and (not t2[p1] and (p1:IsA("Model") and p1.PrimaryPart))) then
		GrowEffects.AddDescendantsAtBaseline(p1, function() --[[ Line: 26 | Upvalues: p1 (copy), VFX (ref), t2 (ref) ]]
			local v1, v2 = p1:GetBoundingBox()
			local ElectricVFX = Instance.new("Part")

			ElectricVFX.Name = "ElectricVFX"
			ElectricVFX.Size = v2
			ElectricVFX.CFrame = v1
			ElectricVFX.Transparency = 1
			ElectricVFX.CanCollide = false
			ElectricVFX.CanQuery = false
			ElectricVFX.CanTouch = false
			ElectricVFX.Anchored = true
			ElectricVFX.Massless = true
			ElectricVFX:AddTag("MutationVFX")
			ElectricVFX.Parent = p1

			for v3, v42 in VFX:GetChildren() do
				v42:Clone().Parent = ElectricVFX
			end

			t2[p1] = ElectricVFX
		end)
	end

	if p1:IsA("BasePart") then
		p1.Color = v1
		p1.Reflectance = 25
		p1.Material = "Plastic"
		p1.MaterialVariant = ""
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
				v3.Reflectance = 25
				v3.Material = "Plastic"
				v3.MaterialVariant = ""
			end
		end
	end

	p1.DescendantAdded:Connect(function(p12) --[[ Line: 76 | Upvalues: p1 (copy), v1 (ref), t2 (ref), GrowEffects (ref), VFX (ref) ]]
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
				p12.Reflectance = 25
				p12.Material = "Plastic"
				p12.MaterialVariant = ""
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

		GrowEffects.AddDescendantsAtBaseline(v4, function() --[[ Line: 26 | Upvalues: v4 (copy), VFX (ref), t2 (ref) ]]
			local v1, v2 = v4:GetBoundingBox()
			local ElectricVFX = Instance.new("Part")

			ElectricVFX.Name = "ElectricVFX"
			ElectricVFX.Size = v2
			ElectricVFX.CFrame = v1
			ElectricVFX.Transparency = 1
			ElectricVFX.CanCollide = false
			ElectricVFX.CanQuery = false
			ElectricVFX.CanTouch = false
			ElectricVFX.Anchored = true
			ElectricVFX.Massless = true
			ElectricVFX:AddTag("MutationVFX")
			ElectricVFX.Parent = v4

			for v3, v42 in VFX:GetChildren() do
				v42:Clone().Parent = ElectricVFX
			end

			t2[v4] = ElectricVFX
		end)
	end)
end

return t