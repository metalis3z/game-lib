--credit to quartz games studio
return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 6 ]]
		local v1 = Random.new(p2)
		local Base = p1.Base
		local Stud_Part = script.Stud_Part
		local FruitSpawnLocations = p1:FindFirstChild("FruitSpawnLocations")
		local v2 = v1:NextInteger(7, 11) + p3 * 10
		local v4 = math.max(1, (math.round(v2 / 1.5)))
		local v5 = Color3.fromRGB(70, 170, 70)
		local Wood = Enum.Material.Wood
		local v6 = Color3.fromRGB(70, 170, 70)

		Base.CFrame = Base.CFrame * CFrame.Angles(0, math.rad((v1:NextInteger(-180, 180))), 0)

		local v9 = Base.CFrame * CFrame.new(0, -Base.Size.Y / 2, 0)
		local Position = v9.Position
		local UpVector = v9.UpVector

		while v1:NextInteger(1, 100) == 1 do
			v2 = v2 * 2
		end

		local function stemStage(p1) --[[ stemStage | Line: 60 ]]
			return p1
		end

		local function newPart(p12, p2, p3) --[[ newPart | Line: 64 | Upvalues: Stud_Part (copy), p1 (copy) ]]
			local v1 = Stud_Part:Clone()

			v1.Size = p12
			v1.Color = p2
			v1.Material = Enum.Material.Plastic
			v1.MaterialVariant = "Studs"
			v1.Name = p3
			v1.Parent = p1

			return v1
		end

		local function safePerp(p1) --[[ safePerp | Line: 75 ]]
			local v1 = p1:Cross(Vector3.new(1, 0, 0))

			if v1.Magnitude < 0.05 then
				v1 = p1:Cross(Vector3.new(0, 0, 1))
			end

			return v1.Unit
		end

		local function makeStemLeaf(p12, p2, p3) --[[ makeStemLeaf | Line: 87 | Upvalues: v1 (copy), v6 (copy), Stud_Part (copy), p1 (copy) ]]
			local v2 = Vector3.new(v1:NextInteger(5, 10) * 0.015, 1, 1)
			local v4 = Stud_Part:Clone()

			v4.Size = v2
			v4.Color = v6
			v4.Material = Enum.Material.Plastic
			v4.MaterialVariant = "Studs"
			v4.Name = p2
			v4.Parent = p1
			v4:AddTag("DetailPart")

			local v62 = p3 + math.rad((v1:NextInteger(-30, 30)))
			local v7 = p12.Size.X / 2 + v4.Size.X / 2

			v4.CFrame = p12.CFrame + Vector3.new(math.cos(v62) * v7, 0, math.sin(v62) * v7)
			v4.Orientation = Vector3.new(0, -math.deg(v62), 30)
			v4.CFrame = v4.CFrame * CFrame.Angles(0, 0, 1.5707963267948966)
			v4.CFrame = v4.CFrame * CFrame.new(0, 0.2, v4.Size.Z / 2)
			v4.CFrame = v4.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)

			return v4
		end

		local t, v10, v11, v12 = {}, {}, v9 - Position, Position

		for i = 1, v4 do
			local v13 = math.clamp((i - 1) / 6, 0, 1) * 0.2617993877991494
			local v14 = v11 * CFrame.Angles(0, (i - 1) * 0.7853981633974483 * -1, 0) * CFrame.Angles(v13, 0, 0)
			local v15 = CFrame.new(v12) * v14
			local v16 = tostring(i)
			local v17 = Stud_Part:Clone()

			v17.Size = Vector3.new(0.5, 1.5, 0.5)
			v17.Color = v5
			v17.Material = Enum.Material.Plastic
			v17.MaterialVariant = "Studs"
			v17.Name = v16
			v17.Parent = p1

			local v18 = v17

			v18.CFrame = v15 * CFrame.new(0, 0.75, 0)
			t[i] = v18.CFrame.Position
			v10[i] = v18
			v12 = (v15 * CFrame.new(0, 1.5, 0)).Position
		end

		local function makeBranch(p12, p2, p3, p4, p5) --[[ makeBranch | Line: 137 | Upvalues: Position (copy), UpVector (copy), v5 (copy), Stud_Part (copy), p1 (copy) ]]
			local v1 = p12 - Position
			local v2 = v1 - UpVector * v1:Dot(UpVector)
			local v3

			if v2.Magnitude < 0.05 then
				local v4 = UpVector
				local v52 = v4:Cross(Vector3.new(1, 0, 0))

				if v52.Magnitude < 0.05 then
					v52 = v4:Cross(Vector3.new(0, 0, 1))
				end

				v3 = v52.Unit
			else
				v3 = v2.Unit
			end

			local v7 = CFrame.fromAxisAngle(UpVector, (math.rad(p4))) * v3
			local v8 = math.rad(p3)
			local Unit = (UpVector * math.cos(v8) + v7 * math.sin(v8)).Unit
			local v10 = UpVector

			if math.abs((Unit:Dot(v10))) > 0.99 then
				local v12 = Unit:Cross(Vector3.new(1, 0, 0))

				if v12.Magnitude < 0.05 then
					v12 = Unit:Cross(Vector3.new(0, 0, 1))
				end

				v10 = v12.Unit
			end

			local Unit2 = v10:Cross(Unit).Unit
			local Unit3 = Unit2:Cross(Unit).Unit
			local v14 = CFrame.fromMatrix(p12 + v7 * 0.25, Unit2, Unit, Unit3)
			local v16 = Stud_Part:Clone()

			v16.Size = p2
			v16.Color = v5
			v16.Material = Enum.Material.Plastic
			v16.MaterialVariant = "Studs"
			v16.Name = p5
			v16.Parent = p1
			v16.CFrame = v14 * CFrame.new(0, p2.Y / 2, 0)

			return v14, v7
		end

		local function makeLeaf(p12, p2, p3, p4, p5) --[[ makeLeaf | Line: 167 | Upvalues: v6 (copy), Stud_Part (copy), p1 (copy), v1 (copy) ]]
			local v12 = p12 * CFrame.new(0, p3 * p2.Y, 0) * CFrame.Angles(0, p4, 0) * CFrame.new(p2.X / 2 + 0.5, 0, 0)
			local v3 = Stud_Part:Clone()

			v3.Size = Vector3.new(1, 0.25, 1)
			v3.Color = v6
			v3.Material = Enum.Material.Plastic
			v3.MaterialVariant = "Studs"
			v3.Name = p5 + 1
			v3.Parent = p1
			v3.CFrame = v12
			v3.Orientation = Vector3.new(v1:NextInteger(-25, 25), 45 + v1:NextInteger(-10, 10), v1:NextInteger(-25, 25))

			return v3
		end

		local v19 = (1 / 0)
		local v20 = (-1 / 0)

		for j = 1, v4 do
			local Y = t[j].Y
			local v21 = math.min(v19, Y)

			v19, v20 = v21, math.max(v20, Y)
		end

		local v23 = v20 - v19
		local v24 = v19 + v23 * 0.15
		local v25 = v20 - v23 * 0.15
		local list = {}

		for k = 1, v4 do
			local v26 = t[k]

			if v24 <= v26.Y and v26.Y <= v25 then
				table.insert(list, {
					index = k,
					pos = v26
				})
			end
		end

		local list2 = {}

		local function farEnough(p1) --[[ farEnough | Line: 196 | Upvalues: list2 (copy) ]]
			for i, v in ipairs(list2) do
				if (v - p1).Magnitude < 5 then
					return false
				end
			end

			return true
		end

		local function spawnBranch(p1) --[[ spawnBranch | Line: 205 | Upvalues: v1 (copy), makeBranch (copy), makeStemLeaf (copy), v10 (copy), FruitSpawnLocations (copy), list2 (copy) ]]
			local v12 = 4 * v1:NextNumber(0.6, 1.3)
			local v2 = 60 + v1:NextNumber(-20, 15)
			local v3 = 20 + v1:NextNumber(-45, 45)
			local v4 = Vector3.new(0.5, v12, 0.5)
			local v6 = tostring(p1.index + 0.5)
			local v7, v8 = makeBranch(p1.pos, v4, v2, v3, v6)
			local v9 = math.atan2(v8.Z, v8.X)

			makeStemLeaf(v10[p1.index], tostring(p1.index + 0.75), v9)

			local v14

			if FruitSpawnLocations then
				local Position = (v7 * CFrame.new(0, v4.Y * 0.5, 0)).Position
				local Part = Instance.new("Part")

				Part.Size = Vector3.new(0.5, 0.5, 0.5)
				Part.Transparency = 1
				Part.CanCollide = false
				Part.Anchored = true
				Part.CFrame = CFrame.new(Position - Vector3.new(0, 0.5, 0))
				Part.Name = "FruitSpawn_" .. v6
				Part.Parent = FruitSpawnLocations
			end

			v14 = p1.pos
			table.insert(list2, v14)
		end

		for i, v in ipairs(list) do
			if v1:NextNumber() < 0.4 then
				local pos = v.pos
				local v27 = true

				for i2, v13 in ipairs(list2) do
					if (v13 - pos).Magnitude < 5 then
						v27 = false

						break
					end
				end

				if v27 then
					spawnBranch(v)
				end
			end
		end

		while #list2 < 1 and #list > 0 do
			local v28, v29
			local count = 0

			repeat
				v28 = list[v1:NextInteger(1, #list)]

				local pos = v28.pos

				count = count + 1
				v29 = true

				for i, v in ipairs(list2) do
					if (v - pos).Magnitude < 5 then
						v29 = false

						break
					end
				end
			until v29 or #list * 2 <= count

			spawnBranch(v28)
		end

		if not p1.PrimaryPart then
			p1.PrimaryPart = Base
		end

		local v30 = tostring(v4)
		local v31 = v4 * 1.5
		local v33 = math.max(1, (math.ceil(v31 / 10)))
		local v34 = v31 / v33

		for n = 1, v33 do
			local TrussPart = Instance.new("TrussPart")

			TrussPart.Anchored = true
			TrussPart.Size = Vector3.new(2, v34, 2)
			TrussPart.CFrame = CFrame.new(Position + UpVector * ((n - 0.5) * v34))
			TrussPart:SetAttribute("TrunkReference", v30)
			TrussPart:AddTag("PlantTruss")
			TrussPart.CanCollide = false
			TrussPart.Transparency = 1
			TrussPart.Parent = p1
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 276 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}
		local t2 = {}

		for v1, v2 in p1:GetDescendants() do
			if v2:IsA("BasePart") and v2:HasTag("PlantTruss") then
				table.insert(t, v2)

				continue
			end

			local v4 = tonumber(v2.Name)

			if v2:IsA("BasePart") and v4 then
				table.insert(t2, {
					v2,
					v2.Size,
					PrimaryPart.CFrame:ToObjectSpace(v2.CFrame),
					v4
				})
				v2.CanCollide = false
				v2.Transparency = 1
			end
		end

		table.sort(t2, function(p1, p2) --[[ Line: 298 ]]
			return p1[4] < p2[4]
		end)

		local function updateGrowth() --[[ updateGrowth | Line: 300 | Upvalues: p1 (copy), t2 (copy), PrimaryPart (copy), t (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0

			for v2, v3 in t2 do
				local v4 = v3[1]
				local v5 = v3[2]
				local v6 = v3[3]
				local v8 = math.min(v1 - v3[4], 1)

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

			for v10, v11 in t do
				local v13 = tonumber((v11:GetAttribute("TrunkReference")))

				if v13 then
					if math.min(v1 - v13, 1) >= 1 then
						v11.CanCollide = true

						continue
					end

					v11.CanCollide = false
				end
			end
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	Extras = {}
}