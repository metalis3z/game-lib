--credit to leon games studio
return {
	GrowData = {
		GrowRate = 0.06,
		BaseWeight = 0.5,
		GrowTickTime = NumberRange.new(4.8, 6)
	},
	InitFruit = function(p1, p2, p3) --[[ InitFruit | Line: 8 ]]
		local v1 = Random.new(p2)
		local v2 = p1:FindFirstChild("1")

		v2.Name = "2"
		v2.CFrame = v2.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
		v2.CFrame = v2.CFrame * CFrame.Angles(0, 0, 1.5707963267948966)

		local v3 = 0.16 + p3 ^ 3 * 1e-6
		local v4 = (2 + p3 * 0.25) * v3
		local v5 = (3 + p3 * 5) * v3
		local v6 = (2 + p3 * 0.25) * v3
		local v7 = 0.25 * v3

		v2.CFrame = v2.CFrame * CFrame.new(0, 0, -(v4 * 0.5))
		v2.Size = Vector3.new(v6, 0.5 * v3, v5)

		local v8 = v2:Clone()

		v8.Size = Vector3.new(v7, v4, v5)
		v8.CFrame = v2.CFrame * CFrame.new(v8.Size.X / 2 + v2.Size.X / 2, (v8.Size.Y - v2.Size.Y) / 2, 0)
		v8.Name = "3"
		v8.Parent = p1

		local v9 = v2:Clone()

		v9.Size = Vector3.new(v7, v4, v5)
		v9.CFrame = v2.CFrame * CFrame.new(-(v9.Size.X / 2 + v2.Size.X / 2), (v9.Size.Y - v2.Size.Y) / 2, 0)
		v9.Name = "4"
		v9.Parent = p1

		local v10 = v2:Clone()

		v10.Size = Vector3.new(v6, v4, v7)
		v10.CFrame = v2.CFrame * CFrame.new(0, (v10.Size.Y - v2.Size.Y) / 2, -(v10.Size.Z / 2 + v2.Size.Z / 2))
		v10.Name = "5"
		v10.Parent = p1

		local v11 = v2:Clone()

		v11.Size = Vector3.new(v6, v4, v7)
		v11.CFrame = v2.CFrame * CFrame.new(0, (v11.Size.Y - v2.Size.Y) / 2, v11.Size.Z / 2 + v2.Size.Z / 2)
		v11.Name = "6"
		v11.Parent = p1

		local v12 = v1:NextInteger(27, 34) * 0.01
		local Size = v2.Size
		local v15 = math.max(1, (math.round(Size.Z / Size.X)))
		local v16 = Size.Z / v15
		local v17 = Size.Z / 2
		local count, count2, v18 = 0, 4, v16

		for i = 1, v15 do
			local v19

			count = count + 1

			local Part = Instance.new("Part")

			Part.Shape = Enum.PartType.Ball
			Part.Size = Vector3.new(v16, v16, v16)
			Part.Anchored = true
			Part.CanCollide = false
			Part.Material = v2.Material
			Part.Color = v2.Color

			local v20 = count * 0.1 % 2

			v19 = if v20 <= 1 then v20 else 2 - v20
			Part.Color = Color3.fromHSV(v12 - 0.025 + v19 * 0.025, 0.5 + v19 * 0.175, 0.5 + v19 * 0.25)
			Part.CFrame = v2.CFrame * CFrame.new(0, v16 / 2 - v2.Size.Y / 4, -v17 + v18 / 2 + (i - 1) * v18)
			count2 = count2 + 1
			Part.Name = tostring(count2)
			Part.Parent = p1
		end

		for v21, v22 in p1:GetDescendants() do
			if v22:IsA("BasePart") then
				v22.Anchored = true
			end
		end

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

		local v6 = 0

		for v7, v8 in t do
			if not v8.part:GetAttribute("DontShow") then
				local Rotation = v8.centerOffset.Rotation
				local v10 = math.abs((Rotation.XVector:Dot(Vector3.new(0, 0, 1)))) * v8.maxSize.X / 2
				local v12 = v10 + math.abs((Rotation.YVector:Dot(Vector3.new(0, 0, 1)))) * v8.maxSize.Y / 2
				local v14 = v12 + math.abs((Rotation.ZVector:Dot(Vector3.new(0, 0, 1)))) * v8.maxSize.Z / 2

				v6 = math.max(v6, v8.centerOffset.Position:Dot(Vector3.new(0, 0, 1)) + v14)
			end
		end

		local v16 = Vector3.new(0, 0, 0)

		local function updateGrowth() --[[ updateGrowth | Line: 178 | Upvalues: p1 (copy), v6 (ref), PrimaryPart (copy), v16 (ref), t (copy) ]]
			local v2 = math.clamp((p1:GetAttribute("Age") or 0) / (p1:GetAttribute("MaxAge") or 1), 0, 1)
			local v3 = Vector3.new(0, 0, 1) * (v6 * (1 - v2))
			local v4 = PrimaryPart.CFrame * CFrame.new(-v16)
			local v5 = false

			for v62, v7 in t do
				if not v7.part:GetAttribute("DontShow") then
					if v2 > 0 then
						v7.part.Size = v7.maxSize * v2
						v7.part.CFrame = v4 * CFrame.new(v7.centerOffset.Position * v2 + v3) * v7.centerOffset.Rotation
						v7.part.Transparency = v7.part:GetAttribute("OG_Transparency") or 0
						v7.part.CanCollide = true
						v5 = true

						continue
					end

					v7.part.Transparency = 1
					v7.part.CanCollide = false
				end
			end

			if not v5 then
				return
			end

			v16 = v3
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	Extras = {
		FruitType = "Beanstalk",
		Harvestable = true
	}
}