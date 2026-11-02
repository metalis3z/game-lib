--credit to leon games studio
local v1 = game.ReplicatedStorage.Assets["Meshes/BeanStalkMesh"]
local Stud_Part = script.Stud_Part

return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 9 | Upvalues: v1 (copy), Stud_Part (copy) ]]
		local v12 = p3 or 1
		local v2 = Random.new(p2)
		local FruitSpawnLocations = p1.FruitSpawnLocations
		local Base = p1.Base
		local CollectionService = game:GetService("CollectionService")
		local v3 = 3 * v12 * v2:NextInteger(7, 14) * 0.1
		local v4 = 2 * v12 * v2:NextInteger(7, 14) * 0.1
		local sum = math.sqrt((math.clamp(v12 * v2:NextInteger(7, 14) * 0.1, 1, (1 / 0)))) * 30
		local count = 0

		while v2:NextInteger(1, 10) == 1 do
			sum = sum + 5
		end

		local v7 = 3 * v2:NextInteger(7, 14) * 0.1
		local v8 = Base.CFrame * CFrame.new(0, -Base.Size.Y / 2, 0)
		local v9 = 3 * v2:NextInteger(7, 14) * 0.1 * v12
		local v10 = v2:NextInteger(950, 995) * 0.001
		local v11, v122, v13, sum2 = v3, v4, {}, 0

		for i = 1, sum do
			local v14

			count = count + 1
			v11 = v11 * v10
			v122 = v122 * v10

			local v15 = i * 0.1 % 2

			v14 = if v15 <= 1 then v15 else 2 - v15
			sum2 = sum2 + 10

			local v16 = math.rad(sum2)
			local v17 = CFrame.new(math.cos(v16) * v9, 0, math.sin(v16) * v9)
			local v18 = v1:Clone()

			v18.Size = Vector3.new(v11 * 2, v122 * 1.25, v11 * 2)
			v18.Color = Color3.fromHSV(0.24500000000000002 + v14 * 0.025, 0.5 + v14 * 0.175, 0.5 + v14 * 0.25)
			v18.CFrame = v8 * v17 * CFrame.new(0, v18.Size.Y / 2, 0)
			v18.Name = tostring(count)
			v18.Parent = p1

			if count % 2 == 0 then
				table.insert(v13, v18)
			end

			v8 = v8 * CFrame.new(0, v122, 0) * CFrame.Angles(math.rad(-1 + v14 * 2), math.rad(v7), (math.rad(-1 + v14 * 2)))
		end

		local function attachWedges(p12) --[[ attachWedges | Line: 73 | Upvalues: count (ref), Stud_Part (ref), p1 (copy), CollectionService (copy) ]]
			count = count + 1

			local v1 = Stud_Part:Clone()

			v1.Anchored = true
			v1.Shape = Enum.PartType.Wedge
			v1.Size = Vector3.new(p12.Size.Z, p12.Size.Y * 0.5, p12.Size.X / 2)
			v1.CFrame = p12.CFrame * CFrame.new(-p12.Size.X / 4, -(p12.Size.Y / 2 + v1.Size.Y / 2), 0)
			v1.CFrame = v1.CFrame * CFrame.Angles(0, 1.5707963267948966, 0)
			v1.CFrame = v1.CFrame * CFrame.Angles(0, 0, math.pi)
			v1.Color = p12.Color
			v1.Name = tostring(count)
			v1.Parent = p1
			CollectionService:AddTag(v1, "DetailPart")

			local v5 = Stud_Part:Clone()

			v5.Shape = Enum.PartType.Wedge
			v5.Size = Vector3.new(p12.Size.Z, p12.Size.Y * 0.5, p12.Size.X / 2)
			v5.CFrame = p12.CFrame * CFrame.new(p12.Size.X / 4, -(p12.Size.Y / 2 + v5.Size.Y / 2), 0)
			v5.CFrame = v5.CFrame * CFrame.Angles(0, -1.5707963267948966, 0)
			v5.CFrame = v5.CFrame * CFrame.Angles(0, 0, math.pi)
			v5.Color = p12.Color
			v5.Name = tostring(count)
			v5.Parent = p1
			CollectionService:AddTag(v5, "DetailPart")
		end

		for j = #v13, 1, -1 do
			local v19 = v13[j]

			count = count + 1

			local v20 = v19.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
			local v22 = v20 * CFrame.Angles(0, 0, (math.rad((v2:NextInteger(-180, 180)))))
			local v24 = v22 * CFrame.Angles(math.rad(-v2:NextInteger(30, 45)), 0, 0)
			local Magnitude = v19.Size.Magnitude
			local v25 = Stud_Part:Clone()

			v25.Color = v19.Color
			v25.Size = Vector3.new(1 * (Magnitude * 0.2), v2:NextInteger(17, 21) * 0.1 * (Magnitude * 0.34), 2)
			v25.CFrame = v24 * CFrame.new(0, v25.Size.Y / 2, 0)
			v25.Name = tostring(count)
			v25.Parent = p1
			count = count + 1

			local v28 = v2:NextInteger(27, 30) * 0.1
			local v29 = Stud_Part:Clone()

			v29.Color = v19.Color
			v29.Size = Vector3.new(v28 * (Magnitude * 0.2), v28 * (Magnitude * 0.2), 2)
			v29.CFrame = v25.CFrame * CFrame.new(0, v25.Size.Y / 2 + v29.Size.Y / 2, 0) * CFrame.Angles(math.pi, 0, 0)
			v29.Name = tostring(count)
			v29.Parent = p1
			CollectionService:AddTag(v29, "DetailPart")
			attachWedges(v29)
			v29.CFrame = v29.CFrame * CFrame.Angles(math.pi, 0, 0)

			local FruitSpawn = Stud_Part:Clone()

			FruitSpawn.CanCollide = false
			FruitSpawn.Transparency = 1
			FruitSpawn.Size = Vector3.new(0.1, 0.1, 0.1)
			FruitSpawn.CFrame = CFrame.new((v29.CFrame * CFrame.new(0, 0, v29.Size.Z / 2)).Position) * CFrame.Angles(-1.5707963267948966, 0, 0)
			FruitSpawn.Orientation = Vector3.new(FruitSpawn.Orientation.X, -v25.Orientation.Y, FruitSpawn.Orientation.Z)
			FruitSpawn.Parent = FruitSpawnLocations
			FruitSpawn.Name = "FruitSpawn"
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 155 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 171 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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

			if not game.Players.LocalPlayer or (not game:GetService("RunService"):IsClient() or (p1:GetAttribute("playedSfx") or not (p1:GetAttribute("MaxAge") <= v1))) then
				return
			end

			p1:SetAttribute("playedSfx", true)
			game.SoundService:PlayLocalSound(game.SoundService.SFX.Happy)
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	Extras = {}
}