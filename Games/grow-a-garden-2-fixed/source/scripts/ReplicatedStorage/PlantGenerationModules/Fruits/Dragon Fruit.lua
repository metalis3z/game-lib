--credit to quartz games studio
game:GetService("MaterialService")

local function ManualScale(p1, p2) --[[ ManualScale | Line: 3 ]]
	if p2 == 1 then
		return
	end

	local v1 = p1:GetPivot()

	for v2, v3 in p1:GetDescendants() do
		if v3:IsA("BasePart") then
			v3.Size = v3.Size * p2

			local v4 = v1:ToObjectSpace(v3.CFrame)

			v3.CFrame = v1 * CFrame.new(v4.Position * p2) * v4.Rotation

			continue
		end

		if v3:IsA("Attachment") then
			v3.Position = v3.Position * p2

			continue
		end

		if v3:IsA("SpecialMesh") then
			v3.Scale = v3.Scale * p2
			v3.Offset = v3.Offset * p2

			continue
		end

		if v3:IsA("Weld") or v3:IsA("Motor6D") then
			v3.C0 = CFrame.new(v3.C0.Position * p2) * v3.C0.Rotation
			v3.C1 = CFrame.new(v3.C1.Position * p2) * v3.C1.Rotation
		end
	end
end

return {
	GrowData = {
		GrowRate = 0.0061,
		BaseWeight = 3,
		GrowTickTime = NumberRange.new(4.8, 6)
	},
	InitFruit = function(p1, p2, p3) --[[ InitFruit | Line: 31 | Upvalues: ManualScale (copy) ]]
		local MaterialService = game:GetService("MaterialService")
		local v1 = (p3 or 1) * 0.5 + 0.5
		local v2 = Random.new(p2)
		local Base = p1.Base

		local function GetRandomHSV(p1, p2) --[[ GetRandomHSV | Line: 46 | Upvalues: v2 (copy) ]]
			local v1, v22, v3 = p1:ToHSV()
			local v4 = p2 or 0.05
			local v6 = math.clamp(v1 + v2:NextNumber(-v4, v4), 0, 0.99)

			return Color3.fromHSV(v6, v22, v3), v6, v22, v3
		end

		local v3, v4 = Color3.fromRGB(51, 136, 5)
		local v5, v6, v7 = v3:ToHSV()
		local v8 = v4 or 0.05

		Color3.fromHSV(math.clamp(v5 + v2:NextNumber(-v8, v8), 0, 0.99), v6, v7)

		local function CreatePart(p12, p2, p3) --[[ CreatePart | Line: 56 | Upvalues: p1 (copy), MaterialService (copy) ]]
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

		local v11 = p1["3"]

		v11.CFrame = v11.CFrame * CFrame.Angles(0, math.rad((v2:NextNumber(-180, 180))), 0)

		for i = 1, 4 do
			local v15 = p1["1"]
			local v16 = script.Leaf:Clone()

			v16.Parent = p1

			local v17 = v15.CFrame * CFrame.Angles(0, math.rad(i * 90), 0) * CFrame.new(0, -v15.Size.Y * 0.35, -v15.Size.Z / 2.5)

			v16:PivotTo(v17 * CFrame.Angles(math.rad((v2:NextNumber(45, 70))), 0, (math.rad((v2:NextNumber(-10, 10))))))
			v16.Name = 2
		end

		for j = 1, 4 do
			local v21 = 90 * (j * v2:NextNumber(0.8, 1.2))
			local v22 = p1["2"]
			local v23 = script.SmallLeaf:Clone()

			v23.Parent = p1

			local v24 = v22.CFrame * CFrame.Angles(0, math.rad(v21), 0) * CFrame.new(0, v22.Size.Y * 0.4, -v22.Size.Z / 2.5)

			v23:PivotTo(v24 * CFrame.Angles(math.rad((v2:NextNumber(15, 30))), 0, (math.rad((v2:NextNumber(-10, 10))))))
			v23.Name = 3
		end

		local v28 = v2:NextInteger(2, 4)

		for k = 1, v28 do
			local v29 = script.SpikeLeaf:Clone()

			v29.Parent = p1

			local v30 = 360 / v28 * (k * v2:NextNumber(0.8, 1.2))
			local v31 = p1["2"]

			v29.Name = 4
			v29.Size = v29.Size * v2:NextNumber(0.7, 1.1)

			local v32 = v31.CFrame * CFrame.Angles(0, math.rad(v30), 0)
			local Angles2 = CFrame.Angles
			local v33 = v2:NextNumber(15, 25)

			v29.CFrame = v32 * Angles2(math.rad(v33), 0, 0) * CFrame.new(0, v31.Size.Y / 2.25 + v29.Size.Y / 2, 0)
		end

		ManualScale(p1, v1 + v1 ^ 3 * 0.00001)
		p1:AddTag("InitializationComplete")
	end,
	BeginFruitGrowth = function(p1) --[[ BeginFruitGrowth | Line: 130 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 165 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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
	OnFullyGrown = function(p1) --[[ OnFullyGrown | Line: 200 ]]
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