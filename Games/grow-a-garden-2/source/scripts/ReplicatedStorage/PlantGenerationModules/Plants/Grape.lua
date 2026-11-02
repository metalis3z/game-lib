--credit to prince games studio
return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 7 ]]
		local v1 = p3 or 1
		local v2 = Random.new(p2)
		local FruitSpawnLocations = p1.FruitSpawnLocations
		local Base = p1.Base
		local Stud_Part = script.Stud_Part
		local _ = p2 + #p1:GetChildren() * v2:NextInteger(3, 90)
		local v3 = 1 * (v1 * 0.5 + 0.5)
		local v4 = 3 * (v1 * 0.5 + 0.5)

		while v2:NextInteger(1, 100) == 1 do
			v4 = v4 * 2
		end

		local v5 = Color3.fromRGB(36, 145, 36)
		local v6 = Color3.fromRGB(45, 165, 45)
		local v7 = Base.Position.Y - Base.Size.Y / 2 + 7
		local t = {}
		local v8 = 0

		local function createPart(p12) --[[ createPart | Line: 33 | Upvalues: Stud_Part (copy), p1 (copy) ]]
			local v1 = Stud_Part:Clone()

			if not p12 then
				p12 = "Studs"
			end

			v1.TopSurface = Enum.SurfaceType[p12]
			v1.BackSurface = Enum.SurfaceType[p12]
			v1.FrontSurface = Enum.SurfaceType[p12]
			v1.BottomSurface = Enum.SurfaceType[p12]
			v1.LeftSurface = Enum.SurfaceType[p12]
			v1.RightSurface = Enum.SurfaceType[p12]
			v1.Anchored = true
			v1.CanCollide = false
			v1.Transparency = 0
			v1.Parent = p1

			return v1
		end

		local function Generate_Part(p12, p2, p3, p4) --[[ Generate_Part | Line: 52 | Upvalues: v3 (copy), v4 (ref), Stud_Part (copy), v8 (ref), p1 (copy) ]]
			local v42 = Vector3.new(v3, v4, v3)
			local v5 = p12.CFrame * CFrame.new(0, p12.Size.Y / 2, 0) * CFrame.Angles(math.rad(p2), math.rad(p4), (math.rad(p3))) * CFrame.new(0, v42.Y / 2, 0)
			local v6 = Stud_Part:Clone()

			v6.Size = v42
			v6.CFrame = v5
			v8 = v8 + 1
			v6.Name = tostring(v8)
			v6.Parent = p1
			v6.Color = p12.Color

			return v6
		end

		local function Generate_Wind(p1, p2) --[[ Generate_Wind | Line: 71 | Upvalues: v2 (copy), Generate_Part (copy), t (copy) ]]
			local sum = 0
			local sum2 = 0
			local v1 = v2:NextInteger(3, 20)

			if v2:NextInteger(1, 2) == 1 then
				v1 = -v1
			end

			local v22 = v2:NextInteger(-45, 45)
			local v3 = v2:NextInteger(-45, 45)
			local v4 = p1

			while p2 > 0 do
				if v22 >= 1 and sum < v22 then
					sum = sum + 5
				elseif v22 < 0 and v22 < sum then
					sum = sum - 5
				end

				if v3 >= 1 and sum2 < v3 then
					sum2 = sum2 + 5
				elseif v3 < 0 and v3 < sum2 then
					sum2 = sum2 - 5
				end

				local v5 = Generate_Part(v4, sum, sum2, v1)

				if v5 then
					table.insert(t, v5)
					v4 = v5
				end

				p2 = p2 - 1
			end
		end

		local function AttachWedge(p1, p2) --[[ AttachWedge | Line: 105 | Upvalues: createPart (copy), v6 (copy) ]]
			for i = -1, 1, 2 do
				local v1 = createPart("Weld")

				v1.Size = Vector3.new(p1.Size.Z, p1.Size.Y * 0.5, p1.Size.X / 2)
				v1.Shape = Enum.PartType.Wedge
				v1.CFrame = p1.CFrame * CFrame.new(-i * p1.Size.X / 4, p1.Size.Y / 2 + p1.Size.Y * 0.5 / 2 - 0.025, 0) * CFrame.Angles(0, math.rad(i * 90), 0)
				v1.Color = v6
				v1.Name = tostring(p2)
				v1:AddTag("DetailPart")
			end
		end

		local function Add_Leaf(p1, p2) --[[ Add_Leaf | Line: 123 | Upvalues: v1 (ref), v2 (copy), createPart (copy), v6 (copy), AttachWedge (copy), FruitSpawnLocations (copy), v7 (copy) ]]
			local v12 = Vector3.new(1, 1, 0.1) * v1
			local v22 = if v2:NextInteger(1, 2) == 1 then 1 else -1
			local v3 = createPart("Weld")

			v3.Size = v12
			v3.CFrame = p1.CFrame * CFrame.new(v22 * (p1.Size.X / 2 + v12.Y / 2 - 0.05), 0, 0)
			v3.CFrame = v3.CFrame * CFrame.Angles(0, 0, (math.rad(v22 * -90)))
			v3.Color = v6
			v3.Name = tostring(p2)
			v3:AddTag("DetailPart")

			local v4 = createPart("Weld")

			v4.Size = v12

			local v5 = v2:NextInteger(25, 45)

			v4.CFrame = v3.CFrame * CFrame.new(0, v3.Size.Y / 2, 0) * CFrame.Angles(-math.rad(v5), 0, 0) * CFrame.new(0, v4.Size.Y / 2 - 0.025, 0)
			v4.Color = v6
			v4.Name = tostring(p2)
			v4:AddTag("DetailPart")
			AttachWedge(v4, p2)

			local v62 = p1.CFrame - Vector3.new(0, 2, 0)
			local v72 = true

			for k, v in pairs(FruitSpawnLocations:GetChildren()) do
				if (v.Position - v62.Position).Magnitude < 4 then
					v72 = false
				end
			end

			if v72 ~= true or not (v7 + 2 < v62.Position.Y) then
				return
			end

			local Fruit_Spawn = Instance.new("Part")

			Fruit_Spawn.Size = Vector3.new(0.1, 0.1, 0.1) * v1
			Fruit_Spawn.Anchored = true
			Fruit_Spawn.CanCollide = false
			Fruit_Spawn.Transparency = 1
			Fruit_Spawn.Name = "Fruit_Spawn"
			Fruit_Spawn.CFrame = v62
			Fruit_Spawn.Orientation = Vector3.new(0, v2:NextInteger(-180, 180), 0)
			Fruit_Spawn.Parent = FruitSpawnLocations
		end

		v8 = 1

		local v9 = createPart("Weld")

		v9.Color = v5
		v9.Size = Vector3.new(v3, v4, v3)
		v9.CFrame = Base.CFrame * CFrame.new(0, v9.Size.Y / 2, 0)

		local v10 = v8

		v9.Name = tostring(v10)
		table.insert(t, v9)

		local count = v2:NextInteger(5, 10)

		while v2:NextInteger(1, 100) == 1 do
			count = count * 2
		end

		local v11, count2 = v9, 0

		while count > 0 do
			local v12 = if v2:NextInteger(1, 2) == 1 then true else false

			Generate_Wind(v11, (v2:NextInteger(2, 5)))

			if #t > 0 then
				v11 = t[v2:NextInteger(1, #t)]
			end

			count = count - 1

			if v12 then
				count2 = count2 + 1
			end
		end

		local v13 = v8 + 1

		while count2 > 0 do
			if #t > 0 then
				Add_Leaf(t[v2:NextInteger(1, #t)], v13)
			end

			count2 = count2 - 1
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 230 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}

		for v2, v3 in p1:GetDescendants() do
			local v1
			local v5 = tonumber(v3.Name)

			if v3:IsA("BasePart") and v5 then
				local v6 = v3:HasTag("DetailPart")

				v1 = if v6 then nil else PrimaryPart.CFrame:ToObjectSpace(v3.CFrame * CFrame.new(0, -v3.Size.Y / 2, 0))
				table.insert(t, {
					part = v3,
					maxSize = v3.Size,
					bottomOffset = v1,
					centerOffset = PrimaryPart.CFrame:ToObjectSpace(v3.CFrame),
					partAge = v5,
					isDetail = v6
				})
				v3.CanCollide = false
				v3.Transparency = 1
			end
		end

		local function updateGrowth() --[[ updateGrowth | Line: 260 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0

			for v2, v3 in t do
				local v5 = math.clamp(v1 - v3.partAge, 0, 1)

				if v5 > 0 then
					if v3.isDetail then
						v3.part.Size = Vector3.new(v3.maxSize.X, v3.maxSize.Y * v5, v3.maxSize.Z)
						v3.part.CFrame = PrimaryPart.CFrame * v3.centerOffset * CFrame.new(0, (v3.part.Size.Y - v3.maxSize.Y) / 2, 0)
					else
						v3.part.Size = Vector3.new(v3.maxSize.X, v3.maxSize.Y * v5, v3.maxSize.Z)
						v3.part.CFrame = PrimaryPart.CFrame * v3.bottomOffset * CFrame.new(0, v3.part.Size.Y / 2, 0)
					end

					v3.part.Transparency = v3.part:GetAttribute("OG_Transparency") or 0
					v3.part.CanCollide = true

					continue
				end

				v3.part.Transparency = 1
				v3.part.CanCollide = false
			end
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	Extras = {}
}