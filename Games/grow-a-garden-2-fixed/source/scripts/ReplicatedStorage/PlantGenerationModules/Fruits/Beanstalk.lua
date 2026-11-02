--credit to prince games studio
return {
	GrowData = {
		GrowRate = 0.06,
		BaseWeight = 1.5,
		GrowTickTime = NumberRange.new(4.8, 6)
	},
	InitFruit = function(p1, p2, p3) --[[ InitFruit | Line: 9 ]]
		local v1 = Random.new(p2)
		local v2 = p1:FindFirstChild("1")

		v2.Name = "2"

		local v3 = 2 + p3 * 0.25
		local v4 = 3 + p3 * 5
		local v5 = 2 + p3 * 0.25

		v2.CFrame = v2.CFrame * CFrame.new(0, -v4 / 2, 0)
		v2.Size = Vector3.new(v5, 0.5, v4)

		local v6 = v2:Clone()

		v6.Size = Vector3.new(0.25 * p3, v3, v4)
		v6.CFrame = v2.CFrame * CFrame.new(v6.Size.X / 2 + v2.Size.X / 2, (v6.Size.Y - v2.Size.Y) / 2, 0)
		v6.Name = "3"
		v6.Parent = p1

		local v7 = v2:Clone()

		v7.Size = Vector3.new(0.25 * p3, v3, v4)
		v7.CFrame = v2.CFrame * CFrame.new(-(v7.Size.X / 2 + v2.Size.X / 2), (v7.Size.Y - v2.Size.Y) / 2, 0)
		v7.Name = "4"
		v7.Parent = p1

		local v8 = v2:Clone()

		v8.Size = Vector3.new(v5, v3, 0.25 * p3)
		v8.CFrame = v2.CFrame * CFrame.new(0, (v8.Size.Y - v2.Size.Y) / 2, -(v8.Size.Z / 2 + v2.Size.Z / 2))
		v8.Name = "5"
		v8.Parent = p1

		local v9 = v2:Clone()

		v9.Size = Vector3.new(v5, v3, 0.25 * p3)
		v9.CFrame = v2.CFrame * CFrame.new(0, (v9.Size.Y - v2.Size.Y) / 2, v9.Size.Z / 2 + v2.Size.Z / 2)
		v9.Name = "6"
		v9.Parent = p1

		local v10 = v1:NextInteger(27, 34) * 0.01
		local Size = v2.Size
		local v13 = math.max(1, (math.round(Size.Z / Size.X)))
		local v14 = Size.Z / v13
		local v15 = Size.Z / 2
		local count, count2, v16 = 0, 4, v14

		for i = 1, v13 do
			local v17

			count = count + 1

			local Part = Instance.new("Part")

			Part.Shape = Enum.PartType.Ball
			Part.Size = Vector3.new(v14, v14, v14)
			Part.Anchored = true
			Part.CanCollide = false
			Part.Material = v2.Material
			Part.Color = v2.Color

			local v18 = count * 0.1 % 2

			v17 = if v18 <= 1 then v18 else 2 - v18
			Part.Color = Color3.fromHSV(v10 - 0.025 + v17 * 0.025, 0.5 + v17 * 0.175, 0.5 + v17 * 0.25)
			Part.CFrame = v2.CFrame * CFrame.new(0, v14 / 2 - v2.Size.Y / 4, -v15 + v16 / 2 + (i - 1) * v16)
			count2 = count2 + 1
			Part.Name = tostring(count2)
			Part.Parent = p1
		end

		v2.CFrame = v2.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
		v2.Size = Vector3.new(v2.Size.X, v2.Size.Z, v2.Size.Y)
		v2.CFrame = v2.CFrame * CFrame.Angles(0, 0, math.pi)

		for v19, v20 in p1:GetDescendants() do
			if v20:IsA("BasePart") then
				v20.Anchored = true
			end
		end

		p1:SetAttribute("CorePartName", "Beanstalk")
		p1:AddTag("InitializationComplete")
	end,
	BeginFruitGrowth = function(p1) --[[ BeginFruitGrowth | Line: 121 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}

		for v1, v2 in p1:GetDescendants() do
			local v4 = tonumber(v2.Name)

			if (v2:IsA("BasePart") or v2:IsA("UnionOperation")) and v4 then
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

		local function updateGrowth() --[[ updateGrowth | Line: 144 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v2 = math.clamp((p1:GetAttribute("Age") or 0) / (p1:GetAttribute("MaxAge") or 1), 0, 1)

			for v3, v4 in t do
				if not v4.part:GetAttribute("DontShow") then
					if v2 > 0 then
						v4.part.Size = v4.maxSize * v2
						v4.part.CFrame = PrimaryPart.CFrame * CFrame.new(v4.centerOffset.Position * v2) * v4.centerOffset.Rotation
						v4.part.Transparency = v4.part:GetAttribute("OG_Transparency") or 0
						v4.part.CanCollide = true

						continue
					end

					v4.part.Transparency = 1
					v4.part.CanCollide = false
				end
			end
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	Extras = {
		FruitType = "Beanstalk",
		Harvestable = true
	}
}