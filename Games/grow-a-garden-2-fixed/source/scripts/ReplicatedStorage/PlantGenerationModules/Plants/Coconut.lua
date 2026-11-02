--credit to prince games studio
return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 6 ]]
		local function safeUnit(p1, p2) --[[ safeUnit | Line: 9 ]]
			if p1.Magnitude < 1e-6 then
				return p2
			end

			return p1.Unit
		end

		local v1 = Random.new(p2)
		local FruitSpawnLocations = p1.FruitSpawnLocations
		local Base = p1.Base
		local v2 = p3 or 1
		local v3 = 0.75

		while v1:NextInteger(1, 100) == 1 do
			v3 = v3 * 0.5
		end

		local count = v3 * (v2 * 0.05 + 0.95)

		while v1:NextInteger(1, 100) == 1 do
			count = count + 1
		end

		local v4 = v1:NextInteger(1, 1000) == 1
		local count2 = 0
		local Stud_Part = script.Stud_Part
		local v5 = Base.CFrame * CFrame.new(0, -Base.Size.Y / 2, 0)
		local Size = Base.Size
		local sum = math.round(v2 * 0.5) + 3

		if v4 == true then
			sum = sum * 3
		end

		while v1:NextInteger(1, 50) == 1 do
			sum = sum + 1
		end

		while v1:NextInteger(1, 100) == 1 do
			sum = sum + v1:NextInteger(3, 4)
		end

		local v6 = Color3.new(0.611765, 0.462745, 0.356863)
		local v7 = v1:NextInteger(90, 110) * 0.01
		local _ = v1:NextInteger(90, 110) * 0.01
		local v9 = Color3.fromHSV(0.333333 * v7, 1, 0.666667 * (v1:NextInteger(90, 110) * 0.01))
		local sum2 = 2 + v2 * 3
		local sum3 = 7

		if v4 == true then
			sum3 = sum3 * 0.5
			sum2 = sum2 * 0.5
		end

		while v1:NextInteger(1, 100) == 1 do
			sum3 = sum3 + 1
		end

		while v1:NextInteger(1, 100) == 1 do
			sum3 = sum3 + v1:NextInteger(1, 2)
			sum2 = sum2 + v1:NextInteger(1, 2)
			sum = sum + v1:NextInteger(1, 2)
		end

		local v10 = nil
		local v12 = math.clamp(v1:NextInteger(2, 7) - math.clamp(v2, 0, 3), 1, 7)
		local v14 = math.clamp(v1:NextInteger(2, 7) - math.clamp(v2, 0, 3), 1, 7)

		if v4 == true then
			v12 = v12 * 0.1
			v14 = v14 * 0.1
		end

		if v1:NextInteger(0, 1) == 1 then
			v12 = -v12
		end

		if v1:NextInteger(1, 2) == 1 then
			v14 = -v14
		end

		local _2 = v1:NextInteger(110, 120) * 0.01
		local v15 = v1:NextInteger(80, 95) * 0.01

		if v4 == true then
			v15 = v1:NextInteger(97, 99) * 0.01
		end

		if v4 == true then
			local v16 = v1:NextInteger(25, 45)
			local v17 = math.sign(v12)

			if v17 == 0 then
				v17 = 1
			end

			local v18 = Base.CFrame * CFrame.new(0, -Base.Size.Y / 2, 0)
			local Position = v18.Position

			v19 = sum2
			v20 = sum3 * 0.6 * count
			sum4 = 0
			v21 = (4 + v2) * count
			v22 = sum3

			for i = 1, sum do
				count2 = count2 + 1

				if v19 * 0.1 < sum2 then
					sum2 = sum2 * v15
				end

				sum3 = sum3 + v22 * 0.5

				local v23 = i / sum
				local v24 = math.sin(v23 * math.pi)

				sum4 = sum4 + math.rad(v16) * v17 * v24

				local v25 = v21 * v24 * (v23 * 0.5 + 1)
				local v28 = v18.Position + Vector3.new(math.cos(sum4) * v25, i * v20, math.sin(sum4) * v25)
				local v29 = v28 - Position
				local Magnitude = v29.Magnitude

				if Magnitude < 1e-6 then
					Position = v28

					continue
				end

				local Unit = v29.Unit
				local v30 = Unit:Cross(Vector3.new(0, 1, 0))
				local v31 = if v30.Magnitude < 1e-6 then Vector3.new(1, 0, 0) else v30.Unit
				local v33 = CFrame.fromMatrix((Position + v28) * 0.5, v31, Unit, (v31:Cross(Unit)))
				local v34 = Stud_Part:Clone()

				v34.Size = Vector3.new(sum2 * count, Magnitude, sum2 * count)
				v34.CFrame = v33
				v34.Color = v6
				v34.Name = tostring(count2)
				v34.Parent = p1
				Position, v10 = v28, v34
			end
		else
			v35 = 0
			v36 = sum2
			v37 = 0
			v38 = sum3

			for j = 1, sum do
				local v39 = Stud_Part:Clone()

				count2 = count2 + 1

				if j == 2 then
					local v40 = math.rad(v12)

					v35, v37 = v40, math.rad(v14)
				end

				if v36 * 0.1 < sum2 then
					sum2 = sum2 * v15
				end

				sum3 = sum3 + v38 * 0.5
				v39.Size = Vector3.new(sum2 * count, sum3 * count, sum2 * count)
				v39.CFrame = v5 * CFrame.new(0, Size.Y / 2, 0) * CFrame.Angles(v35, 0, v37) * CFrame.new(0, v39.Size.Y / 2, 0)
				v39.Color = v6
				v39.Name = tostring(count2)
				v39.Parent = p1
				v5 = v39.CFrame
				Size = v39.Size
				v10 = v39
			end
		end

		local sum4 = v1:NextInteger(6, 7)
		local sum5 = v1:NextInteger(5, 6) + math.round(v2 * 0.5)

		while v1:NextInteger(1, 100) == 1 do
			sum4 = sum4 + v1:NextInteger(1, 3)
		end

		while v1:NextInteger(1, 100) == 1 do
			sum5 = sum5 + v1:NextInteger(3, 4)
		end

		local v42 = math.clamp(15 - v2, 7, 15)
		local v43, v44 = 360 - 360 / sum4, count2

		for k = 1, sum4 do
			local v45 = v10.CFrame * CFrame.new(0, v10.Size.Y / 2, 0) * CFrame.Angles(0, math.rad(v43 * k), 0) * CFrame.Angles(0.7853981633974483, 0, 0)

			for n = 1, sum5 do
				local v46 = Stud_Part:Clone()

				v46.Size = Vector3.new((5 + v2) * count, (7 + v2) * count, (2 + v2) * count)
				v46.CFrame = v45 * CFrame.new(0, v46.Size.Y / 2, 0)
				v46.CFrame = v46.CFrame * CFrame.new(0, -v46.Size.Y / 2, 0) * CFrame.Angles(math.rad(v42), 0, 0) * CFrame.new(0, v46.Size.Y / 2, 0)
				v46.Name = tostring(v44 + n)
				v46.Color = v9
				v46.Parent = p1
				v45 = v46.CFrame * CFrame.new(0, v46.Size.Y / 2, 0)

				local Size2 = v46.Size
				local v47 = v46.CFrame

				for m = 0, math.max(1, (math.floor(Size2.Y / 8))) - 1 do
					local SpawnPoint = Instance.new("Part")

					SpawnPoint.Anchored = true
					SpawnPoint.CanCollide = false
					SpawnPoint.Transparency = 1
					SpawnPoint.Size = Vector3.new(1, 1, 1)
					SpawnPoint.Parent = FruitSpawnLocations
					SpawnPoint.Name = "SpawnPoint"
					SpawnPoint.CFrame = v47 * CFrame.new(0, -Size2.Y / 2 + m * 8 + 4, Size2.Z / 2 + 1)
				end
			end
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 253 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 276 | Upvalues: p1 (copy), t2 (copy), PrimaryPart (copy), t (copy) ]]
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
				local v13 = tonumber((v11:GetAttribute("LeafReference")))

				if v13 then
					if math.min(v1 - v13, 1) >= 1 then
						v11.Transparency = 1
						v11.CanCollide = true

						continue
					end

					v11.Transparency = 1
					v11.CanCollide = false
				end
			end
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	Extras = {}
}