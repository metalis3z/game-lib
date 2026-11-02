--credit to leon games studio
return {
	GrowData = {
		GrowRate = 0.5,
		BaseWeight = 1.5,
		GrowTickTime = NumberRange.new(4.8, 6)
	},
	InitFruit = function(p1, p2, p3) --[[ InitFruit | Line: 9 ]]
		local v1 = Random.new(p2)
		local v2 = 1.6 * p3
		local v3 = 0.6 * p3
		local v4 = 0.18 * p3
		local v5 = 0.7 * p3
		local v6 = 0.4 * p3
		local v7 = 0.1 * p3
		local v8 = Color3.fromRGB(90, 60, 40)
		local v9 = Color3.fromRGB(70, 45, 30)
		local v10 = Color3.fromRGB(50, 170, 50)
		local v11 = Color3.fromRGB(35, 140, 35)
		local t = {
			Color3.fromRGB(200, 35, 35),
			Color3.fromRGB(170, 0, 0),
			Color3.fromRGB(255, 0, 0),
			Color3.fromRGB(100, 170, 50),
			Color3.fromRGB(255, 0, 0)
		}

		local function CreateBasePart() --[[ CreateBasePart | Line: 36 ]]
			local Part = Instance.new("Part")

			Part.Material = Enum.Material.Glacier
			Part.MaterialVariant = "2022 Stud"
			Part.Anchored = true
			Part.CanCollide = false

			return Part
		end

		local v13 = v1:NextInteger(1, 3)

		if v1:NextInteger(1, 5) == 1 then
			v13 = v1:NextInteger(4, 5)
		end

		local v15, v16, v17 = t[v13]:ToHSV()
		local v23 = Color3.fromHSV((v15 + v1:NextNumber(-0.02, 0.02)) % 1, math.clamp(v16 + v1:NextNumber(-0.1, 0.1), 0.5, 1), (math.clamp(v17 + v1:NextNumber(-0.1, 0.1), 0.6, 1)))
		local v24 = v1:NextNumber(0.9, 1.1)
		local v25 = v2 * v24
		local v26 = v2 * v24 * v1:NextNumber(0.88, 0.95)
		local Part = Instance.new("Part")

		Part.Material = Enum.Material.Glacier
		Part.MaterialVariant = "2022 Stud"
		Part.Anchored = true
		Part.CanCollide = false
		Part.Shape = Enum.PartType.Ball
		Part.Size = Vector3.new(v25, v26, v25)
		Part.Color = v23
		Part.Position = p1.PrimaryPart.Position + Vector3.new(0, -v26 / 2, 0)

		local v27 = 0 + 1

		Part.Name = tostring(v27 + 1)
		Part.Parent = p1

		local Part2 = Instance.new("Part")

		Part2.Material = Enum.Material.Glacier
		Part2.MaterialVariant = "2022 Stud"
		Part2.Anchored = true
		Part2.CanCollide = false
		Part2.Shape = Enum.PartType.Block
		Part2.Size = Vector3.new(v4, v3, v4)
		Part2.Color = v8:Lerp(v9, v1:NextNumber(0, 0.4))
		Part2.Position = Part.Position + Vector3.new(0, v26 / 2 + v3 / 2 - 0.05, 0)
		Part2.Name = tostring(v27)
		Part2.Parent = p1

		local v28 = v27 + 1

		Part.Name = tostring(v28)

		local v29 = v28 + 1
		local Part3 = Instance.new("Part")

		Part3.Material = Enum.Material.Glacier
		Part3.MaterialVariant = "2022 Stud"
		Part3.Anchored = true
		Part3.CanCollide = false
		Part3.Shape = Enum.PartType.Block
		Part3.Size = Vector3.new(v4 * 1.3, v3 * 0.2, v4 * 1.3)
		Part3.Color = v9
		Part3.Position = Part2.Position + Vector3.new(0, v3 / 2 + v3 * 0.2 / 2, 0)
		Part3.Name = tostring(v29)
		Part3.Parent = p1

		local v30 = v1:NextInteger(0, 360)
		local v31 = v1:NextInteger(35, 55)
		local Part4 = Instance.new("Part")

		Part4.Material = Enum.Material.Glacier
		Part4.MaterialVariant = "2022 Stud"
		Part4.Anchored = true
		Part4.CanCollide = false
		Part4.Shape = Enum.PartType.Block
		Part4.Size = Vector3.new(v6, v5, v7)
		Part4.Color = v10:Lerp(v11, v1:NextNumber(0, 0.3))
		Part4.CFrame = CFrame.new(Part2.Position + Vector3.new(0, v3 * 0.3, 0)) * CFrame.Angles(0, math.rad(v30), 0) * CFrame.Angles(math.rad(v31), 0, 0) * CFrame.new(0, v5 / 2, 0)

		local v32 = v29 + 1

		Part4.Name = tostring(v32)
		Part4.Parent = p1

		local Part5 = Instance.new("Part")

		Part5.Material = Enum.Material.Glacier
		Part5.MaterialVariant = "2022 Stud"
		Part5.Anchored = true
		Part5.CanCollide = false
		Part5.Shape = Enum.PartType.Wedge
		Part5.Size = Vector3.new(v7, v5 * 0.4, v6)
		Part5.Color = Part4.Color
		Part5.CFrame = Part4.CFrame * CFrame.new(0, v5 / 2 + v5 * 0.4 / 2, 0) * CFrame.Angles(0, -1.5707963267948966, 0)

		local v33 = v32 + 1

		Part5.Name = tostring(v33)
		Part5.Parent = p1

		local Part6 = Instance.new("Part")

		Part6.Size = Vector3.new(0.1, 0.1, 0.1)
		Part6.Position = Part.Position + Vector3.new(0, v26 / 2 + 1, 0)
		Part6.Anchored = true
		Part6.CanCollide = false
		Part6.Transparency = 1
		Part6:SetAttribute("DontShow", true)
		Part6.Name = tostring(v33 + 1)
		Part6.Parent = p1
		p1:SetAttribute("CorePartName", "Apple")
		p1:AddTag("InitializationComplete")
	end,
	BeginFruitGrowth = function(p1) --[[ BeginFruitGrowth | Line: 148 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 171 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("CorePartName")
			local v2 = p1:GetAttribute("Age") or 0
			local v3 = p1:GetAttribute("MaxAge") or 1
			local v4 = v2 / v3

			for v5, v6 in t do
				if not v6.part:GetAttribute("DontShow") then
					local v8 = math.clamp((v4 - v6.partAge / v3) * v3, 0, 1)

					if v8 > 0 then
						local v9 = v6.maxSize * v8

						v6.part.Size = v9

						if v6.part.Name == v1 then
							v6.part.CFrame = PrimaryPart.CFrame * v6.centerOffset * CFrame.new(0, (v6.maxSize.Y - v9.Y) / 2, 0)
						else
							v6.part.CFrame = PrimaryPart.CFrame * v6.centerOffset * CFrame.new(0, -((v6.maxSize.Y - v9.Y) / 2), 0)
						end

						v6.part.Transparency = v6.part:GetAttribute("OG_Transparency") or 0
						v6.part.CanCollide = true

						continue
					end

					v6.part.Transparency = 1
					v6.part.CanCollide = false
				end
			end
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	OnFullyGrown = function(p1) --[[ OnFullyGrown | Line: 211 ]]
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
		FruitType = "Apple",
		Harvestable = true
	}
}