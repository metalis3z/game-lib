--credit to quartz games studio
local MaterialService = game:GetService("MaterialService")

return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 9 | Upvalues: MaterialService (copy) ]]
		local v1 = p3 or 1
		local v2 = Random.new(p2)
		local FruitSpawnLocations = p1.FruitSpawnLocations

		if v1 < 4 then
			v1 = v1 * 0.5 + 0.5
		end

		local function GetRandomHSV(p1, p2) --[[ GetRandomHSV | Line: 20 | Upvalues: v2 (copy) ]]
			local v1, v22, v3 = p1:ToHSV()
			local v4 = p2 or 0.05
			local v5 = v1 + v2:NextNumber(-v4, v4)

			return Color3.fromHSV(v5, v22, v3), v5, v22, v3
		end

		local v3 = Color3.fromRGB(74, 112, 33)

		local function CreatePart(p12, p2, p3) --[[ CreatePart | Line: 30 | Upvalues: p1 (copy), MaterialService (ref) ]]
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

		local v4 = 0.85

		if v1 > 2 and v1 < 4 then
			v4 = 0.925
		elseif v1 > 4 then
			v4 = 0.95
		end

		local v5 = v2:NextNumber(1.3, 1.6) * v1
		local v6 = v2:NextInteger(5, 7) * v1
		local v7 = v2:NextInteger(4, 5)
		local v8 = Vector3.new(v5, v5, v5)
		local v9 = p1.Base.CFrame

		local function AddSpikes(p12, p2) --[[ AddSpikes | Line: 81 | Upvalues: v2 (copy), p1 (copy) ]]
			local Size = p12.Size
			local v1 = math.min(Size.X, Size.Y, Size.Z)
			local v22 = v2:NextNumber(1, 4) * 90
			local v3 = v2:NextNumber(75, 105)
			local v4 = script.Spike.Size * (v1 * v2:NextNumber(0.75, 0.9))
			local v5 = script.Spike:Clone()

			v5.Parent = p1
			v5.Name = p2 + 1
			v5.Size = v4
			v5.CFrame = p12.CFrame * CFrame.Angles(0, math.rad(v22), (math.rad(v3))) * CFrame.new(0, Size.Z / 2 + v4.Y / 2.2, 0)
		end

		local function AddBranch(p1, p2) --[[ AddBranch | Line: 96 | Upvalues: v2 (copy), v8 (ref), v9 (ref), CreatePart (copy), v3 (copy), AddSpikes (copy), FruitSpawnLocations (copy) ]]
			local v1 = v2:NextInteger(2, 3)
			local v22 = v8 * 0.8
			local v32 = v2:NextNumber(1, 2) * (p2 * 90)
			local v4 = v2:NextNumber(60, 75)
			local v5 = v9 * CFrame.Angles(0, math.rad(v32), (math.rad(v4)))

			for i = 1, v1 do
				local v6 = CreatePart(nil, "2022 Weld")

				v6.Size = v22

				local Angles = CFrame.Angles
				local v82 = math.rad((v2:NextNumber(-12, 12)))
				local v92 = v2:NextNumber(-12, 12)

				v6.CFrame = v5 * Angles(v82, 0.2617993877991494, (math.rad(v92))) * CFrame.new(0, v22.Y / 2.2, 0)
				v6.Color = v3
				v6.Name = tostring(i + p2)

				if v2:NextInteger(1, 3) == 1 then
					AddSpikes(v6, i + p2)
				end

				v5 = v6.CFrame * CFrame.new(0, v8.Y / 2.2, 0)

				if i ~= v1 then
					local FruitSpawn = CreatePart()

					FruitSpawn.Parent = FruitSpawnLocations
					FruitSpawn.Name = "FruitSpawn"
					FruitSpawn.Size = Vector3.new(1, 1, 1)
					FruitSpawn.CFrame = v5
					FruitSpawn.Orientation = FruitSpawn.Orientation + Vector3.new(-90, if i % 2 == 0 then 90 else -90, v2:NextNumber(5, 15))
					FruitSpawn.Transparency = 1
				end

				v22 = Vector3.new(v22.X * 0.85, p1.Size.Y * v2:NextNumber(0.8, 1.1), v22.Z * 0.85)
			end
		end

		local v10 = v5

		for i = 1, v6 do
			local v11 = CreatePart(nil, "2022 Weld")

			v11.Size = v8

			local Angles = CFrame.Angles
			local v13 = math.rad((v2:NextNumber(-6, 6)))
			local v14 = v2:NextNumber(-6, 6)

			v11.CFrame = v9 * Angles(v13, 0.2617993877991494, (math.rad(v14))) * CFrame.new(0, v8.Y / 2.2, 0)
			v11.Color = v3
			v11.Name = tostring(i)
			v9 = v11.CFrame * CFrame.new(0, v8.Y / 2.2, 0)

			local v15 = math.clamp(v10 * 1.15, 0, v5 * 2)

			if v2:NextInteger(1, 3) == 1 then
				AddSpikes(v11, i)
			end

			if i > 2 and (v2:NextInteger(1, 2) == 1 or (i == v6 or i == 3)) then
				AddBranch(v11, i)
			end

			v10 = v15
			v8 = Vector3.new(v8.X * v4, v15, v8.Z * v4)
		end

		for j = 1, v7 do
			local v18 = CreatePart(nil, "2022 Weld")

			v18.Size = v8

			local Angles = CFrame.Angles
			local v20 = math.rad((v2:NextNumber(-6, 6)))
			local v21 = v2:NextNumber(-45, -30)

			v18.CFrame = v9 * Angles(v20, 0, (math.rad(v21))) * CFrame.Angles(0, 0.2617993877991494, 0) * CFrame.new(0, v8.Y / 2.2, 0)
			v18.Color = v3
			v18.Name = tostring(j + v6)
			v9 = v18.CFrame * CFrame.new(0, v8.Y / 2.2, 0)

			local v22 = math.clamp(v10 * 0.9, v5 / 2, (1 / 0))

			if v2:NextInteger(1, 3) == 1 then
				AddSpikes(v18, j + v6)
			end

			v8 = Vector3.new(v8.X * 0.9, v22, v8.Z * 0.9)
			v10 = v22
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 179 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 197 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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