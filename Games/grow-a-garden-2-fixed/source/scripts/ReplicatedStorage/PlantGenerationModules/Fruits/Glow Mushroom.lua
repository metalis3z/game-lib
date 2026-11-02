--credit to leon games studio
game:GetService("MaterialService")

return {
	GrowData = {
		GrowRate = 0.05,
		BaseWeight = 7,
		GrowTickTime = NumberRange.new(4.8, 6)
	},
	InitFruit = function(p1, p2, p3) --[[ InitFruit | Line: 10 ]]
		local MaterialService = game:GetService("MaterialService")
		local v1 = p3 or 1
		local v2 = Random.new(p2)

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

		local function CreateStem(p12, p2, p3, p4, p5) --[[ CreateStem | Line: 61 | Upvalues: CreatePart (copy), v2 (copy), v3 (copy), p1 (copy), v10 (copy) ]]
			local Y = p2.Y
			local X = p2.X
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
				p3 = v32.CFrame * CFrame.new(0, p2.Y / 2.2, 0)
				v1 = math.clamp(v1 * 1.15, 0, Y * 2)

				if i == p12 then
					local v8 = script.MushroomTop:Clone()

					v8.Parent = p1
					v22 = i == p12 and v2:NextNumber(0.65, 0.75) or v2:NextNumber(0.19, 0.27)
					v8:ScaleTo(v22 * (X * 0.85))
					v8:PivotTo(p3)

					for v9, v102 in v8:GetChildren() do
						local v12 = tonumber(v102.Name)

						if v12 then
							if v12 > 1 then
								v102.Color = v10
							end

							if v12 == 3 then
								local Angles2 = CFrame.Angles

								v102.CFrame = v102.CFrame * Angles2(0, math.rad((v2:NextNumber(-10, 10))), 0)
							end

							if v12 > 1 and i == p12 then
								local v15 = 90

								for j = 1, 2 do
									for k = 1, v2:NextInteger(3, 6) do
										local v16 = v2:NextNumber(p2.X * 0.08, p2.X * 0.1)
										local v17 = CreatePart()
										local t = {
											X = 0,
											Y = v2:NextNumber(-v102.Size.Y, v102.Size.Y) * 0.35,
											Z = v2:NextNumber(-v102.Size.Z, v102.Size.Z) * 0.3
										}

										v17.Material = Enum.Material.Neon
										v17.Size = Vector3.new(v16, v102.Size.Z + 0.1, v16)
										v17.CFrame = v102.CFrame * CFrame.Angles(0, math.rad(v15), 0) * CFrame.new(t.X, t.Y, t.Z) * CFrame.Angles(0, 0, 1.5707963267948966)
										v17.Color = Color3.fromRGB(180, 170, 158)
										v17.Name = i + p4 + v12 + 1
									end

									v15 = v15 * 2
								end
							end

							v102.Name = v12 + i + p4
							v102.Parent = p1
						end
					end
				end

				p2 = Vector3.new(p2.X * 0.75, v1, p2.Z * 0.75)
			end
		end

		local v11 = v2:NextNumber(1.1, 1.2) * v1
		local v12 = v2:NextNumber(1.7, 1.8) * v1

		CreateStem(math.floor((math.clamp(2 * v1, 2, 3))), Vector3.new(v11, v12, v11), p1.Base.CFrame, 0, true)
		p1:AddTag("InitializationComplete")
	end,
	BeginFruitGrowth = function(p1) --[[ BeginFruitGrowth | Line: 148 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}

		for v1, v2 in p1:GetDescendants() do
			local v4 = tonumber(v2.Name)

			if (v2:IsA("BasePart") or v2:IsA("MeshPart")) and v4 then
				local v5 = not v2:GetAttribute("DontShow")
				local t2 = {}

				for v6, v7 in v2:GetChildren() do
					if v7:IsA("Decal") or v7:IsA("Texture") then
						table.insert(t2, {
							decal = v7,
							originalTransparency = v7.Transparency
						})

						if v5 then
							v7.Transparency = 1
						end
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

				if v5 then
					v2.Transparency = 1
				end
			end
		end

		local function updateGrowth() --[[ updateGrowth | Line: 183 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0
			local v2 = p1:GetAttribute("MaxAge") or 1
			local v3 = v1 / v2

			for v4, v5 in t do
				if not v5.part:GetAttribute("DontShow") then
					local v7 = math.clamp((v3 - v5.partAge / v2) * v2, 0, 1)

					if v7 > 0 then
						local v8 = v5.maxSize * v7

						v5.part.Size = v8
						v5.part.CFrame = PrimaryPart.CFrame * v5.centerOffset * CFrame.new(0, -((v5.maxSize.Y - v8.Y) / 2), 0)
						v5.part.Transparency = v5.part:GetAttribute("OG_Transparency") or 0
						v5.part.CanCollide = true

						for v10, v11 in v5.decals do
							v11.decal.Transparency = v11.originalTransparency + (1 - v11.originalTransparency) * (1 - v7)
						end

						continue
					end

					v5.part.Transparency = 1
					v5.part.CanCollide = false

					for v12, v13 in v5.decals do
						v13.decal.Transparency = 1
					end
				end
			end
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	OnFullyGrown = function(p1) --[[ OnFullyGrown | Line: 218 ]]
		local v1 = p1:GetAttribute("CorePartName")

		if v1 then
			local v2 = p1:FindFirstChild(v1)

			if v2 then
				local Collect_PROX_Apple = game.ServerStorage:FindFirstChild("Collect_PROX_Apple")

				if Collect_PROX_Apple then
					local ProximityPrompt = Collect_PROX_Apple:Clone()

					ProximityPrompt.Name = "ProximityPrompt"
					ProximityPrompt.Parent = v2
				end
			end
		end

		p1:AddTag("PlantGenerated")
	end,
	Extras = {
		FruitType = "Glow Mushroom",
		Harvestable = true
	}
}