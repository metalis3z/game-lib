--credit to leon games studio
game:GetService("MaterialService")

return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 9 ]]
		local MaterialService = game:GetService("MaterialService")
		local v1 = p3 or 1
		local v2 = Random.new(p2)
		local Base = p1.Base

		local function GetRandomHSV(p1, p2) --[[ GetRandomHSV | Line: 20 | Upvalues: v2 (copy) ]]
			local v1, v22, v3 = p1:ToHSV()
			local v4 = p2 or 0.05
			local v6 = math.clamp(v1 + v2:NextNumber(-v4, v4), 0, 0.99)

			return Color3.fromHSV(v6, v22, v3), v6, v22, v3
		end

		local v3, v4 = Color3.fromRGB(51, 136, 5)
		local v5, v6, v7 = v3:ToHSV()
		local v8 = v4 or 0.05

		Color3.fromHSV(math.clamp(v5 + v2:NextNumber(-v8, v8), 0, 0.99), v6, v7)

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

			for k, v in pairs(script:GetChildren()) do
				if v:IsA("Texture") then
					v:Clone().Parent = Part
				end
			end

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

		local v11 = v2:NextNumber(2.5, 2.9) * v1
		local v12 = v11 * 0.85
		local sum = v2:NextInteger(6, 9)

		if v2:NextInteger(1, 12) == 1 then
			sum = sum + v2:NextInteger(4, 10)
		end

		local v13 = Vector3.new(v11, v12, v11)
		local v14 = Vector3.new(v11 * 0.325, v12 * 1.15, v11 * 0.325)
		local v15 = Base.CFrame
		local t = {
			Start = Color3.fromRGB(142, 176, 204),
			End = Color3.fromRGB(99, 255, 246)
		}
		local v16 = v2:NextNumber(3.75, 6.75)

		if v2:NextInteger(1, 15) == 1 then
			v16 = v2:NextNumber(6.5, 10)
		end

		local function GenerateDownwardsStem(p1, p2, p3) --[[ GenerateDownwardsStem | Line: 92 | Upvalues: v2 (copy), v1 (ref), Base (copy), CreatePart (copy), t (copy) ]]
			local v12 = p1 * CFrame.Angles(math.pi, 0, 0)
			local v22 = v2:NextNumber(0.8, 1) * v1
			local v3 = v2:NextNumber(2, 2.7) * v1
			local Y = v12.Position.Y
			local v4 = Vector3.new(v22, v3, v22)
			local count = 0
			local t2 = {}

			while Base.Position.Y < Y do
				local v5 = CreatePart(nil, "2022 Stud Space")
				local v7 = math.rad((v2:NextNumber(p2[1], p2[2])))

				if v2:NextInteger(1, 3) == 1 then
					v7 = v7 * 2
				end

				if count == 1 and v2:NextNumber(1, 2) == 1 then
					v7 = -v7
				end

				count = count + 1
				v5.Size = v4
				v5.CFrame = v12 * CFrame.Angles(0, 0, v7) * CFrame.new(0, v5.Size.Y / 2.3, 0)
				v5.Color = t.Start
				v5.Name = count + 2
				Y = v5.Position.Y
				v12 = v5.CFrame * CFrame.new(0, v5.Size.Y / 2.3, 0)

				local v8 = v4.X * v2:NextNumber(1.15, 1.325)
				local v10 = Vector3.new(v8, v4.Y * v2:NextNumber(1.05, 1.25), v8)

				table.insert(t2, v5)
				v4 = v10
			end

			for v11, v122 in t2 do
				v122.Color = t.Start:Lerp(p3, tonumber(v122.Name) / #t2)
			end
		end

		local sum2 = v2:NextNumber(-180, 180)
		local identity = CFrame.identity
		local v18 = v2:NextNumber(-180, 180)
		local v19 = 450 / (sum - 2)
		local v20 = Vector3.new(0.2, 0, 0.2) * v1
		local v21 = Vector3.new(1.3, 0, 1.3) * v1

		for i = 1, sum do
			local v22 = CreatePart(nil, "2022 Stud Space")
			local v23 = i / sum
			local t2 = {}

			t2.X = math.rad((v2:NextNumber(-v16, v16)))
			t2.Y = math.rad((v2:NextNumber(-1.5, 1.5)))
			t2.Z = math.rad((v2:NextNumber(-v16, v16)))
			v22.Size = v13:Lerp(v14, v23)
			v22.CFrame = v15 * CFrame.Angles(t2.X, t2.Y, t2.Z) * CFrame.new(0, v22.Size.Y / 2.15, 0)
			v22.Color = t.Start:Lerp(t.End, v23)
			v22.Name = i

			if i >= 3 then
				if i == 3 then
					identity = v22.CFrame
				end

				local v27 = i == 3 and v22.Size.X * 1.15 or v22.Size.X * 1.5
				local v28 = v18 + v19 * (i - 2)
				local v34 = v22.CFrame * CFrame.new(math.cos((math.rad(v28))) * v27, 0, math.sin((math.rad(v28))) * v27)
				local Magnitude = (identity.Position - v34.Position).Magnitude
				local v35 = (i - 2) / sum
				local v36 = CreatePart(nil, "2022 Stud Space")

				v36.Size = v21:Lerp(v20, v35) + Vector3.new(0, 1, 0) * Magnitude
				v36.CFrame = CFrame.lookAt(identity.Position, v34.Position) * CFrame.new(0, 0, -Magnitude / 2) * CFrame.Angles(-1.5707963267948966, 0, 0)
				v36.Color = t.Start:Lerp(t.End, v35)
				v36.Name = i + 1
				identity = v34
			end

			if i == 2 then
				local v37 = v2:NextInteger(3, 5)

				for j = 1, v37 do
					local v38 = 360 / v37 * (j * v2:NextNumber(0.9, 1.1))
					local v39 = v22.CFrame * CFrame.Angles(0, math.rad(v38), 0)
					local Angles = CFrame.Angles

					GenerateDownwardsStem(v39 * Angles(0, 0, (math.rad((v2:NextNumber(80, 90))))), { 9, 18 }, v22.Color)

					local v41 = script.Leaf:Clone()

					v41.Parent = p1

					local v42 = Base.CFrame * CFrame.Angles(0, math.rad(v38 + 45), 0) * CFrame.new(0, 0, -v13.Z / 2)
					local Angles2 = CFrame.Angles

					v41:PivotTo(v42 * Angles2(math.rad((v2:NextNumber(-35, -60))), 0, 0))
					v41.Name = 1
				end
			end

			if i > 2 and i < sum then
				local v44 = script.BigLeaf:Clone()

				v44.Parent = p1
				v44:ScaleTo(v1)

				local v45 = v22.CFrame * CFrame.Angles(0, math.rad(sum2), 0)
				local Angles = CFrame.Angles
				local v46 = v2:NextNumber(-110, -125)

				v44:PivotTo(v45 * Angles(math.rad(v46), 0, 0) * CFrame.new(0, v22.Size.Z / 2.25, 0))
				sum2 = sum2 + v2:NextNumber(45, 115)

				for v47, v48 in v44:GetChildren() do
					local v50 = tonumber(v48.Name)

					if v50 then
						v48.Name = v50 + i
						v48.Parent = p1
					end
				end

				v44:Destroy()
			end

			v15 = v22.CFrame * CFrame.new(0, v22.Size.Y / 2.15, 0)
		end

		local v51 = CreatePart()

		for k, v in pairs(v51:GetChildren()) do
			v:Destroy()
		end

		v51.Size = Vector3.new(1, 1, 1)
		v51.CFrame = v15
		v51.Parent = p1.FruitSpawnLocations
		v51.Transparency = 1
		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 241 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 276 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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
	Extras = {}
}