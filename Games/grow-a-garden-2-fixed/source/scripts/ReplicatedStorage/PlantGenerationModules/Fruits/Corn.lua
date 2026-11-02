--credit to prince games studio
game:GetService("MaterialService")

return {
	GrowData = {
		GrowRate = 0.0444,
		BaseWeight = 3,
		GrowTickTime = NumberRange.new(4.8, 6)
	},
	InitFruit = function(p1, p2, p3) --[[ InitFruit | Line: 10 ]]
		local MaterialService = game:GetService("MaterialService")
		local v1 = (p3 or 1) * 0.5 + 0.5
		local v3 = Random.new(p2)
		local Base = p1.Base

		local function GetRandomHSV(p1, p2) --[[ GetRandomHSV | Line: 25 | Upvalues: v3 (copy) ]]
			local v1, v2, v32 = p1:ToHSV()
			local v4 = p2 or 0.05
			local v6 = math.clamp(v1 + v3:NextNumber(-v4, v4), 0, 0.99)

			return Color3.fromHSV(v6, v2, v32), v6, v2, v32
		end

		local v4, v5 = Color3.fromRGB(51, 136, 5)
		local v6, v7, v8 = v4:ToHSV()
		local v9 = v5 or 0.05

		Color3.fromHSV(math.clamp(v6 + v3:NextNumber(-v9, v9), 0, 0.99), v7, v8)

		local function CreatePart(p12, p2, p3) --[[ CreatePart | Line: 35 | Upvalues: p1 (copy), MaterialService (copy) ]]
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

		local Corn = p1.Corn
		local v12, v13 = Color3.fromRGB(255, 243, 0)
		local v14, v15, v16 = v12:ToHSV()
		local v17 = v13 or 0.05
		local v20 = Color3.fromHSV(math.clamp(v14 + v3:NextNumber(-v17, v17), 0, 0.99), v15, v16)
		local v21 = if v3:NextInteger(1, 700) == 1 then Color3.new(0.666667, 0.333333, 1) else v20

		if v3:NextInteger(1, 7000) == 1 then
			v21 = Color3.new(255/255, 255/255, 255/255)
		end

		local v24 = p1["1"]
		local v25 = v3:NextInteger(3, 4)
		local v26 = Corn:GetPivot()

		Corn:PivotTo(v26 * CFrame.Angles(math.rad((v3:NextNumber(-5, 5))), math.rad((v3:NextNumber(-45, 45))), 0))

		for v30, v31 in Corn:GetChildren() do
			local Angles2 = CFrame.Angles

			v31.CFrame = v31.CFrame * Angles2(0, math.rad((v3:NextNumber(-5, 5))), 0)
			v31.Color = v21
			v31.Parent = p1
		end

		for i = 1, v25 do
			local v34 = script.FlowerPetal:Clone()
			local v35 = 360 / v25 * (i * v3:NextNumber(0.8, 1.2))

			v34.Parent = p1
			v34:PivotTo(v24.CFrame * CFrame.new(0, -v24.Size.Y / 2.25, 0) * CFrame.Angles(0, math.rad(v35), 0) * CFrame.Angles(1.3089969389957472, 0, 0))
			v34.Name = 2
		end

		Corn:Destroy()
		p1:ScaleTo(v1 + v1 ^ 3 * 1e-7)
		p1:AddTag("InitializationComplete")
	end,
	BeginFruitGrowth = function(p1) --[[ BeginFruitGrowth | Line: 100 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}

		for v1, v2 in p1:GetDescendants() do
			local v4 = tonumber(v2.Name)

			if (v2:IsA("BasePart") or v2:IsA("MeshPart")) and v4 then
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
		FruitType = "Corn",
		Harvestable = true
	}
}