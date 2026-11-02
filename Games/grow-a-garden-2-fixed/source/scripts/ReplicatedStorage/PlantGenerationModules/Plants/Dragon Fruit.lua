--credit to prince games studio
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

		local function GetRandomHSV(p1, p2) --[[ GetRandomHSV | Line: 22 | Upvalues: v1 (copy) ]]
			local v12, v2, v3 = p1:ToHSV()
			local v4 = p2 or 0.05
			local v6 = math.clamp(v12 + v1:NextNumber(-v4, v4), 0, 0.99)

			return Color3.fromHSV(v6, v2, v3), v6, v2, v3
		end

		local v2, v3 = Color3.fromRGB(51, 136, 5)
		local v4, v5, v6 = v2:ToHSV()
		local v7 = v3 or 0.05

		Color3.fromHSV(math.clamp(v4 + v1:NextNumber(-v7, v7), 0, 0.99), v5, v6)

		local function CreatePart(p12, p2, p3) --[[ CreatePart | Line: 32 | Upvalues: p1 (copy), MaterialService (copy) ]]
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

		local function spawnTrunkTrusses(p12) --[[ spawnTrunkTrusses | Line: 62 | Upvalues: p1 (copy) ]]
			local Size = p12.Size
			local v1 = p12.CFrame
			local Y = Size.Y
			local v4 = math.max(1, (math.ceil(Size.X / 2)))
			local v7 = math.max(1, (math.ceil(Size.Z / 2)))

			local function spawnTruss(p13) --[[ spawnTruss | Line: 69 | Upvalues: Y (copy), p12 (copy), p1 (ref) ]]
				local TrussPart = Instance.new("TrussPart")

				TrussPart.Anchored = true
				TrussPart.Size = Vector3.new(2, Y, 2)
				TrussPart.CFrame = p13
				TrussPart:SetAttribute("TrunkReference", p12.Name)
				TrussPart:AddTag("PlantTruss")
				TrussPart.CanCollide = false
				TrussPart.Transparency = 1
				TrussPart.Parent = p1
			end

			local function spread(p1, p2) --[[ spread | Line: 81 ]]
				local t = {}

				if p1 == 1 then
					t[1] = 0

					return t
				end

				for i = 0, p1 - 1 do
					t[i + 1] = -p2 / 2 + 1 + i / (p1 - 1) * (p2 - 2)
				end

				return t
			end

			local v8 = spread(v4, Size.X)
			local v9 = spread(v7, Size.Z)

			for i, v in ipairs(v8) do
				local v10 = v1 * CFrame.new(v, 0, Size.Z / 2 - 0.8)
				local TrussPart = Instance.new("TrussPart")

				TrussPart.Anchored = true
				TrussPart.Size = Vector3.new(2, Y, 2)
				TrussPart.CFrame = v10
				TrussPart:SetAttribute("TrunkReference", p12.Name)
				TrussPart:AddTag("PlantTruss")
				TrussPart.CanCollide = false
				TrussPart.Transparency = 1
				TrussPart.Parent = p1

				local v11 = v1 * CFrame.new(v, 0, -Size.Z / 2 + 0.8)
				local TrussPart2 = Instance.new("TrussPart")

				TrussPart2.Anchored = true
				TrussPart2.Size = Vector3.new(2, Y, 2)
				TrussPart2.CFrame = v11
				TrussPart2:SetAttribute("TrunkReference", p12.Name)
				TrussPart2:AddTag("PlantTruss")
				TrussPart2.CanCollide = false
				TrussPart2.Transparency = 1
				TrussPart2.Parent = p1
			end

			for i, v in ipairs(v9) do
				local v12 = v1 * CFrame.new(Size.X / 2 - 0.8, 0, v)
				local TrussPart = Instance.new("TrussPart")

				TrussPart.Anchored = true
				TrussPart.Size = Vector3.new(2, Y, 2)
				TrussPart.CFrame = v12
				TrussPart:SetAttribute("TrunkReference", p12.Name)
				TrussPart:AddTag("PlantTruss")
				TrussPart.CanCollide = false
				TrussPart.Transparency = 1
				TrussPart.Parent = p1

				local v13 = v1 * CFrame.new(-Size.X / 2 + 0.8, 0, v)
				local TrussPart2 = Instance.new("TrussPart")

				TrussPart2.Anchored = true
				TrussPart2.Size = Vector3.new(2, Y, 2)
				TrussPart2.CFrame = v13
				TrussPart2:SetAttribute("TrunkReference", p12.Name)
				TrussPart2:AddTag("PlantTruss")
				TrussPart2.CanCollide = false
				TrussPart2.Transparency = 1
				TrussPart2.Parent = p1
			end
		end

		local sum = v1:NextInteger(9, 16)
		local v10 = (p3 or 1) * 0.25 + 0.75

		while v1:NextInteger(1, 70) == 1 do
			sum = sum * 3
		end

		local v11 = v1:NextNumber(3, 4) * v10
		local v13 = Vector3.new(v11, v1:NextNumber(1.5, 2) * v10, v11)
		local v14 = Base.CFrame
		local v15 = v1:NextNumber(5, 8)
		local v16 = 360 * v1:NextNumber(1.85, 2.75) / sum
		local v17, v18 = Color3.fromRGB(61, 146, 1)
		local v19, v20, v21 = v17:ToHSV()
		local v22 = v18 or 0.05
		local sum2, v26 = 0, Color3.fromHSV(math.clamp(v19 + v1:NextNumber(-v22, v22), 0, 0.99), v20, v21)

		repeat
			if v1:NextInteger(1, 4) ~= 1 then
				break
			end

			sum = sum + v1:NextInteger(2, 4)
		until sum > 25

		local v27 = Base.CFrame
		local v28, v29 = Color3.fromRGB(137, 59, 13)
		local v30, v31, v32 = v28:ToHSV()
		local v33 = v29 or 0.05
		local v36 = Color3.fromHSV(math.clamp(v30 + v1:NextNumber(-v33, v33), 0, 0.99), v31, v32)
		local v37, v38 = Color3.fromRGB(164, 96, 31)
		local v39, v40, v41 = v37:ToHSV()
		local v42 = v38 or 0.05
		local v46, v47, v48 = v36, sum / 2, Color3.fromHSV(math.clamp(v39 + v1:NextNumber(-v42, v42), 0, 0.99), v40, v41)

		for i = 1, sum do
			local v49 = script.Trunk:Clone()

			v49.Parent = p1
			v49.Size = v13

			local Angles = CFrame.Angles
			local v50 = math.rad(v15)
			local v51 = v1:NextNumber(-4, 4)

			v49.CFrame = v14 * Angles(0, v50, (math.rad(v51))) * CFrame.new(0, v13.Y / 2.2, 0)
			v49.Name = i
			v49.Color = v46:Lerp(v48, 1 - math.abs((i - v47) / v47))
			spawnTrunkTrusses(v49)

			local v52 = v13.X * 0.65
			local v58 = v14 * CFrame.new(math.cos((math.rad(sum2))) * v52, v13.Y / 2, math.sin((math.rad(sum2))) * v52)
			local Magnitude = (v27.Position - v58.Position).Magnitude
			local v59 = CreatePart(nil, "2022 Diamond Stud")
			local v60 = v1:NextNumber(0.7, 1.2) * v10

			v59.Size = Vector3.new(v60, Magnitude * 1.15, v60)
			v59.CFrame = CFrame.lookAt(v27.Position, v58.Position) * CFrame.new(0, 0, -Magnitude / 2) * CFrame.Angles(-1.5707963267948966, 0, 0)
			v59.Color = v26
			v59.Name = i + 1
			v14 = v49.CFrame * CFrame.new(0, v13.Y / 2, 0)
			sum2 = sum2 + v16

			if i == sum then
				local v61 = v1:NextInteger(12, 14)

				v27 = v58

				for j = 1, v61 do
					local v62 = script.Leaf:Clone()

					v62.Parent = p1
					v62:ScaleTo(v1:NextNumber(0.85, 1.1) * v10)

					local v63 = v14 * CFrame.Angles(0, math.rad(360 / v61 * j), 0) * CFrame.new(v13.X * 0.35, 0, 0)
					local Angles2 = CFrame.Angles

					v62:PivotTo(v63 * Angles2(0, 0, (math.rad(-v1:NextNumber(25, 40)))))

					for v65, v66 in v62:GetChildren() do
						if v66.Name == "FruitSpawn" then
							v66.CFrame = v66.CFrame * CFrame.new(0, v1:NextNumber(-2, 2), 0)
							v66.Parent = FruitSpawnLocations
						end

						local v68 = tonumber(v66.Name)

						if v68 then
							v66.Color = v26
							v66.Name = v68 + i
							v66.Parent = p1
						end
					end
				end

				continue
			end

			v27 = v58
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 197 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}
		local t2 = {}

		for v1, v2 in p1:GetDescendants() do
			if v2:IsA("BasePart") and v2:HasTag("PlantTruss") then
				table.insert(t, v2)

				continue
			end

			local v4 = tonumber(v2.Name)

			if (v2:IsA("BasePart") or v2:IsA("MeshPart")) and v4 then
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

		local function updateGrowth() --[[ updateGrowth | Line: 220 | Upvalues: p1 (copy), t2 (copy), PrimaryPart (copy), t (copy) ]]
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