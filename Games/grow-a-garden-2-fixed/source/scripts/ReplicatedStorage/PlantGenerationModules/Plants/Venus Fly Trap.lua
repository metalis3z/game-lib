--credit to quartz games studio
game:GetService("MaterialService")

local LeafMesh = script.LeafMesh
local SpikeMesh = script.SpikeMesh
local Head = script.Head
local VenusClose = script.VenusClose
local VenusHead = script.VenusHead

require(game.StarterPlayer.StarterPlayerScripts.Controllers.InverseKinematicsController)

local function CreatePart(p1, p2, p3) --[[ CreatePart | Line: 13 ]]
	local Part = Instance.new("Part")

	if not p2 then
		p2 = "Studs"
	end

	Part.Parent = p1
	Part.TopSurface = Enum.SurfaceType[p2]
	Part.BackSurface = Enum.SurfaceType[p2]
	Part.FrontSurface = Enum.SurfaceType[p2]
	Part.BottomSurface = Enum.SurfaceType[p2]
	Part.LeftSurface = Enum.SurfaceType[p2]
	Part.RightSurface = Enum.SurfaceType[p2]
	Part.Anchored = true
	Part.CanCollide = false
	Part.Transparency = 1

	if p3 then
		Part.MaterialVariant = p3
	end

	return Part
end

local function CreateMeshPart(p1, p2, p3) --[[ CreateMeshPart | Line: 34 ]]
	local v1 = p2:Clone()

	v1.Parent = p1
	v1.Anchored = true
	v1.CanCollide = false
	v1.Transparency = 1

	if p3 then
		v1.MaterialVariant = p3
	end

	return v1
end

local function GetDifference(p1, p2) --[[ GetDifference | Line: 46 ]]
	return p2 + (p1 - p2) / 2
end

