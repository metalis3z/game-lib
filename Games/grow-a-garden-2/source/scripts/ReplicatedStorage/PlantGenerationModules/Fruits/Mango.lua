--credit to leon games studio
return {
	GrowData = {
		GrowRate = 0.031,
		BaseWeight = 3,
		GrowTickTime = NumberRange.new(4.8, 6)
	},
	InitFruit = function(p1, p2, p3) --[[ InitFruit | Line: 8 ]]
		local v1 = Random.new(p2)
		local Stud_Part = script.Stud_Part
		local v2 = 1 * (p3 * 0.5 + 0.5)
		local v3 = Color3.new(0.654902, 0.47451, 0.294118)
		local v4 = Stud_Part:Clone()

		v4.Size = Vector3.new(v2, 1 + p3 * 0.25, v2)
		v4.CFrame = p1.PrimaryPart.CFrame * CFrame.new(0, -(p1.PrimaryPart.Size.Y / 2 + v4.Size.Y / 2), 0)

		local count = 1

		v4.Color = v3
		v4.Name = tostring(count)
		v4.Parent = p1

		local v5 = 1.5 + p3
		local v6 = 0.75 * (p3 * 0.5 + 0.5)
		local v7 = v5 * 0.4
		local v8 = v5 * 1.35
		local v9 = v5 * 0.95
		local v10 = 1 * (10 + (p3 * 0.1 - 0.9))
		local v11 = v1:NextNumber()
		local v12, v13

		if v11 < 1e-7 then
			v12 = 0.92
			v13 = 0.92
		elseif v11 < 0.00001 then
			v12 = 0.6
			v13 = 0.6
		else
			local v14 = v1:NextNumber()
			local v15, v16

			if v14 < 0.6 then
				v15 = 0
				v16 = 0.083
			elseif v14 < 0.8 then
				v15 = 0.083
				v16 = 0.166
			elseif v14 < 0.95 then
				v15 = 0.166
				v16 = 0.25
			else
				v15 = 0.25
				v16 = 0.333
			end

			local v17 = v1:NextInteger(1, 3)

			if v17 == 1 then
				v12 = v16
				v13 = v15
			elseif v17 == 2 then
				v12 = v15
				v13 = v16
			else
				local v18 = (v15 + v16) * 0.5

				v12 = v18
				v13 = v18
			end
		end

		local v19 = v4.CFrame
		local Size = v4.Size

		for i = 1, v10 do
			local v20
			local v21 = i / v10

			if v21 <= 0.65 then
				v20 = v7 + (v8 - v7) * math.sin(v21 / 0.65 * math.pi * 0.5)
			else
				local v22 = (v21 - 0.65) / 0.35

				v20 = v8 - (v8 - v9) * (v22 * v22)
			end

			local v23 = Stud_Part:Clone()

			v23.Color = Color3.fromHSV(v13 + (v12 - v13) * v21, 1, 1)
			v23.Size = Vector3.new(v20, v6 * (0.3 + 0.6 * ((v20 - v7) / (v8 - v7))), v20)
			count = count + 1
			v23.Name = tostring(count)
			v23.CFrame = v19 * CFrame.new(0, -(Size.Y / 2 + v23.Size.Y / 2), 0)
			v23.Parent = p1
			v19 = v23.CFrame
			Size = v23.Size
		end

		local function AttachWedge_1(p12) --[[ AttachWedge_1 | Line: 115 | Upvalues: count (ref), Stud_Part (copy), p1 (copy) ]]
			count = count + 1

			local v1 = Stud_Part:Clone()

			v1.Size = Vector3.new(p12.Size.Z, p12.Size.Y * 0.5, p12.Size.X / 2)
			v1.Shape = Enum.PartType.Wedge
			v1.CFrame = p12.CFrame * CFrame.new(-p12.Size.X / 4, -(p12.Size.Y / 2 + v1.Size.Y / 2), 0)
			v1.Parent = p1
			v1.Color = p12.Color
			v1.CFrame = v1.CFrame * CFrame.Angles(0, 1.5707963267948966, 0)
			v1.CFrame = v1.CFrame * CFrame.Angles(0, 0, math.pi)
			v1.Name = tostring(count)

			local v5 = Stud_Part:Clone()

			v5.Size = Vector3.new(p12.Size.Z, p12.Size.Y * 0.5, p12.Size.X / 2)
			v5.Shape = Enum.PartType.Wedge
			v5.CFrame = p12.CFrame * CFrame.new(p12.Size.X / 4, -(p12.Size.Y / 2 + v5.Size.Y / 2), 0)
			v5.Parent = p1
			v5.Color = p12.Color
			v5.CFrame = v5.CFrame * CFrame.Angles(0, -1.5707963267948966, 0)
			v5.CFrame = v5.CFrame * CFrame.Angles(0, 0, math.pi)
			v5.Name = tostring(count)
		end

		local v24 = Stud_Part:Clone()
		local v25 = 3 + (p3 * 0.5 + 0.5)

		v24.Size = Vector3.new(v25, v25, v25 * 0.25)
		v24.CFrame = v4.CFrame * CFrame.new(0, v4.Size.Y / 2, 0)

		local Angles = CFrame.Angles

		v24.CFrame = v24.CFrame * Angles(0, math.rad((v1:NextInteger(-180, 180))), 0)

		local Angles2 = CFrame.Angles

		v24.CFrame = v24.CFrame * Angles2(math.rad((v1:NextInteger(47, 56))), 0, 0)
		v24.CFrame = v24.CFrame * CFrame.new(0, -(v24.Size.Y / 2), 0)
		v24.Color = Color3.fromHSV(0.333333, 1, 0.666667)

		local v31 = count + 1

		v24.Name = tostring(v31)
		v24.Parent = p1
		AttachWedge_1(v24)
		p1:ScaleTo(p3 * 0.1 + 0.9)
		p1:AddTag("InitializationComplete")
	end,
	BeginFruitGrowth = function(p1) --[[ BeginFruitGrowth | Line: 163 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 186 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0
			local v2 = p1:GetAttribute("MaxAge") or 1
			local v3 = v1 / v2

			for v4, v5 in t do
				if not v5.part:GetAttribute("DontShow") then
					local v7 = math.clamp((v3 - v5.partAge / v2) * v2, 0, 1)

					if v7 > 0 then
						v5.part.Size = v5.maxSize * v7
						v5.part.CFrame = PrimaryPart.CFrame * v5.centerOffset * CFrame.new(0, v5.maxSize.Y / 2 * (1 - v7), 0)
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
	OnFullyGrown = function(p1) --[[ OnFullyGrown | Line: 218 ]]
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