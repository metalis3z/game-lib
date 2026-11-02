--credit to prince games studio
return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 6 ]]
		local v1 = p3 or 1
		local v2 = Random.new(p2)
		local PrimaryPart = p1.PrimaryPart
		local FruitSpawnLocations = p1.FruitSpawnLocations
		local Stud_Part = script.Stud_Part
		local v3 = 4 + v1
		local v4 = v2:NextInteger(4, 11)
		local v5 = Color3.new(0, 0.666667, 0)
		local v6 = 0

		local function Brach(p12, p2, p3) --[[ Brach | Line: 26 | Upvalues: v5 (copy), v4 (ref), p1 (copy), v6 (ref) ]]
			local count = 1

			for i = 1, p2 do
				local v1 = script.Stud_Part:Clone()

				v1.Name = tostring(count)
				v1.Size = p3
				v1.Color = v5
				v1.CFrame = p12 * CFrame.new(0, v1.Size.Y / 2 + p3.Y / 2, 0) * CFrame.new(0, -v1.Size.Y / 2, 0) * CFrame.Angles(math.rad(v4), 0, 0) * CFrame.new(0, v1.Size.Y / 2, 0)
				v1.Parent = p1
				p12 = v1.CFrame
				p3 = v1.Size
				count = count + 1

				if v6 < count then
					v6 = count
				end
			end
		end

		local v7 = (360 + 360 / v3) / v3
		local v9 = Vector3.new(if v2:NextInteger(1, 10) == 1 then 3 else 1.25, 0.5 + v1 * 0.2, 1)
		local count = 1

		if v2:NextInteger(1, 10) == 1 then
			count = count + 1
		end

		local v10 = -v2:NextInteger(13, 15)
		local v11

		if v2:NextInteger(1, 700) == 1 then
			v11 = 2

			while v2:NextInteger(1, 500) == 1 do
				v11 = v11 * 2
			end
		else
			v11 = 1
		end

		if v11 > 1 then
			v4 = v4 / (v11 * 1.5)
		end

		for i = 0, count do
			for j = 1, v3 do
				local v12 = PrimaryPart.CFrame * CFrame.new(0, -PrimaryPart.Size.Y / 2, 0) * CFrame.new(0, -v9.Y / 2, 0) * CFrame.Angles(0, math.rad(v7 * j + i * 90), 0)
				local Angles = CFrame.Angles

				Brach(v12 * Angles(math.rad(v2:NextInteger(7, 15) + v10 * i), 0, 0), v11 * 11, v9)
			end
		end

		local function Branch(p12, p2, p3) --[[ Branch | Line: 91 | Upvalues: v6 (ref), v2 (copy), v5 (copy), p1 (copy), Stud_Part (copy), FruitSpawnLocations (copy) ]]
			local count = v6
			local v1 = v2:NextInteger(-5, 5)
			local v22 = v2:NextInteger(-5, 5)
			local v3 = nil

			for i = 1, p3 do
				local v4 = script.Stud_Part:Clone()

				v4.Name = tostring(count)
				v4.Size = p12
				v4.Color = v5
				v4.CFrame = p2 * CFrame.new(0, v4.Size.Y / 2 + p12.Y / 2, 0) * CFrame.new(0, -v4.Size.Y / 2, 0) * CFrame.Angles(math.rad(v1), 0, (math.rad(v22))) * CFrame.new(0, v4.Size.Y / 2, 0)
				v4.Name = tostring(count)
				v4.Parent = p1
				p2 = v4.CFrame
				p12 = v4.Size
				count = count + 1

				if v6 < count then
					v6 = count
					v3 = v4

					continue
				end

				v3 = v4
			end

			local v52 = Stud_Part:Clone()

			v52.Size = Vector3.new(1, 1, 1)
			v52.Transparency = 1
			v52.CanCollide = false
			v52.CFrame = v3.CFrame * CFrame.new(0, v3.Size.Y / 2, 0) * CFrame.new(0, v52.Size.Y / 2, 0)
			v52.Parent = FruitSpawnLocations
		end

		if v2:NextInteger(1, 10) == 1 then
			local v14 = v2:NextInteger(2, 5)
			local v15 = (360 + 360 / v14) / v14

			for k = 1, v14 do
				local v17 = Vector3.new(2, v2:NextInteger(3, 5), 2)
				local v18 = PrimaryPart.CFrame * CFrame.new(0, -PrimaryPart.Size.Y / 2, 0) * CFrame.new(0, -v17.Y / 2, 0) * CFrame.Angles(0, math.rad(v15 * k), 0)
				local Angles = CFrame.Angles

				Branch(v17, v18 * Angles(math.rad((v2:NextInteger(1, 3))), 0, 0), v2:NextInteger(3, 4))
			end
		else
			local v20 = Stud_Part:Clone()

			v20.Parent = p1
			v20.Size = Vector3.new(2, 7 + v1, 2)
			v20.CFrame = PrimaryPart.CFrame * CFrame.new(0, -PrimaryPart.Size.Y / 2, 0) * CFrame.new(0, v20.Size.Y / 2, 0)
			v20.Name = tostring(v6)
			v20.Color = Color3.new(0, 0.666667, 0)
			v20.Parent = p1

			local v21 = Stud_Part:Clone()

			v21.Size = Vector3.new(1, 1, 1)
			v21.Transparency = 1
			v21.CanCollide = false
			v21.CFrame = v20.CFrame * CFrame.new(0, v20.Size.Y / 2, 0) * CFrame.new(0, v21.Size.Y / 2, 0)
			v21.Parent = FruitSpawnLocations
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 169 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}

		for v1, v2 in p1:GetDescendants() do
			local v4 = tonumber(v2.Name)

			if v2:IsA("BasePart") and v4 then
				table.insert(t, {
					v2,
					v2.Size,
					PrimaryPart.CFrame:ToObjectSpace(v2.CFrame),
					v4
				})
				v2.CanCollide = false
				v2.Transparency = 1
			end
		end

		table.sort(t, function(p1, p2) --[[ Line: 188 ]]
			return p1[4] < p2[4]
		end)

		local function updateGrowth() --[[ updateGrowth | Line: 190 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0

			for v2, v3 in t do
				local v4 = v3[1]
				local v5 = v3[2]
				local v6 = v3[3]
				local v8 = math.clamp(v1 - v3[4], 0, 1)

				if v8 > 0 then
					v4.Size = Vector3.new(v5.X, v5.Y * v8, v5.Z)
					v4.CFrame = PrimaryPart.CFrame * v6 * CFrame.new(0, (v4.Size.Y - v5.Y) / 2, 0)
					v4.Transparency = v4:GetAttribute("OG_Transparency") or 0
					v4.CanCollide = true

					continue
				end

				v4.Transparency = 1
				v4.CanCollide = false
			end
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	Extras = {}
}