--credit to quartz games studio
return {
	GrowData = {
		GrowRate = 0.0513,
		BaseWeight = 2,
		GrowTickTime = NumberRange.new(4.8, 6)
	},
	InitFruit = function(p1, p2, p3) --[[ InitFruit | Line: 9 ]]
		local v1 = Random.new(p2)
		local v2 = p3 * 0.25 + 0.75
		local v4 = 1 * (math.random(8, 12) * 0.1)
		local v5 = 2 * (math.random(8, 12) * 0.1)
		local v6 = 0.25 * (math.random(8, 12) * 0.1)
		local v7 = 5 * (math.random(8, 12) * 0.1)
		local v8 = Color3.fromRGB(76, 51, 34)
		local v9 = Vector3.new(0, 0, 0)
		local v10 = 0

		local function CreateBasePart() --[[ CreateBasePart | Line: 30 ]]
			local Part = Instance.new("Part")

			Part.Material = Enum.Material.Glacier
			Part.MaterialVariant = "2022 Stud"
			Part.Anchored = true
			Part.CanCollide = false

			return Part
		end

		local Part = Instance.new("Part")

		Part.Material = Enum.Material.Glacier
		Part.MaterialVariant = "2022 Stud"
		Part.Anchored = true
		Part.CanCollide = false
		Part.Size = Vector3.new(v6, v5, v6)
		Part.Color = v8
		Part.Position = p1.PrimaryPart.Position + Vector3.new(0, v5 / 2, 0)

		local count = 1
		local v11 = count

		Part.Name = tostring(v11)
		Part.Parent = p1

		local function GenerateCircle(p12, p2, p3, p4) --[[ GenerateCircle | Line: 49 | Upvalues: v1 (copy), v4 (copy), count (ref), p1 (copy), v9 (ref), v10 (ref) ]]
			local v12 = 6.283185307179586 / p3

			for i = 1, p3 do
				local v2 = v12 * i + p4
				local v3 = math.cos(v2) * p2
				local v42 = math.sin(v2) * p2
				local Part = Instance.new("Part")

				Part.Material = Enum.Material.Glacier
				Part.MaterialVariant = "2022 Stud"
				Part.Anchored = true
				Part.CanCollide = false
				Part.Shape = Enum.PartType.Ball

				local v5 = v1:NextInteger(90, 110) * 0.01

				Part.Size = Vector3.new(v4, v4, v4) * v5
				Part.Position = p12 + Vector3.new(v3 + v1:NextInteger(-5, 5) * 0.01, v1:NextInteger(-5, 5) * 0.01, v42 + v1:NextInteger(-5, 5) * 0.01)
				Part.Color = Color3.fromHSV(v1:NextInteger(70, 80) * 0.01, 0.67, 1)
				count = count + 1
				Part.Name = tostring(count)
				Part.Parent = p1
				v9 = v9 + Part.Position
				v10 = v10 + 1
			end
		end

		local v13 = Part.Position + Vector3.new(0, -Part.Size.Y / 2, 0)
		local sum, v14 = 0, Part

		for i = v7 - 1, 0, -1 do
			local v15 = v1:NextInteger(-180, 180)
			local v16 = i * 0.25
			local v17 = 1
			local v18 = i + 4

			repeat
				if not (v16 * v17 >= 0.2) and v17 ~= 1 then
					break
				end

				if v18 * v17 >= 1 then
					GenerateCircle(v13 - Vector3.new(0, sum, 0), v16 * v17, math.floor(v18 * v17), v15)
				end

				v17 = v17 * 0.4
			until v17 < 0.4

			sum = sum + v4 * 0.75
		end

		local Part2 = Instance.new("Part")

		Part2.Size = Vector3.new(0.1, 0.1, 0.1)

		local v19 = v9.Y / v10 + 2

		Part2.Position = Vector3.new(v14.Position.X, v19, v14.Position.Z)
		Part2.Anchored = true
		Part2.CanCollide = false
		Part2.Transparency = 1
		Part2:SetAttribute("DontShow", true)
		count = count + 1

		local v20 = count

		Part2.Name = tostring(v20)
		Part2.Parent = p1
		p1:ScaleTo(v2 + v2 ^ 3 * 0.00001)
		p1:SetAttribute("CorePartName", "Grape")
		p1:AddTag("InitializationComplete")
	end,
	BeginFruitGrowth = function(p1) --[[ BeginFruitGrowth | Line: 126 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}

		for v1, v2 in p1:GetDescendants() do
			local v4 = tonumber(v2.Name)

			if v2:IsA("BasePart") and v4 then
				local v5 = not v2:GetAttribute("DontShow")
				local t2 = {}
				local v6 = PrimaryPart.CFrame:ToObjectSpace(v2.CFrame)
				local v7 = if v2.Shape == Enum.PartType.Ball then true else false

				t2[1] = v2
				t2[2] = v2.Size
				t2[3] = v6
				t2[4] = v4
				t2[5] = v7
				table.insert(t, t2)
				v2.CanCollide = false

				if v5 then
					v2.Transparency = 1
				end
			end
		end

		local function updateGrowth() --[[ updateGrowth | Line: 151 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0
			local v2 = p1:GetAttribute("MaxAge") or 1
			local v3 = v1 / v2

			for v4, v5 in t do
				local v6 = v5[1]
				local v7 = v5[2]
				local v8 = v5[3]
				local v9 = v5[4]
				local v10 = v5[5]

				if not v6:GetAttribute("DontShow") then
					local v11 = math.min((v3 - v9 / v2) * v2, 1)

					if v11 > 0 then
						if v10 then
							v6.Size = v7 * v11
							v6.CFrame = PrimaryPart.CFrame * v8
						else
							v6.Size = Vector3.new(v7.X, v7.Y * v11, v7.Z)
							v6.CFrame = PrimaryPart.CFrame * v8 * CFrame.new(0, (v6.Size.Y - v7.Y) / 2, 0)
						end

						v6.Transparency = v6:GetAttribute("OG_Transparency") or 0
						v6.CanCollide = true

						continue
					end

					v6.Transparency = 1
					v6.CanCollide = false
				end
			end
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	OnFullyGrown = function(p1) --[[ OnFullyGrown | Line: 196 ]]
		local v1 = p1:GetAttribute("CorePartName")

		if v1 then
			local v2 = p1:FindFirstChild(v1)

			if v2 then
				local Collect_PROX_Grape = game.ServerStorage:FindFirstChild("Collect_PROX_Grape")

				if Collect_PROX_Grape then
					local ProximityPrompt = Collect_PROX_Grape:Clone()

					ProximityPrompt.Name = "ProximityPrompt"
					ProximityPrompt.Parent = v2
				end
			end
		end

		p1:AddTag("PlantGenerated")
	end,
	Extras = {
		FruitType = "Grape",
		Harvestable = true
	}
}