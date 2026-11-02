--credit to prince games studio
game:GetService("MaterialService")

return {
	GrowData = {
		GrowRate = 0.0047,
		BaseWeight = 9,
		GrowTickTime = NumberRange.new(4.8, 6)
	},
	InitFruit = function(p1, p2, p3) --[[ InitFruit | Line: 10 ]]
		local MaterialService = game:GetService("MaterialService")
		local v2 = Random.new(p2)
		local Base = p1.Base

		local function GetRandomHSV(p1, p2) --[[ GetRandomHSV | Line: 20 | Upvalues: v2 (copy) ]]
			local v1, v22, v3 = p1:ToHSV()
			local v4 = p2 or 0.05
			local v6 = math.clamp(v1 + v2:NextNumber(-v4, v4), 0, 0.99)

			return Color3.fromHSV(v6, v22, v3), v6, v22, v3
		end

		local v3, v4 = Color3.fromRGB(51, 136, 5)
		local v5, v6, v7 = v3:ToHSV()
		local v8 = v4 or 0.05

		Color3.fromHSV(math.clamp(v5 + v2:NextNumber(-v8, v8), 0, 0.99), v6, v7)

		local function CreatePart(p12, p2, p3) --[[ CreatePart | Line: 30 | Upvalues: p1 (copy), MaterialService (copy) ]]
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

			for k, v in pairs(script:GetChildren()) do
				if v:IsA("Texture") then
					v:Clone().Parent = Part
				end
			end

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

		local function GetColorWithRange(p1, p2) --[[ GetColorWithRange | Line: 66 ]]
			local v1, v2, v3 = p1:ToHSV()

			return Color3.fromHSV(v1 + p2, v2, v3)
		end

		local Moon = p1.Moon
		local Anthers = p1.Anthers
		local v11 = Color3.fromRGB(255, 255, 255)

		if v2:NextInteger(1, 3) == 1 then
			v11 = v2:NextInteger(1, 2) == 1 and Color3.fromRGB(35, 55, 163) or Color3.fromRGB(34, 180, 248)
		end

		for v13, v14 in Moon:GetChildren() do
			v14.Color = v11
			v14.Parent = p1
		end

		Moon:Destroy()

		for v15, v16 in p1.Leaves:GetChildren() do
			if v16:IsA("Model") then
				local v17 = v16:GetPivot()

				v16:PivotTo(v17 * CFrame.Angles(math.rad((v2:NextNumber(-10, 10))), 0, (math.rad((v2:NextNumber(-10, 10))))))

				for v21, v22 in v16:GetChildren() do
					v22.Parent = p1
				end

				v16:Destroy()

				continue
			end

			local v23 = v16:GetPivot()

			v16:PivotTo(v23 * CFrame.Angles(math.rad((v2:NextNumber(-6, 6))), 0, (math.rad((v2:NextNumber(-20, 20))))))
			v16.Parent = p1
		end

		for v27, v28 in Anthers:GetChildren() do
			local v29 = v28:GetPivot()

			v28:PivotTo(v29 * CFrame.Angles(math.rad((v2:NextNumber(-10, 10))), 0, (math.rad((v2:NextNumber(-15, 25))))))

			for v33, v34 in v28:GetChildren() do
				v34.Parent = p1
			end
		end

		local v35 = v2:NextInteger(2, 4)
		local v36 = p1["1"]

		for i = 1, v35 do
			local v37 = script.Leaf:Clone()

			v37.Parent = p1

			local v38 = 45 + 360 / v35 * (i * v2:NextNumber(0.9, 1, 1))
			local v39 = v36.CFrame * CFrame.new(0, v36.Size.Y / 2.5, 0)
			local Angles = CFrame.Angles
			local v40 = math.rad(v38)

			v37:PivotTo(v39 * Angles(0, v40, (math.rad((v2:NextNumber(97.5, 110))))))
			v37.Name = 2
		end

		Anthers:Destroy()

		local v42 = v2:NextNumber(-0.1, 0.1)

		for v43, v44 in p1:GetChildren() do
			if tonumber(v44.Name) and v44.Color ~= Color3.fromRGB(255, 255, 255) then
				local v46, v47, v48 = v44.Color:ToHSV()

				v44.Color = Color3.fromHSV(v46 + v42, v47, v48)
			end
		end

		local v49 = (p3 or 1) * 0.25 + 0.75

		p1:ScaleTo(v49 + v49 ^ 3 * 1e-6)
		p1:AddTag("InitializationComplete")
	end,
	BeginFruitGrowth = function(p1) --[[ BeginFruitGrowth | Line: 144 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 179 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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
	OnFullyGrown = function(p1) --[[ OnFullyGrown | Line: 214 ]]
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