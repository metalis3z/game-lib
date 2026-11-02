--credit to quartz games studio
game:GetService("MaterialService")

return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 9 ]]
		local MaterialService = game:GetService("MaterialService")
		local v1 = p3 or 1
		local v2 = Random.new(p2)
		local FruitSpawnLocations = p1.FruitSpawnLocations

		local function GetRandomHSV(p1, p2) --[[ GetRandomHSV | Line: 20 | Upvalues: v2 (copy) ]]
			local v1, v22, v3 = p1:ToHSV()
			local v4 = p2 or 0.05
			local v6 = math.clamp(v1 + v2:NextNumber(-v4, v4), 0, 0.99)

			return Color3.fromHSV(v6, v22, v3), v6, v22, v3
		end

		local v3 = Color3.fromRGB(180, 170, 158)
		local v4, v5, v6 = Color3.fromRGB(100, 0, 192):ToHSV()
		local v7 = 0.1 or 0.05
		local v10 = Color3.fromHSV(math.clamp(v4 + v2:NextNumber(-v7, v7), 0, 0.99), v5, v6)

		local function CreatePart(p12, p2, p3) --[[ CreatePart | Line: 31 | Upvalues: p1 (copy), MaterialService (copy) ]]
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

		local v11 = 0.8

		local function v12(p12, p2, p3, p4, p5) --[[ CreateStem | Line: 63 | Upvalues: CreatePart (copy), v2 (copy), v3 (copy), FruitSpawnLocations (copy), p1 (copy), v10 (copy), v12 (copy), v11 (ref) ]]
			local Y = p2.Y
			local v1 = Y

			for i = 1, p12 do
				local v22
				local v32 = CreatePart(nil, "2022 Inlet")

				v32.Size = p2

				local Angles = CFrame.Angles
				local v5 = math.rad((v2:NextNumber(-6, 6)))
				local v6 = v2:NextNumber(-6, 6)

				v32.CFrame = p3 * Angles(v5, 0.2617993877991494, (math.rad(v6))) * CFrame.new(0, p2.Y / 2.2, 0)
				v32.Color = v3
				v32.Name = tostring(i + p4)

				if p5 and i ~= p12 then
					local v7 = CreatePart()

					v7.Parent = FruitSpawnLocations

					local v8 = v32.CFrame * CFrame.new(0, p2.Y / 2, 0)
					local Angles2 = CFrame.Angles

					v7.CFrame = v8 * Angles2(0, math.rad((v2:NextNumber(-180, 180))), 0.7853981633974483)
					v7.Size = Vector3.new(1, 1, 1)
					v7.Transparency = 1
				end

				p3 = v32.CFrame * CFrame.new(0, p2.Y / 2.2, 0)

				local v102 = math.clamp(v1 * 1.15, 0, Y * 2)

				if v2:NextInteger(1, 4) == 1 or i == p12 then
					local v112 = script.MushroomTop:Clone()

					v112.Parent = p1
					v1 = v102
					v22 = i == p12 and v2:NextNumber(0.65, 0.75) or v2:NextNumber(0.19, 0.27)
					v112:ScaleTo(v22 * p2.X)
					v112:PivotTo(p3)

					if i ~= p12 then
						v112["3"]:Destroy()
					end

					for v122, v13 in v112:GetChildren() do
						local v15 = tonumber(v13.Name)

						if v15 then
							if v15 > 1 then
								v13.Color = v10
							end

							if v15 == 3 then
								local Angles2 = CFrame.Angles

								v13.CFrame = v13.CFrame * Angles2(0, math.rad((v2:NextNumber(-10, 10))), 0)
							end

							if v15 > 1 and i == p12 then
								local v18 = 90

								for j = 1, 2 do
									for k = 1, v2:NextInteger(3, 6) do
										local v19 = v2:NextNumber(p2.X * 0.15, p2.X * 0.2)
										local v20 = CreatePart()
										local t = {
											X = 0,
											Y = v2:NextNumber(-v13.Size.Y, v13.Size.Y) * 0.35,
											Z = v2:NextNumber(-v13.Size.Z, v13.Size.Z) * 0.3
										}

										v20.Material = Enum.Material.Neon
										v20.Size = Vector3.new(v19, v13.Size.Z + 0.2, v19)
										v20.CFrame = v13.CFrame * CFrame.Angles(0, math.rad(v18), 0) * CFrame.new(t.X, t.Y, t.Z) * CFrame.Angles(0, 0, 1.5707963267948966)
										v20.Color = Color3.fromRGB(180, 170, 158)
										v20.Name = i + p4 + v15 + 1
									end

									v18 = v18 * 2
								end
							end

							v13.Name = v15 + i + p4
							v13.Parent = p1
						end
					end
				else
					v1 = v102
				end

				if v2:NextInteger(1, 5) == 1 and (p5 and i ~= p12) then
					v12(v2:NextInteger(2, 3), Vector3.new(p2.X, p2.Y * 0.75, p2.Z) * 0.7, p3 * CFrame.Angles(0, math.rad((v2:NextNumber(-180, 180))), 0.7853981633974483), i)
				end

				p2 = Vector3.new(p2.X * v11, v1, p2.Z * v11)
			end
		end

		local v13 = v2:NextNumber(1.9, 2.3) * v1
		local v14 = v2:NextNumber(4.5, 6) * v1
		local v15 = v2:NextInteger(3, 4)

		while v2:NextInteger(1, 100) == 1 do
			v15 = v15 * 2
			v13 = v13 * 2
			v11 = 0.9
		end

		v12(v15, Vector3.new(v13, v14, v13), p1.Base.CFrame, 0, true)
		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 173 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 191 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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