--credit to prince games studio
local MaterialService = game:GetService("MaterialService")

local function GetRandomHSV(p1, p2, p3) --[[ GetRandomHSV | Line: 6 ]]
	local v1, v2, v3 = p2:ToHSV()

	if not p3 then
		p3 = 0.05
	end

	local v4 = v1 + p1:NextNumber(-p3, p3)

	return Color3.fromHSV(v4, v2, v3), v4, v2, v3
end

local function CreatePart(p1, p2, p3, p4) --[[ CreatePart | Line: 15 | Upvalues: MaterialService (copy) ]]
	local Part = Instance.new("Part")

	if not p2 then
		p2 = "Studs"
	end

	Part.Parent = p1
	Part.TopSurface = Enum.SurfaceType[p2]
	Part.BackSurface = Enum.SurfaceType[p2]
	Part.FrontSurface = Enum.SurfaceType[p2]
	Part.BottomSurface = Enum.SurfaceType[p2]
	Part.LeftSurface = Enum.SurfaceType[p2]
	Part.RightSurface = Enum.SurfaceType[p2]
	Part.Anchored = true
	Part.CanCollide = false
	Part.Transparency = 0

	if p4 then
		Part.Shape = Enum.PartType[p4]
	end

	if p3 then
		Part.MaterialVariant = p3

		local v1 = MaterialService:FindFirstChild(p3, true)

		if not v1 then
			return Part
		end

		Part.Material = v1.BaseMaterial
	end

	return Part
end

local function CreateMeshPart(p1, p2, p3) --[[ CreateMeshPart | Line: 45 ]]
	local v1 = p2:Clone()

	v1.Parent = p1
	v1.Anchored = true
	v1.CanCollide = false
	v1.Transparency = 0

	if p3 then
		v1.MaterialVariant = p3
	end

	return v1
end

local function GetDifference(p1, p2) --[[ GetDifference | Line: 57 ]]
	return p2 + (p1 - p2) / 2
end

return {
	GrowData = {
		BaseWeight = 1.5,
		GrowRate = 0.0058,
		GrowTickTime = NumberRange.new(4.8, 6)
	},
	InitFruit = function(p1, p2, p3) --[[ InitFruit | Line: 69 ]]
		local v1 = Random.new(p2)
		local v2 = 0.025
		local v3, v4, v5 = Color3.fromRGB(165, 138, 105):ToHSV()

		if not v2 then
			v2 = 0.05
		end

		local v7 = Color3.fromHSV(v3 + v1:NextNumber(-v2, v2), v4, v5)
		local v8 = p1:FindFirstChild("1")
		local v9 = p1:FindFirstChild("2")

		if v8 and v9 then
			local v10 = v1:NextNumber(0.25, 0.4)

			v8.Size = Vector3.new(v10, 0.85, v10)
			v8.CFrame = v9.CFrame * CFrame.Angles(0, 0, math.pi) * CFrame.new(0, 0.425 + v9.Size.Y / 2, 0) * CFrame.Angles(0, 0, math.pi)
		end

		local v11 = v7

		for v12, v13 in p1:GetChildren() do
			if v13:IsA("BasePart") then
				local v15 = tonumber(v13.Name)

				if v15 then
					local Angles = CFrame.Angles

					v13.CFrame = v13.CFrame * Angles(0, math.rad((v1:NextNumber(-10, 10))), 0)

					if v15 > 3 then
						v13.Color = v11
					end
				end
			end
		end

		local v18 = (p3 * 0.5 + 0.3) ^ 1.25

		p1:ScaleTo(v18 + v18 ^ 6 * 0.0001)
		p1:AddTag("InitializationComplete")
	end,
	BeginFruitGrowth = function(p1) --[[ BeginFruitGrowth | Line: 113 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}

		for v1, v2 in p1:GetDescendants() do
			local v4 = tonumber(v2.Name)

			if v2:IsA("BasePart") and v4 then
				local v5 = not v2:GetAttribute("DontShow")

				table.insert(t, {
					part = v2,
					maxSize = v2.Size,
					centerOffset = PrimaryPart.CFrame:ToObjectSpace(v2.CFrame),
					partAge = v4
				})
				v2.CanCollide = false

				if v5 then
					v2.Transparency = 1
				end
			end
		end

		local function updateGrowth() --[[ updateGrowth | Line: 134 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0
			local v2 = p1:GetAttribute("MaxAge") or 1
			local v3 = v1 / v2

			for v4, v5 in t do
				if not v5.part:GetAttribute("DontShow") then
					local v7 = math.clamp((v3 - v5.partAge / v2) * v2, 0, 1)

					if v7 > 0 then
						local v8 = v5.maxSize * v7

						v5.part.Size = v8
						v5.part.CFrame = PrimaryPart.CFrame * v5.centerOffset * CFrame.new(0, -((v5.maxSize.Y - v8.Y) / 2), 0)
						v5.part.Transparency = v5.part:GetAttribute("OG_Transparency") or 0
						v5.part.CanCollide = true

						continue
					end

					v5.part.Transparency = 1
					v5.part.CanCollide = false
				end
			end
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	OnFullyGrown = function(p1) --[[ OnFullyGrown | Line: 166 ]]
		local v1 = p1:GetAttribute("CorePartName")

		if v1 then
			local v2 = p1:FindFirstChild(v1)

			if v2 then
				local Collect_PROX_Apple = game.ServerStorage:FindFirstChild("Collect_PROX_Apple")

				if Collect_PROX_Apple then
					local ProximityPrompt = Collect_PROX_Apple:Clone()

					ProximityPrompt.Name = "ProximityPrompt"
					ProximityPrompt.Parent = v2
				end
			end
		end

		p1:AddTag("PlantGenerated")
	end,
	Extras = {
		FruitType = "Acorn",
		Harvestable = true
	}
}