--credit to leon games studio
local MaterialService = game:GetService("MaterialService")

return {
	GrowData = {
		GrowRate = 0.0095,
		BaseWeight = 2.1,
		GrowTickTime = NumberRange.new(4.8, 6)
	},
	InitFruit = function(p1, p2, p3) --[[ InitFruit | Line: 10 | Upvalues: MaterialService (copy) ]]
		local v1 = Random.new(p2)

		local function GetRandomHSV(p1, p2) --[[ GetRandomHSV | Line: 16 | Upvalues: v1 (copy) ]]
			local v12, v2, v3 = p1:ToHSV()
			local v4 = p2 or 0.05
			local v5 = v12 + v1:NextNumber(-v4, v4)

			return Color3.fromHSV(v5, v2, v3), v5, v2, v3
		end

		local v2 = Color3.fromRGB(74, 112, 33)

		local function CreatePart(p12, p2, p3) --[[ CreatePart | Line: 26 | Upvalues: p1 (copy), MaterialService (ref) ]]
			local Part = Instance.new("Part")
			local v1 = p12 or "Studs"

			Part.Parent = p1
			Part.TopSurface = Enum.SurfaceType[v1]
			Part.BackSurface = Enum.SurfaceType[v1]
			Part.FrontSurface = Enum.SurfaceType[v1]
			Part.BottomSurface = Enum.SurfaceType[v1]
			Part.LeftSurface = Enum.SurfaceType[v1]
			Part.RightSurface = Enum.SurfaceType[v1]
			Part.Anchored = true
			Part.CanCollide = false
			Part.Transparency = 0

			if p3 then
				Part.Shape = Enum.PartType[p3]
			end

			if p2 then
				Part.MaterialVariant = p2

				local v2 = MaterialService:FindFirstChild(p2, true)

				if not v2 then
					return Part
				end

				Part.Material = v2.BaseMaterial
			end

			return Part
		end

		local v3 = v1:NextNumber(0.25, 0.35) * (p3 or 1)
		local v4 = Vector3.new(v3, 1.8, v3)
		local v5 = p1.Base.CFrame
		local v6 = 1.8

		for i = 1, 2 do
			local v7 = CreatePart(nil, "2022 Weld")

			v7.Size = v4

			local Angles = CFrame.Angles
			local v9 = math.rad((v1:NextNumber(-30, -15)))
			local v10 = v1:NextNumber(-6, 6)

			v7.CFrame = v5 * Angles(v9, 0, (math.rad(v10))) * CFrame.new(0, v4.Y / 2.2, 0)
			v7.Color = v2
			v7.Name = tostring(i)
			v5 = v7.CFrame * CFrame.new(0, v4.Y / 2.2, 0)
			v6 = math.clamp(v6 * 1.5, 0, 2.25)

			if i == 2 then
				local sum

				sum = -90

				for j = 1, 3 do
					local v12 = script.Leaf:Clone()

					v12.Parent = p1

					local v13 = v7.CFrame * CFrame.Angles(0, math.pi, (math.rad(sum)))
					local v17 = v13 * CFrame.new(0, j % 2 == 0 and v7.Size.Y / 2.5 or 0, 0)

					v12:PivotTo(v17 * CFrame.Angles(math.rad((v1:NextNumber(10, 25))), 0, (math.rad((v1:NextNumber(-10, 10))))))
					v12.Size = v12.Size * v1:NextNumber(0.9, 1.05)
					v12.Name = 3
					v12:AddTag("PoisonIvy")
					sum = sum + 90
				end
			end

			v4 = Vector3.new(v4.X * 0.85, v6, v4.Z * 0.85)
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginFruitGrowth = function(p1) --[[ BeginFruitGrowth | Line: 100 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}

		for v1, v2 in p1:GetDescendants() do
			local v4 = tonumber(v2.Name)

			if v2:IsA("BasePart") and v4 then
				local v5 = not v2:GetAttribute("DontShow")
				local t2 = {}

				for v6, v7 in v2:GetChildren() do
					if v7:IsA("Decal") or v7:IsA("Texture") then
						table.insert(t2, {
							decal = v7,
							originalTransparency = v7.Transparency
						})

						if v5 then
							v7.Transparency = 1
						end
					end
				end

				table.insert(t, {
					part = v2,
					maxSize = v2.Size,
					centerOffset = PrimaryPart.CFrame:ToObjectSpace(v2.CFrame),
					partAge = v4,
					decals = t2
				})
				v2.CanCollide = false

				if v5 then
					v2.Transparency = 1
				end
			end
		end

		local function updateGrowth() --[[ updateGrowth | Line: 135 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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

						for v10, v11 in v5.decals do
							v11.decal.Transparency = v11.originalTransparency + (1 - v11.originalTransparency) * (1 - v7)
						end

						continue
					end

					v5.part.Transparency = 1
					v5.part.CanCollide = false

					for v12, v13 in v5.decals do
						v13.decal.Transparency = 1
					end
				end
			end
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	OnFullyGrown = function(p1) --[[ OnFullyGrown | Line: 170 ]]
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
		FruitType = "Poison Ivy",
		Harvestable = true
	}
}