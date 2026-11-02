--credit to leon games studio
return {
	GrowData = {
		GrowRate = 0.1167,
		BaseWeight = 1.5,
		GrowTickTime = NumberRange.new(4.8, 6)
	},
	InitFruit = function(p1, p2, p3) --[[ InitFruit | Line: 9 ]]
		local v1 = Random.new(p2)
		local v2 = p3 * 0.75 + 0.25
		local v3 = v2 + v2 ^ 3 * 5e-7
		local v4 = 1.6 * v3
		local v5 = 0.6 * v3
		local v6 = 0.18 * v3
		local v7 = 0.7 * v3
		local v8 = 0.4 * v3
		local v9 = 0.1 * v3
		local v10 = Color3.fromRGB(90, 60, 40)
		local v11 = Color3.fromRGB(70, 45, 30)
		local v12 = Color3.fromRGB(50, 170, 50)
		local v13 = Color3.fromRGB(35, 140, 35)
		local t = {
			Color3.fromRGB(200, 35, 35),
			Color3.fromRGB(170, 0, 0),
			Color3.fromRGB(255, 0, 0),
			Color3.fromRGB(100, 170, 50),
			Color3.fromRGB(255, 0, 0)
		}

		local function CreateBasePart() --[[ CreateBasePart | Line: 40 ]]
			local Part = Instance.new("Part")

			Part.Material = Enum.Material.Glacier
			Part.MaterialVariant = "2022 Stud"
			Part.Anchored = true
			Part.CanCollide = false

			return Part
		end

		local v15 = v1:NextInteger(1, 3)

		if v1:NextInteger(1, 5) == 1 then
			v15 = v1:NextInteger(4, 5)
		end

		local v17, v18, v19 = t[v15]:ToHSV()
		local v25 = Color3.fromHSV((v17 + v1:NextNumber(-0.02, 0.02)) % 1, math.clamp(v18 + v1:NextNumber(-0.1, 0.1), 0.5, 1), (math.clamp(v19 + v1:NextNumber(-0.1, 0.1), 0.6, 1)))
		local v26 = v1:NextNumber(0.9, 1.1)
		local v27 = v4 * v26
		local v28 = v4 * v26 * v1:NextNumber(0.88, 0.95)
		local Part = Instance.new("Part")

		Part.Material = Enum.Material.Glacier
		Part.MaterialVariant = "2022 Stud"
		Part.Anchored = true
		Part.CanCollide = false
		Part.Shape = Enum.PartType.Ball
		Part.Size = Vector3.new(v27, v28, v27)
		Part.Color = v25
		Part.Position = p1.PrimaryPart.Position + Vector3.new(0, -v28 / 2, 0)

		local v29 = 0 + 1

		Part.Name = tostring(v29 + 1)
		Part.Parent = p1

		local Part2 = Instance.new("Part")

		Part2.Material = Enum.Material.Glacier
		Part2.MaterialVariant = "2022 Stud"
		Part2.Anchored = true
		Part2.CanCollide = false
		Part2.Shape = Enum.PartType.Block
		Part2.Size = Vector3.new(v6, v5, v6)
		Part2.Color = v10:Lerp(v11, v1:NextNumber(0, 0.4))
		Part2.Position = Part.Position + Vector3.new(0, v28 / 2 + v5 / 2 - 0.05, 0)
		Part2.Name = tostring(v29)
		Part2.Parent = p1

		local v30 = v29 + 1

		Part.Name = tostring(v30)

		local v31 = v30 + 1
		local Part3 = Instance.new("Part")

		Part3.Material = Enum.Material.Glacier
		Part3.MaterialVariant = "2022 Stud"
		Part3.Anchored = true
		Part3.CanCollide = false
		Part3.Shape = Enum.PartType.Block
		Part3.Size = Vector3.new(v6 * 1.3, v5 * 0.2, v6 * 1.3)
		Part3.Color = v11
		Part3.Position = Part2.Position + Vector3.new(0, v5 / 2 + v5 * 0.2 / 2, 0)
		Part3.Name = tostring(v31)
		Part3.Parent = p1

		local v32 = v1:NextInteger(0, 360)
		local v33 = v1:NextInteger(35, 55)
		local Part4 = Instance.new("Part")

		Part4.Material = Enum.Material.Glacier
		Part4.MaterialVariant = "2022 Stud"
		Part4.Anchored = true
		Part4.CanCollide = false
		Part4.Shape = Enum.PartType.Block
		Part4.Size = Vector3.new(v8, v7, v9)
		Part4.Color = v12:Lerp(v13, v1:NextNumber(0, 0.3))
		Part4.CFrame = CFrame.new(Part2.Position + Vector3.new(0, v5 * 0.3, 0)) * CFrame.Angles(0, math.rad(v32), 0) * CFrame.Angles(math.rad(v33), 0, 0) * CFrame.new(0, v7 / 2, 0)

		local v34 = v31 + 1

		Part4.Name = tostring(v34)
		Part4.Parent = p1

		local Part5 = Instance.new("Part")

		Part5.Material = Enum.Material.Glacier
		Part5.MaterialVariant = "2022 Stud"
		Part5.Anchored = true
		Part5.CanCollide = false
		Part5.Shape = Enum.PartType.Wedge
		Part5.Size = Vector3.new(v9, v7 * 0.4, v8)
		Part5.Color = Part4.Color
		Part5.CFrame = Part4.CFrame * CFrame.new(0, v7 / 2 + v7 * 0.4 / 2, 0) * CFrame.Angles(0, -1.5707963267948966, 0)

		local v35 = v34 + 1

		Part5.Name = tostring(v35)
		Part5.Parent = p1

		local Part6 = Instance.new("Part")

		Part6.Size = Vector3.new(0.1, 0.1, 0.1)
		Part6.Position = Part.Position + Vector3.new(0, v28 / 2 + 1, 0)
		Part6.Anchored = true
		Part6.CanCollide = false
		Part6.Transparency = 1
		Part6:SetAttribute("DontShow", true)
		Part6.Name = tostring(v35 + 1)
		Part6.Parent = p1
		p1:AddTag("InitializationComplete")
	end,
	BeginFruitGrowth = function(p1) --[[ BeginFruitGrowth | Line: 151 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 174 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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
		FruitType = "Apple",
		Harvestable = true
	}
}