return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 56 | Upvalues: Head (copy), CreatePart (copy), SpikeMesh (copy), LeafMesh (copy) ]]
		local FruitSpawnLocations = p1.FruitSpawnLocations
		local v2 = Head:Clone()
		local v3 = Random.new(p2):NextNumber(3, 5)
		local v4 = Color3.fromRGB(32, 103, 56)
		local v5 = p2
		local v6 = 0

		math.randomseed(v5)

		local function ChangeSeed() --[[ ChangeSeed | Line: 72 | Upvalues: v6 (ref), v5 (ref) ]]
			v6 = v6 + 1

			local v3 = v5

			v5 = math.clamp(v5 * math.random(1, (math.clamp(math.clamp(v5 + v6, 1, 100) * 100, 1, 10000))), 1, 9100000000000)

			if v5 ~= v3 then
				math.randomseed(v5)

				return
			end

			v5 = 3
			math.randomseed(v5)
		end

		local v7 = math.random(35, 45)
		local v8 = if math.random(1, 2) == 1 then 10 else -10
		local v9 = 30

		math.random(5, 8)

		local function CreateSpike(p12, p2, p3) --[[ CreateSpike | Line: 98 | Upvalues: CreatePart (ref), v5 (ref), v4 (copy), SpikeMesh (ref), p1 (copy) ]]
			local Spike = Instance.new("Model")

			Spike.Name = "Spike"

			local v1 = CreatePart(Spike, nil, "Studs")

			if not p3 then
				p3 = 1
			end

			local v2 = Random.new(v5):NextNumber(1.25, 3) * p3

			v1.Size = Vector3.new(v2 * 0.2, v2 * 0.2, v2 * 0.65)
			v1.CFrame = p12 * CFrame.Angles(1.5707963267948966, 0, 0)
			v1.Color = v4
			v1.Name = p2

			local v3 = SpikeMesh:Clone()

			v3.Parent = Spike
			v3.Anchored = true
			v3.CanCollide = false
			v3.Transparency = 1
			v3.MaterialVariant = "Studs"
			v3.Name = p2 + 1
			v3.Size = Vector3.new(v2 / 2, v2, v2 * 0.1)

			local v52 = CFrame.new
			local Y2 = v3.Size.Y

			v3.CFrame = v1.CFrame * v52(0, Y2 + (v1.Size.Y - Y2) / 2, 0) * CFrame.Angles(0, 1.5707963267948966, 0)
			Spike.Parent = p1

			return Spike
		end

		local function CreateLeafStems(p12, p2) --[[ CreateLeafStems | Line: 126 | Upvalues: v6 (ref), v5 (ref), CreatePart (ref), CreateSpike (copy), LeafMesh (ref), p1 (copy) ]]
			local RightVector = p12.CFrame.RightVector
			local v1 = p2 + 1
			local v2 = 1
			local t = {}

			for i = 1, 2 do
				v6 = v6 + 1

				local v52 = v5

				v5 = math.clamp(v5 * math.random(1, (math.clamp(math.clamp(v5 + v6, 1, 100) * 100, 1, 10000))), 1, 9100000000000)

				if v5 == v52 then
					v5 = 3
				end

				math.randomseed(v5)

				local Model = Instance.new("Model")
				local v7 = math.random(3, 4)
				local v8 = CreatePart(Model, nil, "Studs")

				v8.Size = Vector3.new(p12.Size.X / 2, p12.Size.Y * 0.35, p12.Size.Z / 2)
				v8.CFrame = p12.CFrame * CFrame.new(-RightVector * (p12.Size.Y * 0.35))
				v8.Color = p12.Color
				v8.Name = v1

				local v12 = v8.CFrame

				if v2 == 1 then
					v12 = v12 * CFrame.Angles(0, math.pi, 0)
				end

				local v13 = v8

				for j = 1, v7 do
					local v14 = CreatePart(Model, nil, "Studs")

					v14.Size = Vector3.new((1 - j * 0.2) * 2, (1 - j * 0.2) * 1, (1 - j * 0.2) * 1)
					v14.CFrame = v12 * CFrame.Angles(0, math.rad(v2 * 6 * j), 0) * CFrame.new(v13.Size.X * 0.7, 0, 0)
					v14.Color = p12.Color
					v14.Name = v1 + j
					v12 = v14.CFrame

					if v2 == -1 then
						v14.CFrame = v14.CFrame * CFrame.Angles(0, math.pi, 0)
					end

					if j == 2 then
						local v15 = CreateSpike(v14.CFrame * CFrame.new(0, 0, v14.Size.Z / 2) * CFrame.Angles(0, 0, -1.5707963267948966), v1, v14.Size.Y * 0.65)
						local Reference = Instance.new("ObjectValue")

						Reference.Parent = v14
						Reference.Name = "Reference"
						Reference.Value = v15
					end

					v13 = v14
				end

				RightVector = -RightVector
				v2 = -v2

				local v16 = LeafMesh:Clone()

				v16.Parent = Model
				v16.Anchored = true
				v16.CanCollide = false
				v16.Transparency = 1
				v16.MaterialVariant = "Weld 2x2 Plastic"
				v16.Name = v1 + v7 + 1
				v16.CFrame = v12 * CFrame.Angles(0, 0, 1.5707963267948966)

				if v2 == -1 then
					v16.CFrame = v16.CFrame * CFrame.Angles(0, math.pi, 0)
				end

				local v17 = v16

				v17.CFrame = v17.CFrame * (CFrame.Angles(math.pi, 0, 0) * CFrame.new(0, v17.Size.Y * 0.45, 0))
				Model.Parent = p1

				local EndJoint = CreatePart(Model, nil, "Studs")

				EndJoint.Transparency = 1
				EndJoint.CFrame = v17.CFrame * CFrame.new(0, v17.Size.Y / 2, 0)
				EndJoint.Size = Vector3.new(1, 1, 1)
				EndJoint.Name = "EndJoint"
				Model.Name = "Leaf" .. i
				table.insert(t, Model)
			end

			return t
		end

		local function v10(p12, p2, p3) --[[ GenerateStem | Line: 228 | Upvalues: CreatePart (ref), p1 (copy), v8 (ref), v7 (ref), v4 (copy), v9 (ref), CreateLeafStems (copy), CreateSpike (copy), v5 (ref), v10 (copy), v2 (copy), v6 (ref), FruitSpawnLocations (copy) ]]
			local v1 = CreatePart(p1, nil, "Studs")
			local sum = p3 * 0.03

			if p3 == 4 then
				v8 = -v8
			end

			if p3 > 4.5 then
				sum = sum - p3 * 0.02
			end

			local v3 = p12 * CFrame.Angles(math.rad(v7), 0, 0)

			v1.Size = Vector3.new(p2.X * 0.85, p2.Y * 1.05, p2.Z * 0.85)
			v1.CFrame = v3 * CFrame.new(0, v1.Size.Y * (v1.Size.Y * 0.075), 0)
			v1.Color = Color3.new(v4.R + sum, v4.G + sum, v4.B + sum)
			v7 = v7 - v9
			v9 = v9 - 6.5
			v1.Name = p3

			if p3 == 3 then
				for v72, v82 in CreateLeafStems(v1, p3) do
					local LeafStemReference = Instance.new("ObjectValue")

					LeafStemReference.Parent = v1
					LeafStemReference.Name = "LeafStemReference"
					LeafStemReference.Value = v82
				end
			end

			local v92 = p3 + 1
			local v13 = CreateSpike(v1.CFrame * CFrame.new(0, 0, v1.Size.Z / 2), v92, if v92 == 5 then Random.new(v5):NextNumber(1.8, 2.1) else Random.new(v5):NextNumber(1.1, 1.4))
			local Reference = Instance.new("ObjectValue")

			Reference.Parent = v1
			Reference.Name = "Reference"
			Reference.Value = v13

			local v14 = v1.CFrame * CFrame.new(0, v1.Size.Y / 2, 0)

			if v92 < 7 then
				v10(v14, v1.Size, v92)

				return
			end

			v1.Color = v4
			v2:PivotTo(v14 * CFrame.Angles(0, 1.5707963267948966, 0))
			v2:ScaleTo(v1.Size.Y * Random.new(v5):NextNumber(0.165, 0.2))
			v2.Parent = p1
			v2.Name = "PlantModel"

			for v15, v16 in v2:GetDescendants() do
				local v18 = tonumber(v16.Name)

				if v18 then
					v16.Name = v18 + v92 - 1
				end

				if v16.Name == "Teeth" then
					v6 = v6 + 1

					local v21 = v5

					v5 = math.clamp(v5 * math.random(1, (math.clamp(math.clamp(v5 + v6, 1, 100) * 100, 1, 10000))), 1, 9100000000000)

					if v5 == v21 then
						v5 = 3
					end

					math.randomseed(v5)
					v16:ScaleTo(Random.new(v5):NextNumber(0.65, 1.05))
				end
			end

			local Fruit_Spawn = v2:FindFirstChild("Fruit_Spawn")

			if not Fruit_Spawn then
				return
			end

			Fruit_Spawn.Parent = FruitSpawnLocations
		end

		local v11 = CreatePart(p1, nil, "Studs")
		local v12 = Vector3.new(v3, v3, v3)

		v11.CFrame = p1.Base.CFrame
		v11.Size = v12
		v11.Color = v4
		v11.Name = 1
		v10(v11.CFrame * CFrame.new(0, v3 / 2, 0), v12, 2)
		p1:ScaleTo((p3 or 1) * 0.25 + 0.75)
		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 329 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}

		for v1, v2 in p1:GetDescendants() do
			local v4 = tonumber(v2.Name)

			if v2:IsA("BasePart") and v4 then
				local t2 = {}

				for v5, v6 in v2:GetChildren() do
					if v6:IsA("Decal") or v6:IsA("Texture") then
						table.insert(t2, {
							decal = v6,
							originalTransparency = v6.Transparency
						})
						v6.Transparency = 1
					end
				end

				table.insert(t, {
					part = v2,
					maxSize = v2.Size,
					centerOffset = PrimaryPart.CFrame:ToObjectSpace(v2.CFrame),
					partAge = v4,
					decals = t2
				})
				v2.CanCollide = false
				v2.Transparency = 1
			end
		end

		local function updateGrowth() --[[ updateGrowth | Line: 359 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0

			for v2, v3 in t do
				local v5 = math.min(v1 - v3.partAge, 1)

				if v5 > 0 then
					local v6 = v3.maxSize.Y * v5

					v3.part.Size = Vector3.new(v3.maxSize.X, v6, v3.maxSize.Z)
					v3.part.CFrame = PrimaryPart.CFrame * v3.centerOffset * CFrame.new(0, -((v3.maxSize.Y - v6) / 2), 0)
					v3.part.Transparency = v3.part:GetAttribute("OG_Transparency") or 0
					v3.part.CanCollide = true

					for v8, v9 in v3.decals do
						v9.decal.Transparency = v9.originalTransparency + (1 - v9.originalTransparency) * (1 - v5)
					end

					continue
				end

				v3.part.Transparency = 1
				v3.part.CanCollide = false

				for v10, v11 in v3.decals do
					v11.decal.Transparency = 1
				end
			end

			if not game.Players.LocalPlayer or (not game:GetService("RunService"):IsClient() or (p1:GetAttribute("SetupIK") or not (p1:GetAttribute("MaxAge") <= v1))) then
				return
			end

			p1:SetAttribute("SetupIK", true)
			task.delay(1, function() --[[ Line: 392 | Upvalues: p1 (ref) ]]
				p1:AddTag("VenusFlyTrap")
			end)
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	Extras = {}
}