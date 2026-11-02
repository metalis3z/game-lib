--credit to leon games studio
game:GetService("MaterialService")

return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 9 ]]
		local MaterialService = game:GetService("MaterialService")
		local v1 = Random.new(p2)
		local FruitSpawnLocations = p1.FruitSpawnLocations
		local Base = p1.Base

		local function GetRandomHSV(p1, p2) --[[ GetRandomHSV | Line: 20 | Upvalues: v1 (copy) ]]
			local v12, v2, v3 = p1:ToHSV()
			local v4 = p2 or 0.05
			local v6 = math.clamp(v12 + v1:NextNumber(-v4, v4), 0, 0.99)

			return Color3.fromHSV(v6, v2, v3), v6, v2, v3
		end

		local v2, v3 = Color3.fromRGB(51, 136, 5)
		local v4, v5, v6 = v2:ToHSV()
		local v7 = v3 or 0.05
		local v10 = Color3.fromHSV(math.clamp(v4 + v1:NextNumber(-v7, v7), 0, 0.99), v5, v6)

		local function CreatePart(p12, p2, p3) --[[ CreatePart | Line: 30 | Upvalues: p1 (copy), MaterialService (copy) ]]
			local Part = Instance.new("Part")
			local v1 = p12 or "Studs"

			Part.Parent = p1
			Part.TopSurface = Enum.SurfaceType[v1]
			Part.BackSurface = Enum.SurfaceType[v1]
			Part.FrontSurface = Enum.SurfaceType[v1]
			Part.BottomSurface = Enum.SurfaceType[v1]
			Part.LeftSurface = Enum.SurfaceType[v1]
			Part.RightSurface = Enum.SurfaceType[v1]
			Part.Anchored = true
			Part.CanCollide = false
			Part.Transparency = 0

			if p3 then
				Part.Shape = Enum.PartType[p3]
			end

			if p2 then
				Part.MaterialVariant = p2

				local v2 = MaterialService:FindFirstChild(p2, true)

				if not v2 then
					return Part
				end

				Part.Material = v2.BaseMaterial
			end

			return Part
		end

		local function CreateFruitSpawn(p1, p2, p3) --[[ CreateFruitSpawn | Line: 60 | Upvalues: CreatePart (copy), v10 (copy), FruitSpawnLocations (copy) ]]
			local v1 = CreatePart(nil, "2022 Inlet")

			v1.Size = Vector3.new(p2.X * 1.5, 0.5, p2.X * 1.5)
			v1.CFrame = p1
			v1.Color = v10
			v1.Name = p3 + 1

			local v4 = CreatePart(nil, "2022 Inlet")

			v4.Size = Vector3.new(p2.X * 1.5, 0.4, p2.X * 1.5)
			v4.CFrame = v1.CFrame * CFrame.Angles(0, 0.7853981633974483, 0)
			v4.Color = v10
			v4.Name = p3 + 2

			local v7 = CreatePart()

			v7.Parent = FruitSpawnLocations
			v7.Size = Vector3.new(1, 1, 1)
			v7.CFrame = v1.CFrame * CFrame.new(0, 0.25, 0)
			v7.Transparency = 1
		end

		local function CreateStem(p12, p2, p3, p4) --[[ CreateStem | Line: 83 | Upvalues: CreatePart (copy), v1 (copy), v10 (copy), CreateFruitSpawn (copy), p1 (copy) ]]
			for i = 1, p12 do
				local v12 = CreatePart(nil, "2022 Inlet")

				v12.Size = p2

				local Angles = CFrame.Angles
				local v3 = math.rad((v1:NextNumber(-9, 9)))
				local v4 = v1:NextNumber(-9, 9)

				v12.CFrame = p3 * Angles(v3, 0.2617993877991494, (math.rad(v4))) * CFrame.new(0, p2.Y / 2.2, 0)
				v12.Color = v10
				v12.Name = i + p4

				if i > 1 and (i < p12 and v1:NextInteger(1, 2) == 1) then
					local v5 = v1:NextInteger(1, 3)
					local v6 = v12.CFrame * CFrame.new(0, -(v12.Size.Y / 2), 0)
					local v8 = v6 * CFrame.Angles(0, math.rad((v1:NextNumber(-180, 180))), 0)
					local v102 = v8 * CFrame.Angles(math.rad((v1:NextNumber(20, 40))), 0, 0)

					for j = 1, v5 do
						local v11 = CreatePart(nil, "2022 Inlet")

						v11.Size = Vector3.new(p2.X * 0.9, p2.Y * 0.6, p2.Z * 0.9)

						local Angles4 = CFrame.Angles
						local v15 = v1:NextNumber(10, 25)

						v11.CFrame = v102 * Angles4(math.rad(v15), 0, 0) * CFrame.new(0, v11.Size.Y / 2, 0)
						v11.Name = i + p4 + j
						v11.Color = v10
						v102 = v11.CFrame * CFrame.new(0, v11.Size.Y / 2, 0)
						v11.CFrame = v11.CFrame * CFrame.Angles(0, math.rad((v1:NextNumber(-25, 25))), 0)

						if j == v5 then
							CreateFruitSpawn(v102, v11.Size, i + p4 + j)
						end
					end
				end

				if v1:NextInteger(1, 3) == 1 then
					local v18 = CreatePart(nil, "2022 Inlet")

					v18.Size = Vector3.new(p2.X * 0.8, p2.Y * 0.65, p2.Z * 0.8)

					local v22 = v12.CFrame * CFrame.new(0, -(v12.Size.Y / 2), 0)
					local v24 = v22 * CFrame.Angles(0, math.rad((v1:NextNumber(-180, 180))), 0)
					local Angles3 = CFrame.Angles
					local v25 = v1:NextNumber(40, 55)

					v18.CFrame = v24 * Angles3(math.rad(v25), 0, 0) * CFrame.new(0, v18.Size.Y / 2, 0)
					v18.Name = i + p4 + 1
					v18.Color = v10

					local v26 = script.FlowerPetal:Clone()

					v26.Parent = p1
					v26:PivotTo(v18.CFrame * CFrame.new(0, v18.Size.Y / 2.5, 0) * CFrame.Angles(0.6108652381980153, 0, 0))
					v26.Name = i + p4 + 2
				end

				p3 = v12.CFrame * CFrame.new(0, p2.Y / 2.2, 0)
				v12.CFrame = v12.CFrame * CFrame.Angles(0, math.rad((v1:NextNumber(-25, 25))), 0)

				if i == p12 then
					CreateFruitSpawn(p3, v12.Size, i + p4)
				end
			end
		end

		local v11 = v1:NextInteger(3, 5)
		local v12 = p3 or 1

		for i = 1, v11 do
			local v13 = script.CurvedLeaf:Clone()

			v13.Parent = p1

			local v15 = Base.CFrame * CFrame.Angles(0, math.rad(360 / v11 * (i * v1:NextNumber(0.8, 1.2))), 0)
			local Angles = CFrame.Angles

			v13:PivotTo(v15 * Angles(math.rad(-v1:NextNumber(35, 55)), 0, 0))
			v13.Name = 1
		end

		local v17 = v1:NextNumber(0.45, 0.75) * (v12 * 0.5 + 0.5)
		local v18 = v1:NextNumber(2.9, 4) * (v12 * 0.5 + 0.5)
		local v19 = v1:NextInteger(3, 5) * v12

		while v1:NextInteger(1, 30) == 1 do
			v19 = v19 * 2

			while v1:NextInteger(1, 3) == 1 do
				v17 = v17 * 2
				v18 = v18 * 2
			end
		end

		CreateStem(v19, Vector3.new(v17, v18, v17), Base.CFrame, 0, true)
		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 171 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}

		for v1, v2 in p1:GetDescendants() do
			local v4 = tonumber(v2.Name)

			if (v2:IsA("BasePart") or v2:IsA("MeshPart")) and v4 then
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

		local function updateGrowth() --[[ updateGrowth | Line: 189 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0

			for v2, v3 in t do
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
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	Extras = {}
}